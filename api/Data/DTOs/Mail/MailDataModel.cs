namespace api.Data.DTOs.Mail
{
    /// <summary>
    /// Mail Data Model
    /// </summary>
    public class MailDataModel
    {
        #region Receiver
        /// <summary>
        /// To
        /// </summary>
        public List<string> To { get; }

        /// <summary>
        /// BCC
        /// </summary>
        public List<string> Bcc { get; }

        /// <summary>
        /// CC
        /// </summary>
        public List<string> Cc { get; }
        #endregion

        #region Sender
        /// <summary>
        /// From
        /// </summary>
        public string? From { get; }

        /// <summary>
        /// Display Name
        /// </summary>
        public string? DisplayName { get; }

        /// <summary>
        /// Reply To
        /// </summary>
        public string? ReplyTo { get; }

        /// <summary>
        /// Reply To Name
        /// </summary>
        public string? ReplyToName { get; }
        #endregion

        #region Content
        /// <summary>
        /// Subject
        /// </summary>
        public string Subject { get; }

        /// <summary>
        /// Body
        /// </summary>
        public string? Body { get; }
        #endregion

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="to"></param>
        /// <param name="subject"></param>
        /// <param name="body"></param>
        /// <param name="from"></param>
        /// <param name="displayName"></param>
        /// <param name="replyTo"></param>
        /// <param name="replyToName"></param>
        /// <param name="bcc"></param>
        /// <param name="cc"></param>
        public MailDataModel(List<string> to, string subject, string? body = null, string? from = null, string? displayName = null, string? replyTo = null, string? replyToName = null, List<string>? bcc = null, List<string>? cc = null)
        {
            // Receiver
            To = to;
            Bcc = bcc ?? new List<string>();
            Cc = cc ?? new List<string>();

            // Sender
            From = from;
            DisplayName = displayName;
            ReplyTo = replyTo;
            ReplyToName = replyToName;

            // Content
            Subject = subject;
            Body = body;
        }
    }
}
