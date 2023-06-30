using ExamPortal.Data;
using ExamPortal.Models.Domain;

using Microsoft.EntityFrameworkCore;

namespace ExamPortal.Repositories.AdminRepo
{
    public class SqlAdminRepository : IAdminRepository
    {
        private readonly ExamPortalDBContext _dbContext;

        public SqlAdminRepository(ExamPortalDBContext dbContext)
        {
            this._dbContext = dbContext;
        }

        public async Task<List<Categories>> GetCategoriesData()
        {
            var data = await this._dbContext.categories.ToListAsync();
            return data;
        }
    }
}
