using ExamPortal.Models.Domain;


namespace ExamPortal.Repositories.AdminRepo
{
    public interface IAdminRepository
    {
        //Task<AdminStatisticsDTO> GetAdminStats();
        //Task<List<CountStudentsAttemptedExamsDTO>> GetExamCountStats();
        //Task<List<ExamPassStatsDTO>> GetExamPassStats();

        //Task<List<StudentsAttemptedByCategoryDTO>> GetCategoryStudentStats();

        Task<List<Categories>> GetCategoriesData();

        //Task<InsertCategoryExamQuestionsDTO> InsertCategoryExamQuestions(InsertCategoryExamQuestionsDTO inputData);

        //Task<DeleteCategoryDTO?> DeleteCategory(int categoryId);

        //Task<AddExamDTO> AddExam(AddExamDTO inputData);

        //Task<List<UsersDataDTO>> GetUsersData();

        //Task<List<AdminUserResultsDTO>> GetAdminUserResults();

        //Task<Categories> EditCategory(Categories categories, int categoryId);

        //Task<List<AdminCRUDExamDTO>> GetAdminCRUDExamData();

        //Task<List<Questions>> GetExamQuestionsData(int id);

        //Task<Questions> EditQuestion(Questions inputData, int id);

        //Task<DeleteQuestionDTO> DeleteQuestion(int id);

        //Task<Questions> AddQuestion(Questions inputData);

        //Task<DeleteExamDTO> DeleteExam(int id);

        //Task<Exam> EditExam(Exam inputData, int id);

        //Task<Exam> GetExamData(int id);

        //Task<UserDashboardStats> GetDashboardStats(int id);

        //Task<List<UserPassStats>> GetUserPassStats(int id);

        //Task<List<UserResultDTO>> GetUserResultsAll(int id);

        //Task<List<UserExamSheetDTO>> GetUserExamSheet(int id);

        //Task<List<ExamImages>> GetExamImages();

        //Task<int> GetTestID();

        //Task<int> AddUserExamData(List<UserExamData> userExamDataList);

        //Task<Registration> GetUserData(int id);

        //Task<bool> UpdateImage(int id, string profileImageUrl);

        //Task<List<AnswerSheetDTO>> GetAnswerSheet(int id);

    }
}
