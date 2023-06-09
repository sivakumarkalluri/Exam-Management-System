﻿using ExamPortal.Repositories.AdminRepo;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ExamPortal.Controllers.AdminControllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdminDashboardController : ControllerBase
    {
        private readonly IAdminRepository adminRepository;

        public AdminDashboardController(IAdminRepository adminRepository)
        {
            this.adminRepository = adminRepository;
        }

        [HttpGet("AdminStatistics")]
        public async Task<IActionResult> GetAdminStatistics()
        {
           var result= await this.adminRepository.GetAdminStats();
            if(result == null)
            {
                return Ok("Data not Found");
            }
            return Ok(result);
        }


        [HttpGet("ExamAttemptsStats")]
        public async Task<IActionResult> GetExamAttemptStatistics()
        {
            var result = await this.adminRepository.GetExamCountStats();
            if (result == null)
            {
                return Ok("Data not Found");
            }
            return Ok(result);
        }

        [HttpGet("ExamPassStats")]
        public async Task<IActionResult> GetExamPassStatistics()
        {
            var result = await this.adminRepository.GetExamPassStats();
            if (result == null)
            {
                return Ok("Data not Found");
            }
            return Ok(result);
        }

    }
}
