using ExamPortal.Repositories.AdminRepo;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ExamPortal.Controllers.UserControllers
{
    [Route("api/")]
    [ApiController]
    public class UserExamController : ControllerBase

    {
        private readonly IAdminRepository adminRepository;

        public UserExamController(IAdminRepository adminRepository)
        {
            this.adminRepository = adminRepository;
        }

        [HttpGet("UserAllResults/{id}")]
        public async Task<IActionResult> GetUserResultsAll(int id)
        {
            var data = await this.adminRepository.GetUserResultsAll(id);
            if(data== null)
            {
                Ok("Data not Found");
            }
            return Ok(data);
        }

        [HttpGet("UserExamSheet/{id}")]
        public async Task<IActionResult> GetUserExamSheet(int id)
        {
            var data = await this.adminRepository.GetUserExamSheet(id);
            if (data == null)
            {
                Ok("Data not Found");
            }
            return Ok(data);
        }



    }
}
