using ExamPortal.Models.Domain;
using ExamPortal.Models.Domain.Auth;
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
        public DbSet<Registration> register { get; set; }
    }
}
