using api.Commons.Utils;
using api.Data;
using api.Data.Constants;
using api.Data.DTOs.Mail;
using api.Data.Entities;
using api.Data.Mappings;
using api.Data.Repositories;
using api.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using System.Reflection;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddRepositories();
builder.Services.AddServices();
builder.Services.AddAutoMapper(typeof(Maps).Assembly);
builder.Services.AddDbContext<DataContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));
});
builder.Services.Configure<MailSettingsModel>(builder.Configuration.GetSection(nameof(MailSettingsModel)));
builder.Services.AddTransient<IMailService, MailService>();

builder.Services
    .AddIdentity<User, Role>()
    .AddEntityFrameworkStores<DataContext>();

builder.Services.Configure<IdentityOptions>(options =>
{
    // Password
    options.Password.RequireDigit = UserPassword.RequireDigit;
    options.Password.RequireLowercase = UserPassword.RequireLowercase;
    options.Password.RequireNonAlphanumeric = UserPassword.RequireNonAlphanumeric;
    options.Password.RequireUppercase = UserPassword.RequireUppercase;
    options.Password.RequiredLength = UserPassword.Length.Min;
    options.Password.RequiredUniqueChars = UserPassword.RequiredUniqueChars;

    // Lockout when trying spam password
    options.Lockout.DefaultLockoutTimeSpan = UserLockout.DefaultLockoutTimeSpan;
    options.Lockout.MaxFailedAccessAttempts = UserLockout.MaxFailedAccessAttempts;
    options.Lockout.AllowedForNewUsers = UserLockout.AllowedForNewUsers;

    // User
    options.User.AllowedUserNameCharacters = UserConfig.AllowedUserNameCharacters;
    options.User.RequireUniqueEmail = UserConfig.RequireUniqueEmail;

    // Login
    options.SignIn.RequireConfirmedEmail = UserSignIn.RequireConfirmedEmail;
    options.SignIn.RequireConfirmedPhoneNumber = UserSignIn.RequireConfirmedPhoneNumber;

});


// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Version = "v1",
        Title = "ToDo API",
        Description = "An ASP.NET Core Web API for managing ToDo items",
        TermsOfService = new Uri("https://example.com/terms"),
        Contact = new OpenApiContact
        {
            Name = "Example Contact",
            Url = new Uri("https://example.com/contact")
        },
        License = new OpenApiLicense
        {
            Name = "Example License",
            Url = new Uri("https://example.com/license")
        }
    });

    // using System.Reflection;
    var xmlFilename = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
    options.IncludeXmlComments(Path.Combine(AppContext.BaseDirectory, xmlFilename));
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}


app.UseHttpsRedirection();

//Seed data
using (var scope = app.Services.CreateScope())
{
    var serviceProvider = scope.ServiceProvider;

    //Identity Authentication
    var roleManager = serviceProvider.GetRequiredService<RoleManager<Role>>();
    SeedData.Seed(roleManager).Wait();

    //AppCtl
    SeedData.Seed(serviceProvider).Wait();
}

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
