using FarmOps.Models.Application;
using FarmOps.Models.LoginModels;
using FarmOps.Repos;
using Microsoft.Data.SqlClient;

namespace FarmOps.Services
{
    public class LoginService(LoginRepository loginRepository, IConfiguration configuration)
    {
        private readonly LoginRepository _loginRepository = loginRepository;
        private readonly IConfiguration _config = configuration;

        public FLogin verifyLogin(string type, string email, string password)
        {
            FLogin user = _loginRepository.GetUserForLogin(type, email, password);
            return user;   
        }
        public async Task<(bool Success, string? Error)> SignUp(Signup model)
        {
            try
            {
                // Assuming you have the userId from the session or elsewhere
                string userId = await _loginRepository.GenerateUserIdAsync(model.Type!);

                // Check if email exists
                if (await _loginRepository.IsEmailExistsAsync(model.Email!))
                    return (false, "Email already exists");

                // Save photos and update model with file names
                model = await SavePhotosAndReturnFileNames(model, userId);

                // Insert the user details into the database
                using var connection = new SqlConnection(_config.GetConnectionString("DefaultConnection"));
                await connection.OpenAsync();
                using var transaction = connection.BeginTransaction();

                try
                {
                    // Insert user details (with file names now)
                    await _loginRepository.InsertUserDetailsAsync(connection, transaction, userId, model);
                    await _loginRepository.InsertLoginAsync(connection, transaction, userId, model);
                    transaction.Commit();

                    return (true, null); // Successful registration
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    return (false, ex.Message); // Error during insert
                }
            }
            catch (Exception ex)
            {
                return (false, ex.Message); // General error
            }
        }

        public async Task<Signup> SavePhotosAndReturnFileNames(Signup model, string userId)
        {
            string basePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "AppData", "UserData", userId);

            // Create the directory if it doesn't exist
            if (!Directory.Exists(basePath))
            {
                Directory.CreateDirectory(basePath);
            }

            // Save Picture
            if (model.Picture != null)
            {
                string pictureFileName = $"{Guid.NewGuid()}.jpg"; // or any other file extension you require
                string picturePath = Path.Combine(basePath, pictureFileName);
                using (var stream = new FileStream(picturePath, FileMode.Create))
                {
                    await model.Picture.CopyToAsync(stream);
                }
                model.Picture = pictureFileName; // Store the file name instead of the file itself
            }

            // Save Document
            if (model.Document != null)
            {
                string documentFileName = $"{Guid.NewGuid()}.pdf"; // or any other file extension
                string documentPath = Path.Combine(basePath, documentFileName);
                using (var stream = new FileStream(documentPath, FileMode.Create))
                {
                    await model.Document.CopyToAsync(stream);
                }
                model.Document = documentFileName; // Store the file name
            }

            // Save IR330 Document
            if (model.Ir330Document != null)
            {
                string ir330DocumentFileName = $"{Guid.NewGuid()}.pdf"; // adjust file type accordingly
                string ir330DocumentPath = Path.Combine(basePath, ir330DocumentFileName);
                using (var stream = new FileStream(ir330DocumentPath, FileMode.Create))
                {
                    await model.Ir330Document.CopyToAsync(stream);
                }
                model.Ir330Document = ir330DocumentFileName; // Store the file name
            }

            // Save Signature Picture
            if (model.SignPic != null)
            {
                string signPicFileName = $"{Guid.NewGuid()}.jpg"; // adjust file type accordingly
                string signPicPath = Path.Combine(basePath, signPicFileName);
                using (var stream = new FileStream(signPicPath, FileMode.Create))
                {
                    await model.SignPic.CopyToAsync(stream);
                }
                model.SignPic = signPicFileName; // Store the file name
            }

            return model; // return the model with updated file names
        }

    }
}
