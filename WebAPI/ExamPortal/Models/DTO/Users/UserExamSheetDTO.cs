﻿namespace ExamPortal.Models.DTO.Users
{
    public class UserExamSheetDTO
    {

        public int TestId { get; set; }
        public int UserId { get; set; }
        public int Exam_Id { get; set; }
        public int Category_Id { get; set; }
        public int Question_Id { get; set; }
        public int? Answer { get; set; }
        public DateTime AttemptedAt { get; set; }
        public string Exam_Name { get; set; }
        public string Category_Name { get; set; }
        public decimal Pass_Percentage { get; set; }
        public string Question_Desc { get; set; }
        public string Option_1 { get; set; }
        public string Option_2 { get; set; }
        public string Option_3 { get; set; }
        public string Option_4 { get; set; }
        public int CorrectAnswer { get; set; }
        public decimal Total_MarksObtained { get; set; }
        public decimal Percentage_Obtained { get; set; }
        public bool Pass_Fail { get; set; }
    }
}
