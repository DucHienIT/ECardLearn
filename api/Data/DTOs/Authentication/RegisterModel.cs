using api.Data.Constants;
using System.ComponentModel.DataAnnotations;

namespace api.Data.DTOs.Authentication
{
    /// <summary>
    /// Register model
    /// </summary>
    public class RegisterModel
    {
        /// <summary>
        /// User name
        /// </summary>
        [Required]
        public string UserName { get; set; } = null!;

        /// <summary>
        /// Email
        /// </summary>
        [Required]
        [EmailAddress]
        public string Email { get; set; } = null!;

        /// <summary>
        /// Password
        /// </summary>
        [Required]
        [DataType(DataType.Password)]
        [MinLength(UserPassword.Length.Min)]
        [MaxLength(UserPassword.Length.Max)]
        public string Password { get; set; } = null!;

        /// <summary>
        /// Phone number
        /// </summary>
        [Required]
        [Phone]
        public string PhoneNumber { get; set; } = null!;

        /// <summary>
        /// Full name
        /// </summary>
        [Required]
        public string FullName { get; set; } = null!;

        /// <summary>
        /// Birth date
        /// </summary>
        [Required]
        [DataType(DataType.Date)]
        public DateTime BirthDate { get; set; }
    }
}
