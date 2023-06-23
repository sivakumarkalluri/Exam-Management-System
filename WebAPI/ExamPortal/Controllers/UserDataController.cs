using ExamPortal.Data;
using ExamPortal.Models.Domain.Auth;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ExamPortal.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserDataController : ControllerBase
    {
        private readonly ExamPortalDBContext examPortalDBContext;
        private readonly IConfiguration configuration;

        public UserDataController(ExamPortalDBContext examPortalDBContext, IConfiguration configuration)
        {
            this.examPortalDBContext = examPortalDBContext;
            this.configuration = configuration;
        }

        [HttpPost]
        public async Task<IActionResult> Post(Registration registerData)
        {
            if (this.examPortalDBContext.register.Where(u => u.Email == registerData.Email).FirstOrDefault() != null)
            {
                return Ok("Already Exist");
            }
            registerData.registeredAt = DateTime.Now;
            registerData.Role = "User";
            await this.examPortalDBContext.register.AddAsync(registerData);
            await this.examPortalDBContext.SaveChangesAsync();
            return Ok("Success");
        }

        [HttpPost("AddAdmin")]
        public async Task<IActionResult> AddAdmin(Registration registerData)
        {
            if (this.examPortalDBContext.register.Where(u => u.Email == registerData.Email).FirstOrDefault() != null)
            {
                return Ok("Already Exist");
            }
            registerData.registeredAt = DateTime.Now;
            registerData.Role = "Admin";
            registerData.Password = "admin";
            await this.examPortalDBContext.register.AddAsync(registerData);
            await this.examPortalDBContext.SaveChangesAsync();
            return Ok("Success");
        }

        [HttpDelete("DeleteAdmin/{id}")]
        public async Task<IActionResult> DeleteAdmin(int id)
        {
            var data = await this.examPortalDBContext.register.FindAsync(id);
            if (data == null)
            {
                Ok("Data not Found");
            }

            this.examPortalDBContext.register.Remove(data);
            await this.examPortalDBContext.SaveChangesAsync();

            return Ok(id);
        }

        [HttpGet("GetAdminsData")]

        public async Task<IActionResult> GetAdminsData()
        {
            var data = this.examPortalDBContext.register.Where(u => u.Role == "Admin").OrderByDescending(u=>u.registeredAt).ToList();
            if (data == null)
            {
                Ok("Data not Found");
            }
            return Ok(data);

        }





        [HttpGet("UserData/{id}")]
        public async Task<IActionResult> GetUser(int id) 
        {
            var data=await this.examPortalDBContext.register.FindAsync(id);
            if(data == null)
            {
                Ok("Data not Found");
            }
            return Ok(data);
            
        }
        

        [HttpPost("LoginUser")]
        public IActionResult Login(Login user)
        {
            var userAvailable = this.examPortalDBContext.register.Where(u => u.Email == user.Email && u.Password == user.Password).FirstOrDefault();
            if (userAvailable == null)
            {
                return Ok("failure");
            }
            return Ok(new JwtService(this.configuration).GenerateToken(
                userAvailable.UserId.ToString(),
                userAvailable.FirstName,
                userAvailable.LastName,
                userAvailable.Email,
                userAvailable.Mobile,
                userAvailable.Role
                ));
        }

        [HttpPut("EditUserData/{id}")]
        public async Task<IActionResult> EditUserData(Registration inputData,int id)
        {
            var data = await this.examPortalDBContext.register.FindAsync(id);
            if(data== null)
            {
                Ok("Data not Found");
            }
            
            data.FirstName= inputData.FirstName;
            data.LastName= inputData.LastName;
            data.Gender= inputData.Gender;
            data.Mobile= inputData.Mobile;
            data.Email=inputData.Email;
            data.Password=inputData.Password;
            await this.examPortalDBContext.SaveChangesAsync();
            return Ok(data);

        }
    }
}
