using System.ComponentModel.DataAnnotations;

namespace ExamPortal.Models.Domain
{
    public class Questions
    {
        [Key]
        public int question_id { get; set; }
        public int exam_id { get; set; }
        public int category_id { get; set; }
        public string question_desc { get; set; }
        public string option_1 { get; set; }
        public string option_2 { get; set; }
        public string option_3 { get; set; }
        public string option_4 { get; set; }
        public int correctAnswer { get; set; }
    }
}
