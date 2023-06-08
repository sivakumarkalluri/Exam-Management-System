using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
namespace ExamPortal.Models.Domain.Auth
{
    public class JwtService
    {

        public string SecretKey { get; }
        public int TokenDuration { get; }

        public JwtService(IConfiguration config)
        {
            SecretKey = config.GetSection("jwtConfig").GetSection("Key").Value;
           // TokenDuration = Int32.Parse(config.GetSection("jwtConfig").GetSection("Duration").Value);
        }

        public string GenerateToken(string id, string firstName, string lastName, string email, string mobile,string role)
        {
            var signingKey = GenerateSecureKey();

            var claims = new[]
            {
                new Claim("id", id),
                new Claim("firstName", firstName),
                new Claim("lastName", lastName),
                new Claim("email", email),
                new Claim("mobile", mobile),
                new Claim("role",role)
            };

            var token = new JwtSecurityToken(
                issuer: "localhost",
                audience: "localhost",
                claims: claims,
               // expires: DateTime.Now.AddMinutes(TokenDuration),
                signingCredentials: new SigningCredentials(signingKey, SecurityAlgorithms.HmacSha256)
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        private SymmetricSecurityKey GenerateSecureKey()
        {
            var key = new byte[32]; // 256 bits
            using (var provider = new RNGCryptoServiceProvider())
            {
                provider.GetBytes(key);
            }
            return new SymmetricSecurityKey(key);
        }
    }
}
