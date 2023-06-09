﻿using ExamPortal.Data;
using ExamPortal.Models.DTO;
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
    }
}