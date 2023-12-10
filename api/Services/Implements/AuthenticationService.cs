using api.Commons.Utils;
using api.Data.Constants;
using api.Data.DTOs.Authentication;
using api.Data.Entities;
using api.Services.Interfaces;
using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.WebUtilities;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace api.Services.Implements
{
    /// <summary>
    /// Authentication service
    /// </summary>
    public class AuthenticationService : IAuthenticationService
    {
        private readonly SignInManager<User> _signInManager;
        private readonly UserManager<User> _userManager;
        private readonly IConfiguration _config;
        private readonly IMapper _mapper;
        private readonly IMailService _mailService;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="signInManager"></param>
        /// <param name="userManager"></param>
        /// <param name="config"></param>
        /// <param name="mapper"></param>
        /// <param name="mailService"></param>
        public AuthenticationService(SignInManager<User> signInManager,
            UserManager<User> userManager,
            IConfiguration config,
            IMapper mapper,
            IMailService mailService)
        {
            _signInManager = signInManager;
            _userManager = userManager;
            _config = config;
            _mapper = mapper;
            _mailService = mailService;
        }

        /// <summary>
        /// Register new user
        /// </summary>
        /// <param name="registerModel"></param>
        /// <returns></returns>
        public async Task<IdentityResult> Register(RegisterModel registerModel)
        {
            // map model to entity
            var applicationUser = _mapper.Map<User>(registerModel);
            applicationUser.LockoutEnabled = true;

            var password = registerModel.Password;

            // create new user
            var userResult = await _userManager.CreateAsync(applicationUser, password);

            if (userResult.Succeeded)
            {
                var email = registerModel.Email;

                // generate email confirmation token
                var token = await _userManager.GenerateEmailConfirmationTokenAsync(applicationUser);
                var encodedToken = WebEncoders.Base64UrlEncode(Encoding.UTF8.GetBytes(token));

                // generate email confirmation link
                var confirmationLink = $"{_config["AppUrl"]}/api/confirm-email?email={email}&token={encodedToken}";

                // send email confirmation link
                await _mailService.SendAsync(MailTemplate.Registration(email, confirmationLink), new CancellationToken());

                // add user to user role
                var user = await _userManager.FindByEmailAsync(email);

                if (user != null)
                {
                    var result = await _userManager.AddToRoleAsync(user, UserRoles.Student);

                    return result;
                }
            }

            return IdentityResult.Failed(new IdentityError { Code = "500", Description = "Failed to register user." });
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="email"></param>
        /// <param name="token"></param>
        /// <returns></returns>
        public async Task<IdentityResult> ConfirmEmail(string email, string token)
        {
            // get user by email
            var user = await _userManager.FindByEmailAsync(email);

            if (user != null)
            {
                // decode token
                var decodedTokenBytes = WebEncoders.Base64UrlDecode(token);
                var decodedToken = Encoding.UTF8.GetString(decodedTokenBytes);

                // confirm email
                var result = await _userManager.ConfirmEmailAsync(user, decodedToken);

                return result;
            }

            return IdentityResult.Failed(new IdentityError { Code = "500", Description = "Failed to confirm email." });
        }

        /// <summary>
        /// Login
        /// </summary>
        /// <param name="loginModel"></param>
        /// <returns></returns>
        /// <exception cref="Exception"></exception>
        public async Task<(string, UserProfileModel?)> Login(LoginModel loginModel)
        {
            var email = loginModel.Email;
            var password = loginModel.Password;
            var rememberMe = loginModel.RememberMe;

            var user = await _userManager.FindByEmailAsync(email);

            if (user != null)
            {
                var username = user.UserName!;

                var result = await _signInManager.PasswordSignInAsync(username, password, rememberMe, true);

                if (result.Succeeded)
                {
                    var userVM = _mapper.Map<UserProfileModel>(user);

                    var tokenString = await GenerateJsonWebToken(user);
                    return (tokenString, userVM);
                }
                if (result.IsLockedOut)
                {
                    throw new Exception("User account locked out.");
                }
            }
            return ("", null);
        }

        /// <summary>
        /// Forgot password
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        public async Task<IdentityResult> ForgotPassword(string email)
        {
            var user = await _userManager.FindByEmailAsync(email);

            if (user != null)
            {
                // Generate password reset token
                var token = await _userManager.GeneratePasswordResetTokenAsync(user);

                // Generate password reset URL
                var callbackUrl = $"{_config["AppUrl"]}/api/reset-password?email={email}&token={token}";

                // Send password reset email
                await _mailService.SendAsync(MailTemplate.ForgotPassword(email, callbackUrl), new CancellationToken());

                // Return success result
                return IdentityResult.Success;
            }

            return IdentityResult.Failed(new IdentityError { Description = "User does not exist." });
        }

        /// <summary>
        /// Reset password
        /// </summary>
        /// <param name="resetPasswordModel"></param>
        /// <returns></returns>
        public async Task<IdentityResult> ResetPassword(ResetPasswordModel resetPasswordModel)
        {
            // Get User
            var user = await _userManager.FindByEmailAsync(resetPasswordModel.Email);

            if (user != null)
            {
                // Decode Token
                var decodedTokenBytes = WebEncoders.Base64UrlDecode(resetPasswordModel.Token);
                var decodedToken = Encoding.UTF8.GetString(decodedTokenBytes);

                // Reset Password
                var result = await _userManager.ResetPasswordAsync(user, decodedToken, resetPasswordModel.Password);

                if (result.Succeeded)
                {
                    return result;
                }

                return IdentityResult.Failed(new IdentityError { Description = "Failed to reset password." });
            }

            return IdentityResult.Failed(new IdentityError { Description = "User does not exist." });
        }

        /// <summary>
        /// Change password
        /// </summary>
        /// <param name="changePasswordModel"></param>
        /// <returns></returns>
        public async Task<IdentityResult> ChangePassword(ChangePasswordModel changePasswordModel)
        {
            // Get User
            var user = await _userManager.FindByEmailAsync(changePasswordModel.Email);

            if (user != null)
            {
                // Check User Current Password is Correct
                var currentPasswordCorrect = await _userManager.CheckPasswordAsync(user, changePasswordModel.Password);

                if (currentPasswordCorrect)
                {
                    // Change Password
                    var changePasswordResult = await _userManager.ChangePasswordAsync(user, changePasswordModel.Password, changePasswordModel.NewPassword);

                    if (changePasswordResult.Succeeded)
                    {
                        return changePasswordResult;
                    }

                    return IdentityResult.Success;
                }

                return IdentityResult.Failed(new IdentityError { Description = "Current password is incorrect." });
            }

            return IdentityResult.Failed(new IdentityError { Description = "User does not exist." });
        }

        private async Task<string> GenerateJsonWebToken(User user)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["JWT:Key"]!));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);
            var claims = new List<Claim>
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.UserName!),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
            };

            var role = await _userManager.GetRolesAsync(user);
            claims.AddRange(role.Select(r => new Claim(ClaimsIdentity.DefaultRoleClaimType, r)));

            var token = new JwtSecurityToken(_config["JWT:Issuer"],
                _config["JWT:Issuer"],
                claims,
                null,
                expires: DateTime.Now.AddHours(8),
                signingCredentials: credentials);
            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        /// <summary>
        /// Logout
        /// </summary>
        /// <returns></returns>
        public async Task Logout()
        {
            await _signInManager.SignOutAsync();
        }

    }
}
