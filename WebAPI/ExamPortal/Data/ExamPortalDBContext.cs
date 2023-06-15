using ExamPortal.Models.Domain;
using ExamPortal.Models.Domain.Auth;
using ExamPortal.Models.DTO;
using ExamPortal.Models.DTO.Users;
using Microsoft.EntityFrameworkCore;

namespace ExamPortal.Data
{
    public class ExamPortalDBContext:DbContext
    {
        public ExamPortalDBContext(DbContextOptions<ExamPortalDBContext> options)
       : base(options)
        {
        }

        public DbSet<Exam> exams { get; set; }

        public DbSet<Categories> categories { get; set; }
        public DbSet<Registration> register { get; set; }

        public DbSet<AdminStatisticsDTO> AdminStatisticsDTO { get; set; }

        public DbSet<CountStudentsAttemptedExamsDTO> studentsAttemptedExamsDTOs { get; set; }

        public DbSet<ExamPassStatsDTO> examPassStatsDTOs { get; set; }

        public DbSet<StudentsAttemptedByCategoryDTO> studentsAttemptedByCategoryDTOs { get; set; }

        public DbSet<InsertCategoryExamQuestionsDTO> insertCategoryExamQuestionsDTOs { get; set; }

        public DbSet<QuestionsTypeDTO> questionTypesDTO { get; set; }

        public DbSet<DeleteCategoryDTO> deleteCategoryDTOs { get; set; }

        public DbSet<AddExamDTO> addExamDTOs { get; set; }

        public DbSet<UsersDataDTO> usersDataDTOs { get; set; }

        public DbSet<AdminUserResultsDTO> adminUserResultsDTOs { get; set; }

        public DbSet<AdminCRUDExamDTO> adminCRUDExamDTOs { get; set; }

        public DbSet<Questions> questions { get; set; }

        public DbSet<EditQuestionDTO> editQuestionDTOs { get; set; }

        public DbSet<DeleteExamDTO> deleteExamDTOs { get; set; }

        public DbSet<DeleteQuestionDTO> deleteQuestionDTOs { get; set; }

        public DbSet<UserDashboardStats> userDashboardStats { get; set; }

        public DbSet<UserPassStats> userPassStats { get; set; }

        public DbSet<UserResults> userResults { get; set; }

        public DbSet<UserExamSheetDTO> userExamSheetDTOs { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Configure AdminStatisticsDTO as a keyless entity type
            modelBuilder.Entity<AdminStatisticsDTO>().HasNoKey();

            modelBuilder.Entity<CountStudentsAttemptedExamsDTO>().HasNoKey();

            modelBuilder.Entity<ExamPassStatsDTO>().HasNoKey();

            modelBuilder.Entity<StudentsAttemptedByCategoryDTO>().HasNoKey();

            modelBuilder.Entity<InsertCategoryExamQuestionsDTO>().HasNoKey();

            modelBuilder.Entity<QuestionsTypeDTO>().HasNoKey();
            
            modelBuilder.Entity<DeleteCategoryDTO>().HasNoKey();

            modelBuilder.Entity<AddExamDTO>().HasNoKey();

            modelBuilder.Entity<UsersDataDTO>().HasNoKey();

            modelBuilder.Entity<EditQuestionDTO>().HasNoKey();

            modelBuilder.Entity<AdminUserResultsDTO>().HasNoKey();

            modelBuilder.Entity<AdminCRUDExamDTO>().HasNoKey();

            modelBuilder.Entity<DeleteExamDTO>().HasNoKey();

            modelBuilder.Entity<DeleteQuestionDTO>().HasNoKey();

            modelBuilder.Entity<UserDashboardStats>().HasNoKey();

            modelBuilder.Entity<UserPassStats>().HasNoKey();

            modelBuilder.Entity<UserResults>().HasNoKey();

            modelBuilder.Entity<UserExamSheetDTO>().HasNoKey();
            // Other configurations

            base.OnModelCreating(modelBuilder);
        }
    }
}
