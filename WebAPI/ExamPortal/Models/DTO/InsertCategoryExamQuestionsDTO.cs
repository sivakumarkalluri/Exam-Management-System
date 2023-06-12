namespace ExamPortal.Models.DTO
{
    public class InsertCategoryExamQuestionsDTO
    {
        public string CategoryName { get; set; }
        public string CategoryDesc { get; set; }
        public string ExamName { get; set; }
        public string ExamDesc { get; set; }
        public int ExamDuration { get; set; }
        public int QuestionMark { get; set; }
        public int ExamTotalQuestion { get; set; }
        public decimal ExamPassPercent { get; set; }
        public List<QuestionsTypeDTO> QuestionList { get; set; }
    }

   
}
