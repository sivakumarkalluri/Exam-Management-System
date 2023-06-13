namespace ExamPortal.Models.DTO
{
    public class AdminCRUDExamDTO
    {
        public int Category_Id { get; set; }

        public string Category_Name { get; set; }

        public int Exam_Id { get; set; }

        public string Exam_Name { get; set; }

        public int Exam_totalquestion { get; set; }
        public int Total_Exams { get; set; }
    }
}
