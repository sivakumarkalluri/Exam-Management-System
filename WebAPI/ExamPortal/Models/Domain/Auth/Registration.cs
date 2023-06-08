using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace ExamPortal.Models.Domain.Auth
{
    [Table("userRegisterData")]
    public class Registration
    {
        [Key]


        [Column("userId")]
        public int UserId { get; set; }

        [Column("firstname")]
        public string FirstName { get; set; }

        [Column("lastname")]
        public string LastName { get; set; }

        [Column("email")]
        public string Email { get; set; }

        [Column("password")]
        public string Password { get; set; }

        [Column("mobile")]
        public string Mobile { get; set; }

        [Column("gender")]
        public string Gender { get; set; }

        [Column("role")]

        public string Role { get; set; }

        [Column("registeredAt")]
        public DateTime registeredAt { get; set; }
    }
}
