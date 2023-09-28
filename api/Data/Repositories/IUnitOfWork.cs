namespace api.Data.Repositories
{
    /// <summary>
    /// Unit of Work Interface
    /// </summary>
    public interface IUnitOfWork : IDisposable
    {
        /// <summary>
        /// Commit Transaction
        /// </summary>
        void CommitTransaction();

        /// <summary>
        /// Rollback Transaction
        /// </summary>
        void RollbackTransaction();

        /// <summary>
        /// Save Changes
        /// </summary>
        /// <returns></returns>
        int SaveChanges();

        /// <summary>
        /// Begin Transaction
        /// </summary>
        void BeginTransaction();
    }

}
