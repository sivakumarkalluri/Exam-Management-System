using System.ComponentModel.DataAnnotations.Schema;

namespace ExamPortal.Models.Domain.Auth
{
    [Table("userLogin")]
    public class Login
    {
        [Column("email")]
        public string Email { get; set; }

        [Column("password")]
        public string Password { get; set; }

        [Column("role")]
        public string Role { get; set; }
    }
}
