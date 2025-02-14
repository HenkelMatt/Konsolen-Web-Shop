using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;
using System.Text;
using Microsoft.Extensions.Configuration;

namespace MyApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public LoginController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        // Beispiel-Login
        [HttpPost]
        public IActionResult Login([FromBody] LoginRequest request)
        {
            // Dummy-Daten für Benutzername und Passwort (normalerweise aus einer DB)
            var users = new Dictionary<string, string>
            {
                { "testuser", "$2a$12$u1XANQy6WoH3Xy8.kDPJ6eZqaBz1jVsb5w7lLoEYhWiPHcRH4OWaS" } // Beispiel Passwort-Hash
            };

            // Überprüfen, ob der Benutzername existiert
            if (!users.ContainsKey(request.Username))
            {
                return Unauthorized(new { message = "Benutzername nicht gefunden." });
            }

            var storedPasswordHash = users[request.Username];

            // Überprüfen des Passworts mit bcrypt
            if (!VerifyPassword(request.Password, storedPasswordHash))
            {
                return Unauthorized(new { message = "Falsches Passwort." });
            }

            // Wenn erfolgreich, sende die Benutzer-ID und ein Token zurück
            var userId = 1234; // Beispiel ID
            return Ok(new { success = true, userId = userId });
        }

        // Funktion zum Überprüfen des Passworts
        private bool VerifyPassword(string password, string storedPasswordHash)
        {
            return password == storedPasswordHash;
        }
    }

    // Request-Model
    public class LoginRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }
}