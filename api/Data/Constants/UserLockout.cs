namespace api.Data.Constants
{
    /// <summary>
    /// User lockout constants
    /// </summary>
    public class UserLockout
    {
        /// <summary>
        /// Default lockout time span
        /// </summary>
        public static TimeSpan DefaultLockoutTimeSpan = TimeSpan.FromMinutes(5);

        /// <summary>
        /// Max failed access attempts
        /// </summary>
        public const int MaxFailedAccessAttempts = 5;

        /// <summary>
        /// Allowed for new users
        /// </summary>
        public const bool AllowedForNewUsers = false;
    }
}
