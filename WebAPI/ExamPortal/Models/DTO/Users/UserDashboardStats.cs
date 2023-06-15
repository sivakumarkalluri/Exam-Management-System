namespace ExamPortal.Models.DTO.Users
{
    public class UserDashboardStats
    {
        public int TotalExamsAvailable { get; set; }
        public int TotalExamsWritten { get; set; }
        public int TotalTestsAttempted { get; set; }
        public int TotalExamsNotWritten { get; set; }
    }
}
