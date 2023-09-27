using api.Data.Constants;
using api.Data.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.CodeAnalysis;
using System.Reflection;

namespace api.Data
{
    /// <summary>
    /// Seed data
    /// </summary>
    public static class SeedData
    {
        /// <summary>
        /// Seed data
        /// </summary>
        /// <param name="roleManager"></param>
        /// <returns></returns>
        public async static Task Seed(RoleManager<Role> roleManager)
        {
            await SeedRoles(roleManager);
        }

        private async static Task SeedRoles(RoleManager<Role> roleManager)
        {
            var defaultRole = roleManager.Roles?
                .OrderBy(x => x.Id)
                .FirstOrDefault();

            if (defaultRole != null)
            {
                return;
            }

            if (!await roleManager.RoleExistsAsync(UserRoles.Student))
            {
                var role = new Role
                {
                    Name = UserRoles.Student
                };

                await roleManager.CreateAsync(role);
            }

            if (!await roleManager.RoleExistsAsync(UserRoles.Teacher))
            {
                var role = new Role
                {
                    Name = UserRoles.Teacher
                };

                await roleManager.CreateAsync(role);
            }

            if (!await roleManager.RoleExistsAsync(UserRoles.Admin))
            {
                var role = new Role
                {
                    Name = UserRoles.Admin,
                };

                await roleManager.CreateAsync(role);
            }
        }

        /// <summary>
        /// Seed data
        /// </summary>
        /// <param name="service"></param>
        /// <returns></returns>
        public async static Task Seed(IServiceProvider service)
        {
            var dbContext = service.GetService<DataContext>();
            if (dbContext != null)
            {
                await SeedUsers(dbContext);
            }
        }

        private static async Task SeedUsers(DataContext dbContext)
        {
            await Task.Delay(0);
            //var data = dbContext.ApplicationUsers.FirstOrDefault();
            //if (data != null)
            //{
            //    return;
            //}
            //IList<ApplicationUser> defaultData = new List<ApplicationUser>();
            //defaultData.Add(new ApplicationUser());

            //await dbContext.ApplicationUsers.AddRangeAsync(defaultData);
            //await dbContext.SaveChangesAsync();
        }
    }
}