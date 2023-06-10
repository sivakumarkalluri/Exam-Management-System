using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ExamPortal.Models.Domain
{
    [Table("Categories")]
    public class Categories
    {
        [Key]

        [Column("category_id")]
        public int CategoryId { get; set; }

        [Column("category_name")]
        public string CategoryName { get; set; }

        [Column("category_desc")]
        public string CategoryDesc { get; set; }
    }
}
