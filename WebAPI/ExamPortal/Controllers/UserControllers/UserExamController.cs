using ExamPortal.Models.Domain;
using ExamPortal.Models.DTO.Users;
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

        [HttpPost("ExamEvaluation")]

        public async Task<IActionResult> ExamEvaluation(ExamEvaluationRequest request)
        {
            var result = 0;
            var inputData = request.InputData;
            var testID = await this.adminRepository.GetTestID();
            if (testID != null)
            {
                DateTime currentDate = DateTime.Now;

                // Add testId and attemptedAt to each item in inputData
                var userExamDataList = inputData.Select(item => new UserExamData
                {
                    testId = testID,
                    userId = item.user_id,
                    exam_id = item.exam_id,
                    category_id = item.category_id,
                    question_id = item.question_id,
                    answer = item.answer,
                    attemptedAt = currentDate
                }).ToList();

                // Insert userExamDataList into the userExamData table
                result=await this.adminRepository.AddUserExamData(userExamDataList);

                // Return a success response
               


            }
            if (result == 0)
            {
                return Ok("Unable to Evaluate Results");
            }
            return Ok(result);

        }



    }
}
