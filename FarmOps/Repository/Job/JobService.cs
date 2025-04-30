using FarmOps.Models.Table;

namespace FarmOps.Repository.Job
{
    public class JobService
    {
        private readonly JobRepository _jobRepository;
        public JobService(JobRepository jobRepository)
        {
            _jobRepository = jobRepository;
        }

        public async Task<int> CreateJobAsync(tbl_FJobDetails job)
        {
            return await _jobRepository.CreateJobAsync(job);
        }
    }
}
