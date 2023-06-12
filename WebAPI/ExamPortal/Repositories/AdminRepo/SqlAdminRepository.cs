using ExamPortal.Data;
using ExamPortal.Models.Domain;
using ExamPortal.Models.DTO;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace ExamPortal.Repositories.AdminRepo
{
    public class SqlAdminRepository : IAdminRepository
    {
        private readonly ExamPortalDBContext _dbContext;

        public SqlAdminRepository(ExamPortalDBContext dbContext)
        {
            this._dbContext = dbContext;
        }
        public async Task<AdminStatisticsDTO> GetAdminStats()
        {
            var adminStats = this._dbContext.AdminStatisticsDTO
                    .FromSqlRaw("EXECUTE GetAdminStatistics")
                    .AsEnumerable()
                    .FirstOrDefault();
            return adminStats;
        }

        public async Task<List<CountStudentsAttemptedExamsDTO>> GetExamCountStats()
        {
            var attempts = await this._dbContext.studentsAttemptedExamsDTOs.FromSqlRaw("EXECUTE CountStudentsAttemptedExams").ToListAsync();
            return attempts;
        }

        public async Task<List<ExamPassStatsDTO>> GetExamPassStats()
        {
            var passStats = await this._dbContext.examPassStatsDTOs.FromSqlRaw("EXECUTE GetExamPassStatistics").ToListAsync();
            return passStats;

        }

        public async Task<List<StudentsAttemptedByCategoryDTO>> GetCategoryStudentStats()
        {

            var countStats = await this._dbContext.studentsAttemptedByCategoryDTOs.FromSqlRaw("EXECUTE CountStudentsAttemptedByCategory").ToListAsync();
            return countStats;
        }

        public async Task<List<Categories>> GetCategoriesData()
        {
            var data= await this._dbContext.categories.ToListAsync();
            return data;
        }

        public async Task<InsertCategoryExamQuestionsDTO> InsertCategoryExamQuestions(InsertCategoryExamQuestionsDTO inputData)
        {
            var dataTable = new DataTable();
            dataTable.Columns.Add("QuestionDesc", typeof(string));
            dataTable.Columns.Add("Option1", typeof(string));
            dataTable.Columns.Add("Option2", typeof(string));
            dataTable.Columns.Add("Option3", typeof(string));
            dataTable.Columns.Add("Option4", typeof(string));
            dataTable.Columns.Add("CorrectAnswer", typeof(int));

            foreach (var question in inputData.QuestionList)
            {
                dataTable.Rows.Add(question.QuestionDesc, question.Option1, question.Option2, question.Option3, question.Option4, question.CorrectAnswer);
            }

            var parameter = new SqlParameter("@questionList", SqlDbType.Structured);
            parameter.Value = dataTable;
            parameter.TypeName = "QuestionListType";

            var result = await _dbContext.insertCategoryExamQuestionsDTOs
                .FromSqlRaw("EXECUTE InsertCategoryExamQuestions @categoryName, @categoryDesc, @examName, @examDesc, @examDuration, @questionMark, @examTotalQuestion, @examPassPercent, @questionList",
                    new SqlParameter("@categoryName", inputData.CategoryName),
                    new SqlParameter("@categoryDesc", inputData.CategoryDesc),
                    new SqlParameter("@examName", inputData.ExamName),
                    new SqlParameter("@examDesc", inputData.ExamDesc),
                    new SqlParameter("@examDuration", inputData.ExamDuration),
                    new SqlParameter("@questionMark", inputData.QuestionMark),
                    new SqlParameter("@examTotalQuestion", inputData.ExamTotalQuestion),
                    new SqlParameter("@examPassPercent", inputData.ExamPassPercent),
                    parameter)
                .ToListAsync();

            // Process the result if needed

            return inputData;
        }

        public async Task<DeleteCategoryDTO> DeleteCategory(int categoryId)
        {
            var result =  _dbContext.deleteCategoryDTOs.FromSqlRaw("EXECUTE DeleteCategoryData @categoryId",
                    new SqlParameter("@categoryId", categoryId))
                .AsEnumerable()
                .FirstOrDefault();

            // Process the result if needed
            return result;
        }

        public async Task<AddExamDTO> AddExam(AddExamDTO inputData)
        {
            var dataTable = new DataTable();
            dataTable.Columns.Add("QuestionDesc", typeof(string));
            dataTable.Columns.Add("Option1", typeof(string));
            dataTable.Columns.Add("Option2", typeof(string));
            dataTable.Columns.Add("Option3", typeof(string));
            dataTable.Columns.Add("Option4", typeof(string));
            dataTable.Columns.Add("CorrectAnswer", typeof(int));

            foreach (var question in inputData.QuestionList)
            {
                dataTable.Rows.Add(question.QuestionDesc, question.Option1, question.Option2, question.Option3, question.Option4, question.CorrectAnswer);
            }

            var parameter = new SqlParameter("@questionList", SqlDbType.Structured);
            parameter.Value = dataTable;
            parameter.TypeName = "QuestionListType";

            var result = await _dbContext.addExamDTOs
                .FromSqlRaw("EXECUTE AddExam @categoryId,@examName, @examDesc, @examDuration, @questionMark, @examTotalQuestion, @examPassPercent, @questionList",
                    new SqlParameter("@categoryId", inputData.CategoryId),
                    new SqlParameter("@examName", inputData.ExamName),
                    new SqlParameter("@examDesc", inputData.ExamDesc),
                    new SqlParameter("@examDuration", inputData.ExamDuration),
                    new SqlParameter("@questionMark", inputData.QuestionMark),
                    new SqlParameter("@examTotalQuestion", inputData.ExamTotalQuestion),
                    new SqlParameter("@examPassPercent", inputData.ExamPassPercent),
                    parameter)
                .ToListAsync();

            // Process the result if needed

            return inputData;
        }

        public async Task<List<UsersDataDTO>> GetUsersData()
        {
            var result = await this._dbContext.usersDataDTOs.FromSqlRaw("Execute GetUsersData").ToListAsync();
            return result;
        }

        public async Task<List<AdminUserResultsDTO>> GetAdminUserResults()
        {
            var result = await this._dbContext.adminUserResultsDTOs.FromSqlRaw("Execute GetAdminUserResultsData").ToListAsync();
            return result;
        }
    }
}
