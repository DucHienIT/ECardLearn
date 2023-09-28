namespace api.Data.DTOs.Authentication
{
    /// <summary>
    /// User profile
    /// </summary>
    public class UserProfileModel
    {
        /// <summary>
        /// User name
        /// </summary>
        public string UserName { get; set; } = string.Empty;

        /// <summary>
        /// Email
        /// </summary>
        public string Email { get; set; } = string.Empty;

        /// <summary>
        /// Phone number
        /// </summary>
        public string PhoneNumber { get; set; } = string.Empty;
    }
}
