using ExamPortal.Data;
using ExamPortal.Models.DTO;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ExamPortal.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ExamController : ControllerBase
    {
        private readonly ExamPortalDBContext context;

        public ExamController(ExamPortalDBContext context)
        {
            this.context = context;
        }

        // GET: api/<ExamController>
        [HttpGet]
        [Route("ExamsList")]
        public IActionResult GetExamsList()
        {
            var data = this.context.exams.ToList();
            if(data == null || data.Count == 0)
            {
                return Ok("Unable to Fetch the Data or No Data");

            }

            var examsDto = new List<ExamListDTO>();
            foreach (var exam in data)
            {
                var examDto = new ExamListDTO
                {
                    ExamID = exam.ExamId,
                    ExamName = exam.ExamName,
                    ExamDescription = exam.ExamDescription,

                };
                examsDto.Add(examDto);

            }
            return Ok(examsDto);

        }


        [Authorize]

        [HttpGet]
        [Route("UserExamsData")]

        public IActionResult GetUserExamsData()
        {
            var data = this.context.exams.ToList();
            if (data == null || data.Count == 0)
            {
                return Ok("Unable to Fetch the Data or No Data");

            }
            return Ok(data);


        }


        

    }
}
