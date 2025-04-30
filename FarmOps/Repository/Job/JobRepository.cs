using Dapper;
using FarmOps.Models;
using FarmOps.Models.Table;
using Microsoft.Data.SqlClient;

namespace FarmOps.Repository.Job
{
    public class JobRepository(DBContext dbContext, IConfiguration configuration)
    {
        private readonly DBContext _dbContext = dbContext;
        private readonly string _connectionString= configuration.GetConnectionString("DefaultConnection");
        public async Task<int> CreateJobAsync(tbl_FJobDetails job)
        {
            if (job == null) throw new ArgumentNullException(nameof(job));

            try
            {
                using var connection = new SqlConnection(_connectionString);
                await connection.OpenAsync();

                // Step 1: Generate the next jobId
                const string getMaxIdQuery = "SELECT ISNULL(MAX(jobId), 0) + 1 FROM tbl_FJobDetails";
                int nextJobId = await connection.QuerySingleAsync<int>(getMaxIdQuery);

                // Step 2: Generate a unique jobName
                string jobName = $"JOB{DateTime.Now:yyyy}{nextJobId:D4}";

                // Step 3: Insert the job
                const string insertQuery = @"
            INSERT INTO [dbo].[tbl_FJobDetails]
                ([jobId], [jobCat], [growerId], [jobTitle], [jobDescription], 
                 [jobPay], [jobDuration], [numWorkers], [jobName])
            VALUES
                (@JobId, @JobCat, @GrowerId, @JobTitle, @JobDescription, 
                 @JobPay, @JobDuration, @NumWorkers, @JobName);";

                var parameters = new
                {
                    JobId = nextJobId,
                    JobCat = job.JobCat,
                    GrowerId = job.GrowerId,
                    JobTitle = job.JobTitle,
                    JobDescription = job.JobDescription,
                    JobPay = job.JobPay,
                    JobDuration = job.JobDuration,
                    NumWorkers = job.NumWorkers,
                    JobName = jobName
                };

                await connection.ExecuteAsync(insertQuery, parameters);

                return nextJobId;
            }
            catch (SqlException sqlEx)
            {
                throw new Exception("Database error occurred while creating the job.", sqlEx);
            }
            catch (Exception ex)
            {
                throw new Exception("Unexpected error occurred while creating the job.", ex);
            }
        }


        public async Task<tbl_FJobDetails> GetJobByIdAsync(int jobId)
        {
            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    string query = "SELECT * FROM [dbo].[tbl_FJobDetails] WHERE [jobId] = @JobId";
                    var job = await connection.QuerySingleOrDefaultAsync<tbl_FJobDetails>(query, new { JobId = jobId });
                    return job;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error while fetching job: " + ex.Message);
            }
        }

    }
}
