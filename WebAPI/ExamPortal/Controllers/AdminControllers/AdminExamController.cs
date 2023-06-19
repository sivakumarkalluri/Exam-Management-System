using ExamPortal.Models.Domain;
using ExamPortal.Models.DTO;
using ExamPortal.Repositories.AdminRepo;
using Microsoft.AspNetCore.Components.Forms;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualBasic;

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


        [HttpGet("GetExamQuestions/{id}")]
        public async Task<IActionResult> GetExamQuestions(int id)
        {
            var result = await this.adminRepository.GetExamQuestionsData(id);
            if (result == null)
            {
                return Ok("Data not Found");
            }
            return Ok(result);

        }

        [HttpGet("ExamData/{id}")]
        public async Task<IActionResult> GetExamData(int id)
        {
            var result = await this.adminRepository.GetExamData(id);
            if (result == null)
            {
                return Ok("Data not Found");
            }
            return Ok(result);

        }


        [HttpPut("EditQuestion/{id}")]
        public async Task<IActionResult> EditQuestion(Questions question, int id)
        {
            var result = await this.adminRepository.EditQuestion(question,id);
            if (result == null)
            {
                return Ok("Data not Found");
            }
            return Ok(result);

        }

        [HttpPost("AddQuestion")]

        public async Task<IActionResult> AddQuestion(Questions question)
        {
            var result = await this.adminRepository.AddQuestion(question);
            if (result == null)
            {
                return Ok("Unable to Add Data");
            }
            return Ok(result);

        }

        [HttpDelete("DeleteQuestion/{id}")]
        public async Task<IActionResult> DeleteQuestion(int id)
        {
            var result= await this.adminRepository.DeleteQuestion(id);
            if (result == null)
            {
                return Ok("Data not Found");
            }
            return Ok(result);

        }

        [HttpPut("EditExam/{id}")]
        public async Task<IActionResult> EditExam(Exam exam,int id)
        {
            var result = await this.adminRepository.EditExam(exam,id);
            if (result == null)
            {
                return Ok("Data not Found");
            }
            return Ok(result);

        }



        [HttpDelete("DeleteExam/{id}")]
        public async Task<IActionResult> DeleteExam(int id)
        {
            var data = await this.adminRepository.DeleteExam(id);
            if (data == null )
            {
                return Ok("Unable to Fetch the Data or No Data");

            }
            return Ok(data);


        }

        [HttpGet("AnswerSheet/{id}")]

        public async Task<IActionResult> GetAnswerSheet(int id)
        {
            var result = await this.adminRepository.GetAnswerSheet(id);
            if (result == null)
            {
                return Ok("Data not Found");
            }
            return Ok(result);

        }




    }
}
