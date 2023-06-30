using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ExamPortal.Models.Domain
{
    
    public class Categories
    {
        [Key]

      
        public int CategoryId { get; set; }

        public string CategoryName { get; set; }

       
        public string CategoryDesc { get; set; }
    }
}
