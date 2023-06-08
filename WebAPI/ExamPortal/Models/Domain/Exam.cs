using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ExamPortal.Models.Domain
{
    [Table("exam")]
    public class Exam
    {
        [Key]

        [Column("exam_id")]
        public int ExamId { get; set; }

        [Column("exam_name")]
        public string ExamName { get; set; }

        [Column("exam_description ")]
        public string ExamDescription { get; set; }

        [Column("exam_duration")]
        public int ExamDuration { get; set; }

        [Column("question_mark")]
        public int QuestionMark { get; set; }

        [Column("exam_totalquestion")]
        public int ExamTotalQuestion { get; set; }

        [Column("exampass_marks")]
        public int ExamPassMarks { get; set; }
    }
}
