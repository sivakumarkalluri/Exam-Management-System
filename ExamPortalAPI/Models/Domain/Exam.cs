using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ExamPortal.Models.Domain
{
   
    public class Exam
    {
        [Key]

        public int ExamId { get; set; }

        public int Category_Id { get; set; }

        public string ExamName { get; set; }

        
        public string ExamDescription { get; set; }

      
        public int ExamDuration { get; set; }

     
        public decimal QuestionMark { get; set; }

        public int ExamTotalQuestion { get; set; }

        public decimal ExamPassPercent { get; set; }
    }
}
