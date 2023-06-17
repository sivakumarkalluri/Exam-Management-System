using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ExamPortal.Models.Domain
{
    [Table("usersExamData")]
    public class UserExamData
    {
        [Key]
        public int Id { get; set; }
        public int testId { get; set; }
        public int userId { get; set; }
        public int exam_id { get; set; }

        public int category_id { get; set; }

        public int question_id { get; set; }

        public int? answer { get; set; }

        public DateTime attemptedAt { get; set; }
    }
}
