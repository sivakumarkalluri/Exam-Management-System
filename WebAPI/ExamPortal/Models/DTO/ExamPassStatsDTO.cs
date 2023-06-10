namespace ExamPortal.Models.DTO
{
    public class ExamPassStatsDTO
    {
       
            public int Exam_Id { get; set; }

            public int Category_Id { get; set; }
            public string Exam_Name { get; set; }
            public int PassedCount { get; set; }
            public int FailedCount { get; set; }
       

    }
}
