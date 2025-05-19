using Dapper;
using FarmOps.Models;
using FarmOps.Models.Application;
using FarmOps.Models.LoginModels;
using Microsoft.Data.SqlClient;
using System.Data;

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

        public async Task<string> GenerateUserIdAsync(string type)
        {
            string columnName = type switch
            {
                "W" => "WorkerId",
                "S" => "WorkerId",
                "C" => "GrowerId",
                "M" => "MonitorId",
                _ => throw new Exception("Invalid type")
            };

            using var conn = new SqlConnection(_connectionString);
            var p = new DynamicParameters();
            p.Add("@ColumnName", columnName);
            p.Add("@NextValue", dbType: DbType.String, direction: ParameterDirection.Output, size: 50);

            await conn.ExecuteAsync("dbo.GetNextNo", p, commandType: CommandType.StoredProcedure);
            return p.Get<string>("@NextValue");
        }

        public async Task<bool> IsEmailExistsAsync(string email)
        {
            using var conn = new SqlConnection(_connectionString);
            var query = "SELECT COUNT(*) FROM tbl_FLogin WHERE emailAddress = @Email";
            var count = await conn.ExecuteScalarAsync<int>(query, new { Email = email });
            return count > 0;
        }

        public async Task InsertUserDetailsAsync(SqlConnection conn, SqlTransaction trx, string userId, Signup model)
        {
            string sql = @"
INSERT INTO tbl_FUserDetails (
    UserId, FirstName, LastName, MiddleName, Picture, Dob, PassportNumber, Phone, PayRate,
    Ird, ForkliftCert, Ir330, Licence, WorkAuth, WorkType, WorkEvId, Document, Ir330Document,
    AccNum, PayrollId, PreEmployment, SignPic
)
VALUES (
    @UserId, @FirstName, @LastName, @MiddleName, @Picture, @Dob, @PassportNumber, @Phone, @PayRate,
    @Ird, @ForkliftCert, @Ir330, @Licence, @WorkAuth, @WorkType, @WorkEvId, @Document, @Ir330Document,
    @AccNum, @PayrollId, @PreEmployment, @SignPic
)";
            await conn.ExecuteAsync(sql, new
            {
                UserId = userId,
                model.FirstName,
                model.LastName,
                model.MiddleName,
                model.Picture,
                model.Dob,
                model.PassportNumber,
                model.Phone,
                model.PayRate,
                model.Ird,
                model.ForkliftCert,
                model.Ir330,
                model.Licence,
                model.WorkAuth,
                model.WorkType,
                model.WorkEvId,
                model.Document,
                model.Ir330Document,
                model.AccNum,
                model.PayrollId,
                model.PreEmployment,
                model.SignPic
            }, trx);
        }

        public async Task InsertLoginAsync(SqlConnection conn, SqlTransaction trx, string userId, Signup model)
        {
            string sql = @"
INSERT INTO tbl_FLogin (userId, emailAddress, userPassword, userType)
VALUES (@UserId, @Email, @Password, @Type)";
            await conn.ExecuteAsync(sql, new
            {
                UserId = userId,
                Email = model.Email,
                Password = model.Password,
                Type = model.Type
            }, trx);
        }
    }
}
