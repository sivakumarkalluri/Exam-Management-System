using ExamPortal.Repositories.AdminRepo;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ExamPortal.Controllers.UserControllers
{
    [Route("api")]
    [ApiController]
    public class UserDashboardController : ControllerBase
    {
        private readonly IAdminRepository adminRepository;

        public UserDashboardController(IAdminRepository adminRepository) {
            this.adminRepository = adminRepository;
        }
      
        [HttpGet("DashBoardStats/{id}")]
        public async Task<IActionResult> GetDashboardStats(int id)
        {
            var result = await this.adminRepository.GetDashboardStats(id);
            if(result == null)
            {
                return Ok("Data Not Found");
            }
            return Ok(result);
        }

        [HttpGet("UserPassStats/{id}")]
        public async Task<IActionResult> GetUserPassStats(int id)
        {
            var result = await this.adminRepository.GetUserPassStats(id);
            if (result == null)
            {
                return Ok("Data Not Found");
            }
            return Ok(result);
        }


    }
}
