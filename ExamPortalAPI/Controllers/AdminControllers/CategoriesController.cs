using ExamPortal.Repositories.AdminRepo;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ExamPortalAPI.Controllers.AdminControllers
{
    [Route("api/")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {
        private readonly IAdminRepository adminRepository;

        public CategoriesController(IAdminRepository adminRepository)
        {
            this.adminRepository = adminRepository;
        }
        [HttpGet("Categories")]
        public async Task<IActionResult> GetCategories()
        {
            var result = await this.adminRepository.GetCategoriesData();
            if (result == null)
            {
                return Ok("Data not Found");
            }
            return Ok(result);
        }
    }
}
