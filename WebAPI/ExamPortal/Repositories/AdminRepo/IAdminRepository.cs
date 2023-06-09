using ExamPortal.Models.DTO;

namespace ExamPortal.Repositories.AdminRepo
{
    public interface IAdminRepository
    {
        Task<AdminStatisticsDTO> GetAdminStats();
        Task<List<CountStudentsAttemptedExamsDTO>> GetExamCountStats();
        Task<List<ExamPassStatsDTO>> GetExamPassStats();
    }
}
