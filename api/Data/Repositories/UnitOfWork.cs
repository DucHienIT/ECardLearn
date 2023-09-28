using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;

namespace api.Data.Repositories
{
    /// <summary>
    /// Unit of work
    /// </summary>
    public class UnitOfWork : IUnitOfWork, IDisposable
    {
        private readonly DbContext _dbContext;
        private IDbContextTransaction? _transaction = null;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="dbContext"></param>
        public UnitOfWork(DbContext dbContext)
        {
            _dbContext = dbContext;
        }

        /// <summary>
        /// Save Changes
        /// </summary>
        /// <returns></returns>
        public int SaveChanges()
        {
            return _dbContext.SaveChanges();
        }

        /// <summary>
        /// Dispose
        /// </summary>
        public void Dispose()
        {
            _dbContext.Dispose();
            GC.SuppressFinalize(this);
        }

        /// <summary>
        /// Begin transaction
        /// </summary>
        public void BeginTransaction()
        {
            _transaction = _dbContext.Database.BeginTransaction();
        }

        /// <summary>
        /// Commit transaction
        /// </summary>
        public void CommitTransaction()
        {
            if (_transaction != null)
            {
                _transaction.Commit();
                _transaction.Dispose();
            }
        }

        /// <summary>
        /// Rollback transaction
        /// </summary>
        public void RollbackTransaction()
        {
            if (_transaction != null)
            {
                _transaction.Rollback();
                _transaction.Dispose();
            }
        }
    }
}
