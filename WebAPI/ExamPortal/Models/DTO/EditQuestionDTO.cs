namespace ExamPortal.Models.DTO
{
    public class EditQuestionDTO
    {

        public int question_id { get; set; }
        public string question_desc { get; set; }
        public string option_1 { get; set; }
        public string option_2 { get; set; }
        public string option_3 { get; set; }
        public string option_4 { get; set; }
        public int correctAnswer { get; set; }
    }
}
