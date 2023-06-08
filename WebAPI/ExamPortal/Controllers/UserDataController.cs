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

        // GET: api/<UserDataController>


        //[HttpGet]
        //public IEnumerable<string> Get()
        //{
        //    return new string[] { "value1", "value2" };
        //}

        //// GET api/<UserDataController>/5
        //[HttpGet("{id}")]
        //public string Get(int id)
        //{
        //    return "value";
        //}

        // POST api/<UserDataController>
        [AllowAnonymous]
        [HttpPost]
        public IActionResult Post(Registration registerData)
        {
            if (this.examPortalDBContext.register.Where(u => u.Email == registerData.Email).FirstOrDefault() != null)
            {
                return Ok("Already Exist");
            }
            registerData.registeredAt = DateTime.Now;
            registerData.Role = "User";
            this.examPortalDBContext.register.Add(registerData);
            this.examPortalDBContext.SaveChanges();
            return Ok("Success");
        }


        [AllowAnonymous]
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
    

        // PUT api/<UserDataController>/5
        //[HttpPut("{id}")]
        //public void Put(int id, [FromBody] string value)
        //{
        //}

        // DELETE api/<UserDataController>/5
        //[HttpDelete("{id}")]
        //public void Delete(int id)
        //{
        //}
    }
}
