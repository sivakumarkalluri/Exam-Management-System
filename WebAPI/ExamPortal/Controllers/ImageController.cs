using ExamPortal.Data;
using ExamPortal.Repositories.AdminRepo;
using ExamPortal.Repositories.ImageRepo;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ExamPortal.Controllers
{
    [Route("api/")]
    [ApiController]
    public class ImageController : ControllerBase

    {
        private readonly IImageRepository imageRepository;
        private readonly IAdminRepository adminRepository;

        public ImageController(IImageRepository imageRepository,IAdminRepository adminRepository)
        {
            this.imageRepository = imageRepository;
            this.adminRepository = adminRepository;
        }

        // GET: api/<ImageController>
        [HttpPost]

        [Route("ProfileImage/{id}/upload-image")]
        public async Task<IActionResult> UploadImage([FromRoute] int id, IFormFile profileImage)
        {
            var data = await this.adminRepository.GetUserData(id);
            if (data != null)
            {
                var fileName = data.FirstName + data.UserId.ToString()+ Path.GetExtension(profileImage.FileName);
                var fileImagePath = await this.imageRepository.Upload(profileImage, fileName);

                if (await adminRepository.UpdateImage(id, fileImagePath))
                {
                    return Ok(fileImagePath);
                }
                return StatusCode(StatusCodes.Status500InternalServerError, "Error Uploading Image");
            }
            return NotFound();
        }
    }
}
