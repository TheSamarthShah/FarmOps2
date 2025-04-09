using Dapper;
using FarmOps.Models;
using FarmOps.Models.LoginModels;
using Microsoft.Data.SqlClient;

namespace FarmOps.Repos
{
    public class LoginRepository(DBContext dBContext, IConfiguration configuration)
    {
        private readonly DBContext _dbContext = dBContext;
        private readonly string _connectionString = configuration.GetConnectionString("DefaultConnection") ?? throw new ArgumentNullException(nameof(configuration));

        public FLogin GetUserForLogin(string type, string email, string password)
        {
            try
            {
                using var connection = new SqlConnection(_connectionString);
                connection.Open();

                string sql = @"
                SELECT 
                    userId AS UserId,
                    emailAddress AS EmailAddress,
                    userPassword AS UserPassword,
                    userType AS UserType,
                    isPasswordChanged AS IsPasswordChanged,
                    visaVerification AS VisaVerification,
                    lastIpAddress AS LastIpAddress,
                    lastLoginTime AS LastLoginTime,
                    isSuperuser AS IsSuperuser,
                    promoCode AS PromoCode,
                    registrationDate AS RegistrationDate,
                    industryId AS IndustryId,
                    package AS Package
                FROM tbl_Flogin 
                WHERE userType = @UserType 
                AND emailAddress = @Email 
                AND userPassword = @Password";

                FLogin? res = connection.QueryFirstOrDefault<FLogin>(sql, new
                {
                    UserType = type,
                    Email = email,
                    Password = password
                });

                return res ?? new FLogin();
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Database error: " + ex.Message);
            }
        }
    }
}
