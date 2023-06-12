using ExamPortal.Models.Domain;
using ExamPortal.Models.DTO;

namespace ExamPortal.Repositories.AdminRepo
{
    public interface IAdminRepository
    {
        Task<AdminStatisticsDTO> GetAdminStats();
        Task<List<CountStudentsAttemptedExamsDTO>> GetExamCountStats();
        Task<List<ExamPassStatsDTO>> GetExamPassStats();

        Task<List<StudentsAttemptedByCategoryDTO>> GetCategoryStudentStats();

        Task<List<Categories>> GetCategoriesData();

        Task<InsertCategoryExamQuestionsDTO> InsertCategoryExamQuestions(InsertCategoryExamQuestionsDTO inputData);
    }
}
