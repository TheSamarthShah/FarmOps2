using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using FarmOps.Models.AttendanceModels;
using FarmOps.Services;
using FarmOps.Common;
using System.Data;
using Newtonsoft.Json;
using System.Collections.Generic;

namespace FarmOps.Controllers
{
    [Authorize]
    public class AttendanceController : BaseController
    {
        private readonly AttendanceService _attendanceService;

        public AttendanceController(AttendanceService attendanceService)
        {
            _attendanceService = attendanceService;
        }

        // Redirect to TimeBased attendance by default
        public IActionResult Index()
        {
            return RedirectToAction("TimeBased");
        }

        // Time Based Attendance Page
        public IActionResult TimeBased()
        {
            List<ModelAttendanceViewRecord> allAttendanceData = new List<ModelAttendanceViewRecord>();
            try
            {
                var userType = GetUserType();
                var userId = GetUserId();

                //allAttendanceData = _attendanceService.GetTimeBasedAttendance(userType, userId);
            }
            catch (Exception ex)
            {
                ViewBag.Message = "Unable to load data! " + ex.Message;
            }

            return View("TimeBased", allAttendanceData);
        }

        // Job Based Attendance Page
        public IActionResult JobBased()
        {
            List<ModelAttendanceViewRecord> allAttendanceData = new List<ModelAttendanceViewRecord>();
            try
            {
                var userType = GetUserType();
                var userId = GetUserId();

                // Optional: Load job-based attendance data here
                // allAttendanceData = _attendanceService.GetJobBasedAttendance(userType, userId);
            }
            catch (Exception ex)
            {
                ViewBag.Message = "Unable to load data! " + ex.Message;
            }

            return View("JobBased", allAttendanceData);
        }

        [HttpPost]
        public async Task<ActionResult> SaveTimeAttendance([FromBody] AttendanceView.TimeBasedSave timeBasedAttendance)
        {
            if (timeBasedAttendance == null)
                return BadRequest(new { Success = false, Message = "Request body is null." });

            var result = await _attendanceService.SaveTimeAttendanceAsync(timeBasedAttendance);
            if (result)
                return Ok(new { Success = true });
            return BadRequest(new { Success = false, Message = "Failed to save time-based attendance." });
        }

        [HttpPost]
        public async Task<ActionResult> SaveJobAttendance([FromBody] AttendanceView.JobBasedSave jobBasedAttendance)
        {
            if (jobBasedAttendance == null)
                return BadRequest(new { Success = false, Message = "Request body is null." });

            var result = await _attendanceService.SaveJobAttendanceAsync(jobBasedAttendance);
            if (result)
                return Ok(new { Success = true });
            return BadRequest(new { Success = false, Message = "Failed to save job-based attendance." });
        }


        // Get Duty Table JSON
        public string GetDutyDataJson()
        {
            if (GlobalVariables.DutyTable != null)
            {
                return JsonConvert.SerializeObject(GlobalVariables.DutyTable);
            }
            return "";
        }

        public async Task<IActionResult> GetUserAttendance()
        {
            try
            {
                var userId = HttpContext.Session.GetString("FarmOpsUserId");
                if (string.IsNullOrEmpty(userId))
                    return Unauthorized("User not logged in.");

                var data = await _attendanceService.GetAttendanceDataAsync(userId);
                return Ok(data);
            }
            catch (Exception ex)
            {
                // Log the exception here (e.g., using ILogger)
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }
    }
}
