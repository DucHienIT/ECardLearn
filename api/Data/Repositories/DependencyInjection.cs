namespace api.Data.Repositories
{
    /// <summary>
    /// Dependency injection
    /// </summary>
    public static class DependencyInjection
    {
        /// <summary>
        /// Add repositories
        /// </summary>
        /// <param name="service"></param>
        /// <returns></returns>
        public static IServiceCollection AddRepositories(this IServiceCollection service)
        {
            return service;
        }
    }

}
