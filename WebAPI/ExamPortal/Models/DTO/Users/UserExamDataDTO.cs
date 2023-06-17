namespace ExamPortal.Models.DTO.Users
{
    public class UserExamDataDTO
    {
        public int user_id { get; set; }
        public int exam_id { get; set; }

        public int category_id { get; set; }

        public int question_id { get; set; }

        public int? answer { get; set; }

    }
}
