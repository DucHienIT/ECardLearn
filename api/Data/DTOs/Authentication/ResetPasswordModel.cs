using System.ComponentModel.DataAnnotations;

namespace api.Data.DTOs.Authentication
{
    /// <summary>
    /// Password reset model
    /// </summary>
    public class ResetPasswordModel
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
        [StringLength(32, ErrorMessage = "PASSWORD_MIN_LENGTH", MinimumLength = 8)]
        public string Password { get; set; } = null!;

        /// <summary>
        /// Confirm password
        /// </summary>
        [Required]
        [StringLength(32, ErrorMessage = "PASSWORD_MIN_LENGTH", MinimumLength = 8)]
        public string ConfirmPassword { get; set; } = null!;

        /// <summary>
        /// Token
        /// </summary>
        [Required]
        public string Token { get; set; } = null!;
    }
}
