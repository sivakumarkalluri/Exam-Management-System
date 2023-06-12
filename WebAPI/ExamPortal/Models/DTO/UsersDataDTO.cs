namespace ExamPortal.Models.DTO
{
    public class UsersDataDTO
    {
        public int UserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Mobile { get; set; }
        public string Gender { get; set; }
        public DateTime RegisteredAt { get; set; }
        public int NumberOfExamsWritten { get; set; }
    }
}
