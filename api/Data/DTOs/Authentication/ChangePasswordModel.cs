using api.Data.Constants;
using System.ComponentModel.DataAnnotations;

namespace api.Data.DTOs.Authentication
{
    /// <summary>
    /// Change password model
    /// </summary>
    public class ChangePasswordModel
    {
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
        /// New password
        /// </summary>
        [Required]
        [DataType(DataType.Password)]
        [MinLength(UserPassword.Length.Min)]
        [MaxLength(UserPassword.Length.Max)]
        public string NewPassword { get; set; } = null!;

        /// <summary>
        /// Confirm new password
        /// </summary>
        [Required]
        [DataType(DataType.Password)]
        [MinLength(UserPassword.Length.Min)]
        [MaxLength(UserPassword.Length.Max)]
        public string ComfirmationNewPassword { get; set; } = null!;
    }
}
