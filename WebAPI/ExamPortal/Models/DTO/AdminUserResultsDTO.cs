namespace ExamPortal.Models.DTO
{
    public class AdminUserResultsDTO
    {
        public int UserId { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string ExamName { get; set; }
        public string CategoryName { get; set; }
        public int AttemptedQuestions { get; set; }
        public int NotAttemptedQuestions { get; set; }
        public int CorrectAnswers { get; set; }
        public int WrongAnswers { get; set; }
        public decimal TotalMarksObtained { get; set; }
        public decimal ExamTotal { get; set; }
        public decimal PercentageObtained { get; set; }
        public decimal PassPercentage { get; set; }
        public string PassorFail { get; set; }
        public DateTime AttemptedAt { get; set; }
    }
}
