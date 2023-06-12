using ExamPortal.Models.DTO;
using ExamPortal.Repositories.AdminRepo;
using Microsoft.AspNetCore.Components.Forms;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ExamPortal.Controllers.AdminControllers
{
    [Route("api/")]
    [ApiController]
    public class AdminExamController : ControllerBase
    {
        private readonly IAdminRepository adminRepository;

        public AdminExamController(IAdminRepository adminRepository)
        {
            this.adminRepository = adminRepository;
        }

        [HttpPost("AddExam")]
        public async Task<IActionResult> Post(AddExamDTO inputData)
        {
            var result = await this.adminRepository.AddExam(inputData); 
            if (result == null)
            {
                return Ok("Unable to Post Data");
            }
            return Ok(result);
        }

        // PUT api/<AdminExamController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<AdminExamController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
