using ExamPortal.Data;

namespace ExamPortal.Repositories.ImageRepo
{
    public class SqlImageRepository:IImageRepository
    {

        public readonly IWebHostEnvironment webHostEnvironment;
        public readonly IHttpContextAccessor httpContextAccessor;
        private readonly ExamPortalDBContext dbContext;

        public SqlImageRepository(IWebHostEnvironment webHostEnvironment, IHttpContextAccessor httpContextAccessor, ExamPortalDBContext dbContext)
        {
            this.webHostEnvironment = webHostEnvironment;
            this.httpContextAccessor = httpContextAccessor;
            this.dbContext = dbContext;
        }
        //To get the path for Local Folder
        public async Task<string> Upload(IFormFile file, string fileName)
        {
            var localFilePath = Path.Combine(webHostEnvironment.ContentRootPath, "ProfileImages", $"{fileName}");

            //var filePath = Path.Combine(Directory.GetCurrentDirectory(), @"Images", fileName);
            using Stream fileStream = new FileStream(localFilePath, FileMode.Create);
            await file.CopyToAsync(fileStream);
            var urlFilePath = $"{httpContextAccessor.HttpContext.Request.Scheme}://{httpContextAccessor.HttpContext.Request.Host}{httpContextAccessor.HttpContext.Request.PathBase}/ProfileImages/{fileName}";
            return urlFilePath;

        }
        //private string GetServerRelativePath(string fileName)
        //{
        //    return Path.Combine(@"ProfileImages", fileName);
        //}
    }
}
