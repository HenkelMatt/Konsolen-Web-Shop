using System;
using Microsoft.AspNetCore.Identity;

namespace Konsolen_Web_Shop.Code.Class;

public class User
{
    public int UserID { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Username { get; set; }
    public string Email { get; set; }
    public string PhoneNumber { get; set; }
    public DateTime CreatedDate { get; set; }

    // Gespeichertes gehashtes Passwort
    public string PasswordHash { get; set; }

    // Methode zum Setzen des Passworts (wird in der Registrierung verwendet)
    public void SetPassword(string password)
    {
        var passwordHasher = new PasswordHasher<User>();
        PasswordHash = passwordHasher.HashPassword(this, password);
    }

    // Methode zum Vergleichen des eingegebenen Passworts mit dem gespeicherten Hash
    public bool VerifyPassword(string password)
    {
        var passwordHasher = new PasswordHasher<User>();
        var result = passwordHasher.VerifyHashedPassword(this, PasswordHash, password);
        return result == PasswordVerificationResult.Success;
    }
}