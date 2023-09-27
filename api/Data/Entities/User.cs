using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;

namespace api.Data.Entities
{
    /// <summary>
    /// User
    /// </summary>
    public class User : IdentityUser<Guid>
    {
        /// <summary>
        /// Name
        /// </summary>
        [Required]
        public required string Name { get; set; }

        /// <summary>
        /// Birth date
        /// </summary>
        [Required]
        [DataType(DataType.Date)]
        [Column(TypeName = "Date")]
        public DateTime BirthDate { get; set; }

        /// <summary>
        /// Is active
        /// </summary>
        [Required]
        public bool IsActive { get; set; } = true;
    }
}
