using FarmOps.Services;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
using FarmOps.Models.LoginModels;
using FarmOps.Models.Application;
namespace FarmOps.Controllers
{
    public class LoginController : Controller
    {   
        private readonly LoginService _loginService;
        public LoginController(LoginService loginService)
        {
            _loginService = loginService;
        }
        public IActionResult Index()
        {
            ClaimsPrincipal principal = HttpContext.User;
            if (principal.Identity.IsAuthenticated)
            {
                return RedirectToAction("Index", "Home");
            }
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Index(LoginView data)
        {
            try
            {
                FLogin userData = new();
                if (data != null && data.AccountType != null && data.Email != null && data.Password != null)
                {
                    userData = _loginService.verifyLogin(data.AccountType, data.Email, data.Password);
                }
                if (userData.EmailAddress != null)
                {
                    HttpContext.Session.SetString("FarmOpsUserEmail", userData.EmailAddress);
                    HttpContext.Session.SetString("FarmOpsUserId", userData.UserId);
                    HttpContext.Session.SetString("FarmOpsUserType", userData.UserType);

                    var claims = new List<Claim>
                    {
                        new Claim(ClaimTypes.Name, userData.UserId)
                    };

                    var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                    var claimsPrincipal = new ClaimsPrincipal(claimsIdentity);

                    // Sign in the user
                    await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, claimsPrincipal);
                    //await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
                    return RedirectToAction("Index", "Home");
                }
                ViewBag.Message = "Invalid username or password. Please try again.";
            }
            catch (Exception ex) {
                ViewBag.Message = "Opps! Something went wrong. Please try again later.";
            }
            
            return View();
        }

        public async Task<IActionResult> Logout()
        {
            try
            {
                // Clear the session data
                HttpContext.Session.Clear();

                // Sign out the user by clearing the authentication cookie
                await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

                // Optionally, you can redirect to the Login page after logging out
                return RedirectToAction("Index", "Login");
            }
            catch (Exception ex)
            {
                // Handle any errors that might occur during logout (e.g., log them)
                ViewBag.Message = "Opps! Something went wrong. Please try again later.";
                return RedirectToAction("Index", "Home");
            }
        }

        [HttpPost("SignUp")]
        public async Task<IActionResult> SignUp(Signup model)
        {
            if (!ModelState.IsValid)
                return View("Index", model);

            var result = await _loginService.SignUp(model);

            if (result.Success)
            {
                // Auto-login after signup using same login flow
                var loginView = new LoginView
                {
                    Email = model.Email,
                    Password = model.Password,
                    AccountType = model.Type
                };

                // Reuse login logic (call your login method)
                return await Index(loginView);
            }

            ViewBag.Error = result.Error;
            return View("Index", model);
        }

    }
}
