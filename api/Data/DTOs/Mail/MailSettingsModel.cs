namespace api.Data.DTOs.Mail
{
    /// <summary>
    /// Mail Settings Model
    /// </summary>
    public class MailSettingsModel
    {
        /// <summary>
        /// Display Name
        /// </summary>
        public string? DisplayName { get; set; }

        /// <summary>
        /// From
        /// </summary>
        public string? From { get; set; }

        /// <summary>
        /// Username
        /// </summary>
        public string? UserName { get; set; }

        /// <summary>
        /// Password
        /// </summary>
        public string? Password { get; set; }

        /// <summary>
        /// Host
        /// </summary>
        public string? Host { get; set; }

        /// <summary>
        /// Port
        /// </summary>
        public int Port { get; set; }

        /// <summary>
        /// Use SSL
        /// </summary>
        public bool UseSSL { get; set; }

        /// <summary>
        /// Use Start Tls
        /// </summary>
        public bool UseStartTls { get; set; }
    }
}
