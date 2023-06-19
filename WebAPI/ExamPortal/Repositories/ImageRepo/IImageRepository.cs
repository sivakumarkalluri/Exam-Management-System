namespace ExamPortal.Repositories.ImageRepo
{
    public interface IImageRepository
    {
        Task<string> Upload(IFormFile file, string fileName);

    }
}
