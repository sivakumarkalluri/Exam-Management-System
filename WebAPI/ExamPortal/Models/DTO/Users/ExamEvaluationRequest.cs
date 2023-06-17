using System.ComponentModel.DataAnnotations.Schema;

namespace ExamPortal.Models.DTO.Users
{
    public class ExamEvaluationRequest
    {
        public List<UserExamDataDTO> InputData { get; set; }
    }
}
