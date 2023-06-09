﻿using System.ComponentModel.DataAnnotations;

namespace ExamPortal.Models.Domain
{
    public class UserResults
    {
        [Key]
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
        public bool Pass_Flag { get; set; }

        public DateTime AttemptedAt { get; set; }
        public decimal passPercentageRequired { get; set; }

        public int examTotalQuestions { get; set; }

    }
}
