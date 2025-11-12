using System.Text;
using System.Security.Cryptography;

namespace MealPlannerApi.Services;

public class InsecureCryptoService
{
    // Vulnerable: Using weak DES encryption
    public string EncryptWithDES(string plainText, string key)
    {
        using var des = DES.Create();
        des.Key = Encoding.UTF8.GetBytes(key.PadRight(8).Substring(0, 8));
        des.IV = new byte[8];
        
        using var encryptor = des.CreateEncryptor();
        var plainBytes = Encoding.UTF8.GetBytes(plainText);
        var cipherBytes = encryptor.TransformFinalBlock(plainBytes, 0, plainBytes.Length);
        
        return Convert.ToBase64String(cipherBytes);
    }

    // Vulnerable: Using MD5 for password hashing
    public string HashPasswordMD5(string password)
    {
        using var md5 = MD5.Create();
        var hash = md5.ComputeHash(Encoding.UTF8.GetBytes(password));
        return BitConverter.ToString(hash).Replace("-", "").ToLower();
    }

    // Vulnerable: Using SHA1 which is deprecated
    public string HashPasswordSHA1(string password)
    {
        using var sha1 = SHA1.Create();
        var hash = sha1.ComputeHash(Encoding.UTF8.GetBytes(password));
        return Convert.ToBase64String(hash);
    }

    // Vulnerable: Predictable random number generation
    public int GenerateRandomNumber()
    {
        var random = new Random(12345); // Fixed seed
        return random.Next();
    }

    // Vulnerable: Insecure cookie settings
    public void SetInsecureCookie(HttpContext context, string name, string value)
    {
        context.Response.Cookies.Append(name, value, new CookieOptions
        {
            HttpOnly = false,  // Vulnerable to XSS
            Secure = false,    // Not restricted to HTTPS
            SameSite = SameSiteMode.None,  // No CSRF protection
            Expires = DateTimeOffset.Now.AddYears(10)
        });
    }
}
