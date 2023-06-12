using ExamPortal.Models.Domain;
using ExamPortal.Models.Domain.Auth;
using ExamPortal.Models.DTO;
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
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Configure AdminStatisticsDTO as a keyless entity type
            modelBuilder.Entity<AdminStatisticsDTO>().HasNoKey();

            modelBuilder.Entity<CountStudentsAttemptedExamsDTO>().HasNoKey();

            modelBuilder.Entity<ExamPassStatsDTO>().HasNoKey();

            modelBuilder.Entity<StudentsAttemptedByCategoryDTO>().HasNoKey();

            modelBuilder.Entity<InsertCategoryExamQuestionsDTO>().HasNoKey();

            modelBuilder.Entity<QuestionsTypeDTO>().HasNoKey(); 

            // Other configurations

            base.OnModelCreating(modelBuilder);
        }
    }
}
