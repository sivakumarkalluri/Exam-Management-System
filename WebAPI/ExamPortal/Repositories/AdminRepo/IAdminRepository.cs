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

        Task<DeleteCategoryDTO?> DeleteCategory(int categoryId);

        Task<AddExamDTO> AddExam(AddExamDTO inputData);

        Task<List<UsersDataDTO>> GetUsersData();

        Task<List<AdminUserResultsDTO>> GetAdminUserResults();

        Task<Categories> EditCategory(Categories categories,int categoryId);

        Task<List<AdminCRUDExamDTO>> GetAdminCRUDExamData();

        Task<List<Questions>> GetExamQuestionsData(int id);

        Task<Questions> EditQuestion(Questions inputData,int id);

        Task<Questions> DeleteQuestion(int id);

        Task<Questions> AddQuestion(Questions inputData);

        Task<DeleteExamDTO> DeleteExam(int id);

        Task<Exam> EditExam(Exam inputData,int id);
    }
}
