using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace MealPlannerApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class VulnerableController : ControllerBase
{
    private readonly ILogger<VulnerableController> _logger;

    public VulnerableController(ILogger<VulnerableController> logger)
    {
        _logger = logger;
    }

    // SQL Injection vulnerability
    [HttpGet("user/{username}")]
    public IActionResult GetUser(string username)
    {
        var connectionString = "Server=myserver;Database=mydb;User Id=sa;Password=admin123;";
        using var connection = new SqlConnection(connectionString);
        connection.Open();
        
        // Vulnerable: Direct string concatenation in SQL query
        var query = $"SELECT * FROM Users WHERE Username = '{username}'";
        var command = new SqlCommand(query, connection);
        var reader = command.ExecuteReader();
        
        return Ok("User found");
    }

    // Hardcoded credentials
    [HttpPost("login")]
    public IActionResult Login([FromBody] LoginRequest request)
    {
        // Vulnerable: Hardcoded credentials
        const string adminPassword = "SuperSecret123!";
        const string apiKey = "sk_live_51234567890abcdef";
        
        if (request.Password == adminPassword)
        {
            return Ok(new { token = apiKey });
        }
        
        return Unauthorized();
    }

    // Weak cryptography
    [HttpPost("encrypt")]
    public IActionResult EncryptData([FromBody] string data)
    {
        // Vulnerable: Using weak MD5 algorithm
        using var md5 = MD5.Create();
        var hash = md5.ComputeHash(Encoding.UTF8.GetBytes(data));
        return Ok(Convert.ToBase64String(hash));
    }

    // Path traversal vulnerability
    [HttpGet("file/{filename}")]
    public IActionResult GetFile(string filename)
    {
        // Vulnerable: No validation on filename
        var filePath = Path.Combine("uploads", filename);
        
        if (System.IO.File.Exists(filePath))
        {
            var content = System.IO.File.ReadAllText(filePath);
            return Ok(content);
        }
        
        return NotFound();
    }

    // Command injection vulnerability
    [HttpPost("ping")]
    public IActionResult PingHost([FromBody] string host)
    {
        // Vulnerable: User input directly in command
        var process = new System.Diagnostics.Process();
        process.StartInfo.FileName = "ping";
        process.StartInfo.Arguments = host;
        process.Start();
        
        return Ok("Ping started");
    }

    // Insecure deserialization
    [HttpPost("deserialize")]
    public IActionResult DeserializeData([FromBody] string serializedData)
    {
        // Vulnerable: Deserializing untrusted data
        var bytes = Convert.FromBase64String(serializedData);
#pragma warning disable SYSLIB0011
        var formatter = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
        using var stream = new MemoryStream(bytes);
        var obj = formatter.Deserialize(stream);
#pragma warning restore SYSLIB0011
        
        return Ok(obj);
    }

    // Information disclosure
    [HttpGet("debug")]
    public IActionResult Debug()
    {
        // Vulnerable: Exposing sensitive information
        var config = new
        {
            DatabasePassword = "MySecretDbPassword123",
            AwsAccessKey = "AKIAIOSFODNN7EXAMPLE",
            AwsSecretKey = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
            JwtSecret = "my-super-secret-jwt-key-12345",
            ConnectionString = "Server=prod-db;Database=main;User Id=admin;Password=Pr0dP@ssw0rd;"
        };
        
        return Ok(config);
    }

    // Unvalidated redirect
    [HttpGet("redirect")]
    public new IActionResult Redirect(string url)
    {
        // Vulnerable: Open redirect
        return Redirect(url);
    }

    // XSS vulnerability (stored in response)
    [HttpGet("message")]
    public IActionResult GetMessage(string text)
    {
        // Vulnerable: No encoding of user input
        return Content($"<html><body><h1>Your message: {text}</h1></body></html>", "text/html");
    }
}

public class LoginRequest
{
    public string Username { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
}
