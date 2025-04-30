using FarmOps.Models.Table;
using FarmOps.Repository.Job;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace FarmOps.Controllers
{
    [Authorize]
    public class JobController : BaseController
    {
        private readonly JobService _jobService;

        public JobController(JobService jobService)
        {
            _jobService = jobService;
        }
        public async Task<IActionResult> Index()
        {
            try
            {
                // Returning an empty list for now (you can replace this with actual data later)
                var jobs = new tbl_FJobDetails(); // Empty list

                // Passing the empty list to the view
                return View(jobs);
            }
            catch (Exception ex)
            {
                // Handle exception (log it or show an error page)
                return View("Error", new { message = ex.Message });
            }
        }

        [HttpPost]
        public async Task<IActionResult> Index(tbl_FJobDetails job)
        {
            if (!ModelState.IsValid)
                return View(job);

            var jobId = await _jobService.CreateJobAsync(job);
            return RedirectToAction("Index");
        }
    }
}
