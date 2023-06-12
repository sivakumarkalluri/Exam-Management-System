using ExamPortal.Models.DTO;
using ExamPortal.Repositories.AdminRepo;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ExamPortal.Controllers.AdminControllers
{
    [Route("api/")]
    [ApiController]
    public class AdminCategoryController : ControllerBase
    {
        private readonly IAdminRepository adminRepository;

        public AdminCategoryController(IAdminRepository adminRepository)
        {
            this.adminRepository = adminRepository;
        }

        [HttpGet("Categories")]
        public async Task<IActionResult> GetCategories()
        {
            var result=await this.adminRepository.GetCategoriesData();
            if (result == null)
            {
                return Ok("Data not Found");
            }
            return Ok(result);
        }

        // GET api/<AdminCategoryController>/5
        [HttpPost("CreateCategoryExamQuestions")]
        public async Task<IActionResult> PostCategoryExamQuestions(InsertCategoryExamQuestionsDTO inputData)
        {
            var result= await this.adminRepository.InsertCategoryExamQuestions(inputData);
            if (result == null)
            {
                return Ok("Unable to Post Data");
            }
            return Ok(result);
        }



        // POST api/<AdminCategoryController>
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<AdminCategoryController>/5
        
        // DELETE api/<AdminCategoryController>/5
        [HttpDelete("DeleteCategory/{id}")]
        public async Task<DeleteCategoryDTO> Delete(int id)
        {
            var result = await this.adminRepository.DeleteCategory(id);
            if (result == null)
            {
                return null;
            }
            return result;
        }
    }
}
