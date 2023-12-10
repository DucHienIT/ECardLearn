using api.Data.DTOs.Authentication;
using api.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    /// <summary>
    /// Authentication controller
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    public class AuthenticationController : ControllerBase
    {
        private readonly IAuthenticationService _authenticationService;
        private readonly ILogger<AuthenticationController> _logger;


        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="authenticationService"></param>
        /// <param name="logger"></param>
        public AuthenticationController(IAuthenticationService authenticationService, ILogger<AuthenticationController> logger)
        {
            _authenticationService = authenticationService;
            _logger = logger;
        }

        /// <summary>
        /// Register
        /// </summary>
        /// <param name="userModel"></param>
        /// <returns></returns>
        [HttpPost]
        [AllowAnonymous]
        [Route("[action]")]
        public async Task<IActionResult> Register([FromBody] RegisterModel userModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _authenticationService.Register(userModel);

            if (!result.Succeeded)
            {
                foreach (var error in result.Errors)
                {
                    _logger.LogInformation($"Registration attempt failed. ErrorCode: {error.Code}. Description: {error.Description}");
                }

                return BadRequest(new { Errors = result.Errors });
            }

            return Ok(new { result.Succeeded });
        }

        /// <summary>
        /// Confirm email
        /// </summary>
        /// <param name="email"></param>
        /// <param name="token"></param>
        /// <returns></returns>
        [HttpGet]
        [AllowAnonymous]
        [Route("[action]")]
        public async Task<IActionResult> ConfirmEmail(string email, string token)
        {
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(token))
            {
                return NotFound();
            }

            var result = await _authenticationService.ConfirmEmail(email, token);

            if (!result.Succeeded)
            {
                return BadRequest(new { Errors = result.Errors });
            }

            return Ok(new { result.Succeeded });
        }

        /// <summary>
        /// Login
        /// </summary>
        /// <param name="loginModel"></param>
        /// <returns></returns>
        [HttpPost]
        [AllowAnonymous]
        [Route("[action]")]
        public async Task<IActionResult> Login([FromBody] LoginModel loginModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _authenticationService.Login(loginModel);

            var token = result.Item1;
            var userVM = result.Item2;

            if (string.IsNullOrEmpty(token) || userVM is null)
            {
                _logger.LogError("User does not exist or login failed.");
                return Unauthorized(new { Error = "Invalid credentials." }); // Nếu lỗi check Database xem email confirm chưa.
            }

            return Ok(new { Token = token, User = userVM });
        }

        /// <summary>
        /// Forgot password
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        [HttpPost]
        [AllowAnonymous]
        [Route("[action]")]
        public async Task<IActionResult> ForgotPassword(string email)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _authenticationService.ForgotPassword(email);

            if (result.Succeeded)
            {
                return Ok();
            }

            var errors = result.Errors.Select(error => error.Description);
            return BadRequest(errors);
        }

        /// <summary>
        /// Reset password
        /// </summary>
        /// <param name="resetPasswordModel"></param>
        /// <returns></returns>
        [HttpPost]
        [AllowAnonymous]
        [Route("[action]")]
        public async Task<IActionResult> ResetPassword([FromBody] ResetPasswordModel resetPasswordModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _authenticationService.ResetPassword(resetPasswordModel);

            if (result.Succeeded)
            {
                return Ok();
            }

            var errors = result.Errors.Select(error => error.Description);
            return BadRequest(errors);
        }

        /// <summary>
        /// Change password
        /// </summary>
        /// <param name="changePasswordModel"></param>
        /// <returns></returns>
        [HttpPost]
        [Authorize]
        [Route("[action]")]
        public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordModel changePasswordModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            var result = await _authenticationService.ChangePassword(changePasswordModel);

            if (result.Succeeded)
            {
                return Ok();
            }

            var errors = result.Errors.Select(error => error.Description);
            return BadRequest(errors);
        }

        /// <summary>
        /// Logout
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Authorize]
        [Route("[action]")]
        public async Task<IActionResult> Logout()
        {
            await _authenticationService.Logout();

            return Ok();
        }
    }
}
