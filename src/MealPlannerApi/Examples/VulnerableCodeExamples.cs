using Microsoft.Data.Sqlite;
using System.Data;

namespace MealPlannerApi.Examples;

/// <summary>
/// INTENTIONALLY VULNERABLE CODE FOR GHAS DEMONSTRATION
/// This file contains security vulnerabilities that CodeQL will detect.
/// DO NOT USE THESE PATTERNS IN PRODUCTION CODE!
/// </summary>
public class VulnerableCodeExamples
{
    // ⚠️ VULNERABILITY 1: SQL Injection
    // CodeQL will flag this as CWE-89: SQL Injection
    public List<string> GetRecipesByNameVulnerable(string recipeName)
    {
        var results = new List<string>();
        var connectionString = "Data Source=mealplanner.db";

        using var connection = new SqliteConnection(connectionString);
        connection.Open();

        // VULNERABLE: Direct string concatenation creates SQL injection risk
        var query = $"SELECT * FROM Recipes WHERE Name = '{recipeName}'";

        using var command = new SqliteCommand(query, connection);
        using var reader = command.ExecuteReader();

        while (reader.Read())
        {
            results.Add(reader["Name"].ToString() ?? "");
        }

        return results;
    }

    // ✅ SECURE VERSION: Use parameterized queries
    public List<string> GetRecipesByNameSecure(string recipeName)
    {
        var results = new List<string>();
        var connectionString = "Data Source=mealplanner.db";

        using var connection = new SqliteConnection(connectionString);
        connection.Open();

        // SECURE: Using parameterized query
        var query = "SELECT * FROM Recipes WHERE Name = @recipeName";

        using var command = new SqliteCommand(query, connection);
        command.Parameters.AddWithValue("@recipeName", recipeName);

        using var reader = command.ExecuteReader();

        while (reader.Read())
        {
            results.Add(reader["Name"].ToString() ?? "");
        }

        return results;
    }

    // ⚠️ VULNERABILITY 2: Path Traversal
    // CodeQL will flag this as CWE-22: Path Traversal
    public string ReadRecipeFileVulnerable(string filename)
    {
        // VULNERABLE: No validation allows path traversal attacks
        // Attacker could use: ../../../../etc/passwd
        var filePath = Path.Combine("recipes", filename);
        return File.ReadAllText(filePath);
    }

    // ✅ SECURE VERSION: Validate and sanitize file paths
    public string ReadRecipeFileSecure(string filename)
    {
        // SECURE: Validate filename and prevent directory traversal
        if (filename.Contains("..") || filename.Contains("/") || filename.Contains("\\"))
        {
            throw new ArgumentException("Invalid filename");
        }

        var recipesDirectory = Path.GetFullPath("recipes");
        var filePath = Path.Combine(recipesDirectory, filename);
        var fullPath = Path.GetFullPath(filePath);

        // Ensure the resolved path is still within the recipes directory
        if (!fullPath.StartsWith(recipesDirectory))
        {
            throw new UnauthorizedAccessException("Access denied");
        }

        return File.ReadAllText(fullPath);
    }

    // ⚠️ VULNERABILITY 3: Command Injection
    // CodeQL will flag this as CWE-78: Command Injection
    public string ExecuteCommandVulnerable(string recipeId)
    {
        // VULNERABLE: Direct command execution with user input
        var process = new System.Diagnostics.Process();
        process.StartInfo.FileName = "cmd.exe";
        process.StartInfo.Arguments = $"/c type recipe_{recipeId}.txt";
        process.StartInfo.RedirectStandardOutput = true;
        process.Start();
        return process.StandardOutput.ReadToEnd();
    }

    // ✅ SECURE VERSION: Avoid command execution, use file APIs
    public string GetRecipeContentSecure(string recipeId)
    {
        // SECURE: Use file APIs instead of shell commands
        // Validate input
        if (!int.TryParse(recipeId, out _))
        {
            throw new ArgumentException("Invalid recipe ID");
        }

        var filename = $"recipe_{recipeId}.txt";
        var safePath = Path.Combine("recipes", filename);

        if (!File.Exists(safePath))
        {
            throw new FileNotFoundException("Recipe not found");
        }

        return File.ReadAllText(safePath);
    }

    // ⚠️ VULNERABILITY 4: Weak Cryptography
    // CodeQL will flag this as CWE-327: Use of Broken Crypto
    public string HashPasswordVulnerable(string password)
    {
        // VULNERABLE: MD5 is cryptographically broken
        using var md5 = System.Security.Cryptography.MD5.Create();
        var inputBytes = System.Text.Encoding.UTF8.GetBytes(password);
        var hashBytes = md5.ComputeHash(inputBytes);
        return Convert.ToHexString(hashBytes);
    }

    // ✅ SECURE VERSION: Use modern password hashing
    public string HashPasswordSecure(string password)
    {
        // SECURE: Use BCrypt or Argon2 for password hashing
        // Or use ASP.NET Core Identity's built-in hashing
        // This is a simplified example - use a proper library in production
        using var sha256 = System.Security.Cryptography.SHA256.Create();
        var saltedPassword = password + "random-salt-per-user";
        var inputBytes = System.Text.Encoding.UTF8.GetBytes(saltedPassword);
        var hashBytes = sha256.ComputeHash(inputBytes);

        // In production, use BCrypt.Net or similar:
        // return BCrypt.Net.BCrypt.HashPassword(password);

        return Convert.ToBase64String(hashBytes);
    }

    // ⚠️ VULNERABILITY 5: Insecure Deserialization
    // CodeQL will flag this as CWE-502: Deserialization of Untrusted Data
    public object DeserializeRecipeVulnerable(string jsonData)
    {
        // VULNERABLE: Deserializing untrusted data with type handling
        var settings = new Newtonsoft.Json.JsonSerializerSettings
        {
            TypeNameHandling = Newtonsoft.Json.TypeNameHandling.All
        };

        // This allows arbitrary code execution
        return Newtonsoft.Json.JsonConvert.DeserializeObject(jsonData, settings)!;
    }

    // ✅ SECURE VERSION: Use safe deserialization
    public T DeserializeRecipeSecure<T>(string jsonData) where T : class
    {
        // SECURE: Deserialize to a specific known type
        var options = new System.Text.Json.JsonSerializerOptions
        {
            PropertyNameCaseInsensitive = true
        };

        return System.Text.Json.JsonSerializer.Deserialize<T>(jsonData, options)
            ?? throw new InvalidOperationException("Deserialization failed");
    }

    // ⚠️ VULNERABILITY 6: Hard-coded Credentials
    // CodeQL will flag this as CWE-798: Hard-coded Credentials
    public string GetDatabaseConnectionVulnerable()
    {
        // VULNERABLE: Hard-coded credentials
        return "Server=localhost;Database=MealPlanner;User=admin;Password=P@ssw0rd123;";
    }

    // ✅ SECURE VERSION: Use configuration/environment variables
    public string GetDatabaseConnectionSecure(IConfiguration configuration)
    {
        // SECURE: Read from configuration or environment
        return configuration.GetConnectionString("MealPlannerDb")
            ?? throw new InvalidOperationException("Connection string not configured");
    }

    // ⚠️ VULNERABILITY 7: XML External Entity (XXE)
    // CodeQL will flag this as CWE-611: XXE Vulnerability
    public void ParseRecipeXmlVulnerable(string xmlContent)
    {
        // VULNERABLE: XmlDocument with external entities enabled
        var doc = new System.Xml.XmlDocument();
        doc.XmlResolver = new System.Xml.XmlUrlResolver(); // Enables XXE
        doc.LoadXml(xmlContent);
    }

    // ✅ SECURE VERSION: Disable external entities
    public void ParseRecipeXmlSecure(string xmlContent)
    {
        // SECURE: Disable external entity resolution
        var doc = new System.Xml.XmlDocument();
        doc.XmlResolver = null; // Disables XXE
        doc.LoadXml(xmlContent);
    }

    // ⚠️ VULNERABILITY 8: Cross-Site Scripting (XSS)
    // CodeQL will flag this in web contexts
    public string DisplayRecipeNameVulnerable(string recipeName)
    {
        // VULNERABLE: Direct HTML output without encoding
        return $"<h1>Recipe: {recipeName}</h1>";
    }

    // ✅ SECURE VERSION: HTML encode user input
    public string DisplayRecipeNameSecure(string recipeName)
    {
        // SECURE: Encode HTML entities
        var encoded = System.Net.WebUtility.HtmlEncode(recipeName);
        return $"<h1>Recipe: {encoded}</h1>";
    }

    // ⚠️ VULNERABILITY 9: Insecure Random Number Generation
    // CodeQL will flag this for security-sensitive contexts
    public string GenerateApiKeyVulnerable()
    {
        // VULNERABLE: Random is not cryptographically secure
        var random = new Random();
        var bytes = new byte[32];
        random.NextBytes(bytes);
        return Convert.ToBase64String(bytes);
    }

    // ✅ SECURE VERSION: Use cryptographically secure RNG
    public string GenerateApiKeySecure()
    {
        // SECURE: Use RandomNumberGenerator for cryptographic purposes
        var bytes = new byte[32];
        System.Security.Cryptography.RandomNumberGenerator.Fill(bytes);
        return Convert.ToBase64String(bytes);
    }

    // ⚠️ VULNERABILITY 10: Insufficient Input Validation
    // CodeQL will flag this as potential injection
    public void LogUserActionVulnerable(string userId, string action)
    {
        // VULNERABLE: No validation or sanitization
        var logMessage = $"User {userId} performed: {action}";
        Console.WriteLine(logMessage);
        // If action contains format strings or special characters, could cause issues
    }

    // ✅ SECURE VERSION: Validate and sanitize inputs
    public void LogUserActionSecure(string userId, string action)
    {
        // SECURE: Validate inputs
        if (string.IsNullOrWhiteSpace(userId) || string.IsNullOrWhiteSpace(action))
        {
            throw new ArgumentException("User ID and action are required");
        }

        // Sanitize by removing potentially harmful characters
        var sanitizedUserId = System.Text.RegularExpressions.Regex.Replace(
            userId, @"[^\w\-]", "");
        var sanitizedAction = System.Text.RegularExpressions.Regex.Replace(
            action, @"[^\w\s\-]", "");

        var logMessage = $"User {sanitizedUserId} performed: {sanitizedAction}";
        Console.WriteLine(logMessage);
    }
}
