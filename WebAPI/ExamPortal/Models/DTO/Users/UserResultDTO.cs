namespace ExamPortal.Models.DTO.Users
{
    public class UserResultDTO
    {
        public int ResultId { get; set; }
        public int TestId { get; set; }
        public int UserId { get; set; }
        public int Exam_Id { get; set; }
        public int Category_Id { get; set; }
        public int Attempted_Questions { get; set; }
        public int NotAttempted_Questions { get; set; }
        public int Correct_Answers { get; set; }
        public int Wrong_Answers { get; set; }
        public decimal Total_MarksObtained { get; set; }
        public decimal Exam_Total { get; set; }
        public decimal Percentage { get; set; }
        public string PassOrFail { get; set; }
        public DateTime AttemptedAt { get; set; }
        public string Exam_Name { get; set; }
        public string Category_Name { get; set; }
        public decimal PassPercentageRequired { get; set; }
    }
}
