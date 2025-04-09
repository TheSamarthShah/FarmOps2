using FarmOps.Models.LoginModels;
using FarmOps.Repos;

namespace FarmOps.Services
{
    public class LoginService(LoginRepository loginRepository)
    {
        private readonly LoginRepository _loginRepository = loginRepository;

        public FLogin verifyLogin(string type, string email, string password)
        {
            FLogin user = _loginRepository.GetUserForLogin(type, email, password);
            return user;   
        }
    }
}
