using api.Data.DTOs.Mail;
using System.Drawing.Text;

namespace api.Commons.Utils
{
    /// <summary>
    /// Mail Template
    /// </summary>
    public class MailTemplate
    {
        /// <summary>
        /// Registration
        /// </summary>
        /// <param name="email"></param>
        /// <param name="confirmationLink"></param>
        /// <returns></returns>
        public static MailDataModel Registration(string email, string confirmationLink)
        {
            List<string> To = new List<string>() { email };
            string Subject = "[Website Name] Registration Confirmation";

            string body = $"Dear {email},<br/><br/>"
                + "Thank you for registering with us. Please click on the below link to verify your email address and to activate your account.<br/><br/>"
                + $"<a href=\"{confirmationLink}\">Confirmation Link Here</a><br/><br/>"
                + "Regards,<br/>"
                + "[Website Name] Team";
            return new MailDataModel(To, Subject, body);
        }

        /// <summary>
        /// Forgot Password
        /// </summary>
        /// <param name="email"></param>
        /// <param name="confirmationLink"></param>
        /// <returns></returns>
        public static MailDataModel ForgotPassword(string email, string confirmationLink)
        {
            List<string> To = new List<string>() { email };
            string Subject = "[Website Name] Forgot Password";

            string body = $"Dear {email},<br/><br/>"
                + "We have received a request to reset your password. Please click on the below link to reset your password.<br/><br/>"
                + $"<a href=\"{confirmationLink}\">Reset Password Link Here</a><br/><br/>"
                + "Regards,<br/>"
                + "[Website Name] Team";

            return new MailDataModel(To, Subject, body);
        }
    }
}
