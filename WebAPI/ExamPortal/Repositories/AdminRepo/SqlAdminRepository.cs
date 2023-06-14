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

        public async Task<Categories> EditCategory(Categories categories,int categoryId)
        {
            var data = await this._dbContext.categories.FindAsync(categoryId);
            if (data == null)
            {
                return null;
            }

            data.CategoryDesc = categories.CategoryDesc;
            data.CategoryName = categories.CategoryName;
            await this._dbContext.SaveChangesAsync();
            return data;

        }

        public async Task<List<AdminCRUDExamDTO>> GetAdminCRUDExamData()
        {
            var result = await this._dbContext.adminCRUDExamDTOs.FromSqlRaw("Execute AdminCRUDExamData").ToListAsync();
            return result;
        }

        public async Task<List<Questions>> GetExamQuestionsData(int id)
        {
            var result= await this._dbContext.questions.Where(x => x.exam_id == id).ToListAsync(); ;
            return result;
        }

        public async Task<Questions> EditQuestion(Questions inputData, int id)
        {
            var data = await this._dbContext.questions.FindAsync(id);
            if (data == null)
            {
                return null;
            }

            data.question_desc = inputData.question_desc;
            data.option_1 = inputData.option_1;
            data.option_2 = inputData.option_2;
            data.option_3 = inputData.option_3;
            data.option_4 = inputData.option_4;
            data.correctAnswer = inputData.correctAnswer;
            await this._dbContext.SaveChangesAsync();
            return data;

        }

        public async Task<DeleteQuestionDTO> DeleteQuestion(int id)
        {
            var result = this._dbContext.deleteQuestionDTOs.FromSqlRaw("Execute DeleteQuestion @questionId",
                     new SqlParameter("@questionId", id)).AsEnumerable()
                 .FirstOrDefault();

            return result;

        }

        public async Task<Questions> AddQuestion(Questions inputData)
        {
           var result= this._dbContext.deleteExamDTOs.FromSqlRaw("Execute AddQuestionToExam  @examId, @categoryId,@questionDesc, @option1, @option2, @option3, @option4, @correctAnswer", 
               new SqlParameter("@examId", inputData.exam_id),
               new SqlParameter("@categoryId", inputData.category_id),
               new SqlParameter("@questionDesc", inputData.question_desc),
               new SqlParameter("@option1", inputData.option_1),
               new SqlParameter("@option2", inputData.option_2),
               new SqlParameter("@option3", inputData.option_3),
               new SqlParameter("@option4", inputData.option_4),
               new SqlParameter("@correctAnswer", inputData.correctAnswer)


               ).AsEnumerable()
                 .FirstOrDefault();
           
            return inputData;
        }

      

        public async Task<DeleteExamDTO> DeleteExam(int id)
        {
            var result = this._dbContext.deleteExamDTOs.FromSqlRaw("Execute DeleteExamWithQuestions @examId",
                    new SqlParameter("@examId", id)).AsEnumerable()
                .FirstOrDefault();
            
            return result;
        }

        public async Task<Exam> EditExam(Exam inputData,int id)
        {
            var data = await this._dbContext.exams.FindAsync(id);
            if (data == null)
            {
                return null;
            }
            data.ExamDescription = inputData.ExamDescription;
            data.ExamDuration= inputData.ExamDuration;
            data.QuestionMark= inputData.QuestionMark;
            data.ExamName= inputData.ExamName;
            data.ExamPassPercent= inputData.ExamPassPercent;
            await this._dbContext.SaveChangesAsync();
            return data;
        }

        public async Task<Exam> GetExamData(int id)
        {
            var data = await this._dbContext.exams.FindAsync(id);
            if (data == null)
            {
                return null;
            }
            return data;
        }
    }
}
