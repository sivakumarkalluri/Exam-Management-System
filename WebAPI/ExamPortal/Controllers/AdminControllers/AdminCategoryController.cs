using ExamPortal.Repositories.AdminRepo;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ExamPortal.Controllers.AdminControllers
{
    [Route("api/Categories")]
    [ApiController]
    public class AdminCategoryController : ControllerBase
    {
        private readonly IAdminRepository adminRepository;

        public AdminCategoryController(IAdminRepository adminRepository)
        {
            this.adminRepository = adminRepository;
        }

        [HttpGet]
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
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<AdminCategoryController>
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<AdminCategoryController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<AdminCategoryController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
