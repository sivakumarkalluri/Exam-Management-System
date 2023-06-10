namespace ExamPortal.Models.DTO
{
    public class AdminStatisticsDTO
    {

        public int TotalUsers { get; set; }
        public int TotalExams { get; set; }

        public int TotalCategories { get; set; }
        public int StudentsTakenAtLeastOneExam { get; set; }
        public int StudentsNotTakenAtLeastOneExam { get; set; }
    }
}
