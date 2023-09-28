using api.Services;
using api.Services.Implements;
using api.Services.Interfaces;

namespace api.Services
{
    /// <summary>
    /// Dependency injection
    /// </summary>
    public static class DependencyInjection
    {
        /// <summary>
        /// Add services
        /// </summary>
        /// <param name="service"></param>
        /// <returns></returns>
        public static IServiceCollection AddServices(this IServiceCollection service)
        {
            service.AddTransient<IAuthenticationService, AuthenticationService>();
            return service;
        }
    }

}
