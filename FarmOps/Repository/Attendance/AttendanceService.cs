using FarmOps.Common;
using FarmOps.Models.AttendanceModels;
using FarmOps.Repos;
using System.Data;

namespace FarmOps.Services
{
    public class AttendanceService(AttendanceRepository attendanceRepository)
    {
        private readonly AttendanceRepository _attendanceRepository = attendanceRepository;
        private readonly string _attendanceSignsDirectory = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "AppData", "AttendanceSigns");
        public async Task<bool> SaveTimeAttendanceAsync(AttendanceView.TimeBasedSave timeBasedAttendances)
        {
            // Save photo for InsertList and UpdateList
            var insertList = timeBasedAttendances.InsertList.Select(item =>
            {
                string attendanceSignPicPath = SaveAttendanceSignPic(item);
                return new FAttendanceTbl
                {
                    RosterId = item.RosterId,
                    AttendanceDate = item.AttendanceDate,
                    StartTime = item.StartTime,
                    EndTime = item.EndTime,
                    TotalHours = item.TotalHours,
                    BreakTime = item.BreakTime,
                    BlockId = item.BlockId,
                    Pay = item.Pay,
                    AttendanceType = "Time", // Indicating time-based attendance
                    JobId = null, // No mapping for JobId
                    PaidBreak = null, // Assuming no PaidBreak mapping
                    AttendanceSignPic = attendanceSignPicPath,
                    LineId = item.LineId,
                    JobPaid = item.JobPaid,
                    Remarks = item.Remarks,
                    AppliedBy = item.AppliedBy,
                    ApprovedStatus = item.ApprovedStatus ?? "0", // Default to "0" if null
                    ApprovedBy = item.ApprovedBy,
                    ApprovedDt = item.ApprovedDt
                };
            }).ToList();

            var updateList = timeBasedAttendances.UpdateList.Select(item =>
            {
                string attendanceSignPicPath = SaveAttendanceSignPic(item);
                return new FAttendanceTbl
                {
                    RosterId = item.RosterId,
                    AttendanceDate = item.AttendanceDate,
                    StartTime = item.StartTime,
                    EndTime = item.EndTime,
                    TotalHours = item.TotalHours,
                    BreakTime = item.BreakTime,
                    BlockId = item.BlockId,
                    Pay = item.Pay,
                    AttendanceType = "Time", // Indicating time-based attendance
                    JobId = null, // No mapping for JobId
                    PaidBreak = null, // Assuming no PaidBreak mapping
                    AttendanceSignPic = attendanceSignPicPath,
                    LineId = item.LineId,
                    JobPaid = item.JobPaid,
                    Remarks = item.Remarks,
                    AppliedBy = item.AppliedBy,
                    ApprovedStatus = item.ApprovedStatus ?? "0", // Default to "0" if null
                    ApprovedBy = item.ApprovedBy,
                    ApprovedDt = item.ApprovedDt
                };
            }).ToList();

            var deleteList = timeBasedAttendances.DeleteList.Select(item =>
            {
                string attendanceSignPicPath = SaveAttendanceSignPic(item); // Optionally save photo for delete if needed
                return new FAttendanceTbl
                {
                    RosterId = item.RosterId,
                    AttendanceDate = item.AttendanceDate,
                    StartTime = item.StartTime,
                    EndTime = item.EndTime,
                    TotalHours = item.TotalHours,
                    BreakTime = item.BreakTime,
                    BlockId = item.BlockId,
                    Pay = item.Pay,
                    AttendanceType = "Time", // Indicating time-based attendance
                    JobId = null, // No mapping for JobId
                    PaidBreak = null, // Assuming no PaidBreak mapping
                    AttendanceSignPic = attendanceSignPicPath, // Save the picture if needed for delete
                    LineId = item.LineId,
                    JobPaid = item.JobPaid,
                    Remarks = item.Remarks,
                    AppliedBy = item.AppliedBy,
                    ApprovedStatus = item.ApprovedStatus ?? "0", // Default to "0" if null
                    ApprovedBy = item.ApprovedBy,
                    ApprovedDt = item.ApprovedDt
                };
            }).ToList();

            // Pass all three lists to the repository (Insert, Update, and Delete)
            await _attendanceRepository.SaveAppliedAttendanceAsync(insertList, updateList, deleteList);
            return true;
        }

        public async Task<bool> SaveJobAttendanceAsync(AttendanceView.JobBasedSave jobBasedAttendances)
        {
            // Save photo for InsertList and UpdateList
            var insertList = jobBasedAttendances.InsertList.Select(item =>
            {
                string attendanceSignPicPath = SaveAttendanceSignPicForJob(item);
                return new FAttendanceTbl
                {
                    RosterId = item.RosterId,
                    AttendanceDate = item.AttendanceDate,
                    StartTime = item.StartTime,
                    EndTime = item.EndTime,
                    TotalHours = item.TotalHours,
                    BreakTime = item.BreakTime,
                    BlockId = item.BlockId,
                    Pay = item.Pay,
                    AttendanceType = "Job", // Indicating job-based attendance
                    JobId = item.JobId,
                    PaidBreak = null, // Assuming no PaidBreak mapping
                    AttendanceSignPic = attendanceSignPicPath,
                    LineId = item.LineId,
                    JobPaid = item.JobPaid,
                    Remarks = item.Remarks,
                    AppliedBy = item.AppliedBy,
                    ApprovedStatus = item.ApprovedStatus ?? "0", // Default to "0" if null
                    ApprovedBy = item.ApprovedBy,
                    ApprovedDt = item.ApprovedDt
                };
            }).ToList();

            var updateList = jobBasedAttendances.UpdateList.Select(item =>
            {
                string attendanceSignPicPath = SaveAttendanceSignPicForJob(item);
                return new FAttendanceTbl
                {
                    RosterId = item.RosterId,
                    AttendanceDate = item.AttendanceDate,
                    StartTime = item.StartTime,
                    EndTime = item.EndTime,
                    TotalHours = item.TotalHours,
                    BreakTime = item.BreakTime,
                    BlockId = item.BlockId,
                    Pay = item.Pay,
                    AttendanceType = "Job", // Indicating job-based attendance
                    JobId = item.JobId,
                    PaidBreak = null, // Assuming no PaidBreak mapping
                    AttendanceSignPic = attendanceSignPicPath,
                    LineId = item.LineId,
                    JobPaid = item.JobPaid,
                    Remarks = item.Remarks,
                    AppliedBy = item.AppliedBy,
                    ApprovedStatus = item.ApprovedStatus ?? "0", // Default to "0" if null
                    ApprovedBy = item.ApprovedBy,
                    ApprovedDt = item.ApprovedDt
                };
            }).ToList();

            var deleteList = jobBasedAttendances.DeleteList.Select(item =>
            {
                string attendanceSignPicPath = SaveAttendanceSignPicForJob(item); // Optionally save photo for delete if needed
                return new FAttendanceTbl
                {
                    RosterId = item.RosterId,
                    AttendanceDate = item.AttendanceDate,
                    StartTime = item.StartTime,
                    EndTime = item.EndTime,
                    TotalHours = item.TotalHours,
                    BreakTime = item.BreakTime,
                    BlockId = item.BlockId,
                    Pay = item.Pay,
                    AttendanceType = "Job", // Indicating job-based attendance
                    JobId = item.JobId, // Preserving JobId for delete
                    AttendanceSignPic = attendanceSignPicPath, // Save the picture if needed for delete
                    LineId = item.LineId,
                    JobPaid = item.JobPaid,
                    Remarks = item.Remarks,
                    AppliedBy = item.AppliedBy,
                    ApprovedStatus = item.ApprovedStatus ?? "0", // Default to "0" if null
                    ApprovedBy = item.ApprovedBy,
                    ApprovedDt = item.ApprovedDt
                };
            }).ToList();

            // Pass all three lists to the repository (Insert, Update, and Delete)
            await _attendanceRepository.SaveAppliedAttendanceAsync(insertList, updateList, deleteList);
            return true;
        }


        private string SaveAttendanceSignPic(AttendanceView.TimeBasedAttendance item)
        {
            if (string.IsNullOrEmpty(item.AttendanceSignPic))
            {
                return null; // No picture to save
            }

            try
            {
                // Save base64 string to file and return the file name
                byte[] imageBytes = Convert.FromBase64String(item.AttendanceSignPic);
                string fileName = $"{item.RosterId}_{item.AttendanceDate:yyyyMMdd}.png";
                string filePath = Path.Combine(_attendanceSignsDirectory, fileName);
                File.WriteAllBytes(filePath, imageBytes);

                return fileName;
            }
            catch
            {
                return null; // Return null in case of an error
            }
        }

        private string SaveAttendanceSignPicForJob(AttendanceView.JobBasedAttendance item)
        {
            if (string.IsNullOrEmpty(item.AttendanceSignPic))
            {
                return null; // No picture to save
            }

            try
            {
                // Save base64 string to file and return the file name
                byte[] imageBytes = Convert.FromBase64String(item.AttendanceSignPic);
                string fileName = $"{item.RosterId}_{item.AttendanceDate:yyyyMMdd}.png";
                string filePath = Path.Combine(_attendanceSignsDirectory, fileName);
                File.WriteAllBytes(filePath, imageBytes);

                return fileName;
            }
            catch
            {
                return null; // Return null in case of an error
            }
        }
        public List<string> GetRelatedWorkers(string UserType, string UserId)
        {
            var clmName = "supervisorId";
            if (UserType == "M")
            {
                clmName = "MonitorId";
            }
            DataTable dutyTbl = _attendanceRepository.GetAssignedWorkers(clmName, UserId);
            GlobalVariables.DutyTable = dutyTbl;

            HashSet<string> uniqueWorkerIds = new HashSet<string>();
            foreach (DataRow row in dutyTbl.Rows)
            {
                uniqueWorkerIds.Add(row.Field<string>("WorkerID").ToString());
            }
            return uniqueWorkerIds.ToList();
        }

        public List<ModelAttendanceViewRecord> GetAllAttendanceData(string UserType, string UserId)
        {
            var clmName = "supervisorId";
            if (UserType == "M")
            {
                clmName = "MonitorId";
            }
            DataTable attendanceDT = _attendanceRepository.GetAllAttendanceData(clmName, UserId);
            var records = new List<ModelAttendanceViewRecord>();

            foreach (DataRow row in attendanceDT.Rows)
            {
                var record = new ModelAttendanceViewRecord
                {
                    AttendanceId = row.Field<long>("AttendanceId"),
                    RosterId = row.Field<long>("RosterId"),
                    attendDate = (DateTime)(row.IsNull("attendDate") ? (DateTime?)null : row.Field<DateTime>("attendDate")),
                    SigninTime = row.IsNull("SigninTime") ? (TimeSpan?)null : row.Field<TimeSpan>("SigninTime"),
                    SignoutTime = row.IsNull("SignoutTime") ? (TimeSpan?)null : row.Field<TimeSpan>("SignoutTime"),
                    TotalWorkHours = row.IsNull("TotalWorkHours") ? (decimal?)null : row.Field<decimal>("TotalWorkHours"),
                    TotalBreakHours = row.IsNull("TotalBreakHours") ? (decimal?)null : row.Field<decimal>("TotalBreakHours"),
                    BreakIds = row.Field<string>("BreakIds"),
                    Pay = row.IsNull("Pay") ? (decimal?)null : row.Field<decimal>("Pay"),
                    JobCat = row.IsNull("job_cat") ? (int?)null : row.Field<int>("job_cat"),
                    OnPaidLeave = row.IsNull("on_paid_leave") ? (bool?)null : row.Field<bool>("on_paid_leave"),
                    LineId = row.IsNull("LineId") ? (int?)null : row.Field<int>("LineId"),
                    JobNotPaid = row.IsNull("JobNotPaid") ? (bool?)null : row.Field<bool>("JobNotPaid"),
                    ApprovedStatus = row.Field<string>("ApprovedStatus"),
                    ApprovedBy = row.Field<string>("ApprovedBy"),
                    AttendanceSheetPhoto = row.Field<string>("AttendanceSheetPhoto"),
                    RejectedRosterIds = row.Field<string>("RejectedRosterIds"),
                    ApprovedDt = row.IsNull("ApprovedDt") ? (DateTime?)null : row.Field<DateTime>("ApprovedDt"),
                    AppliedBy = row.Field<string>("AppliedBy"),
                    Remarks = row.Field<string>("Remarks")
                };

                records.Add(record);
            }
            return records;
        }

        public async Task<AttendanceView.AttendanceDataDto> GetAttendanceDataAsync(string userId)
        {
            return await _attendanceRepository.GetAttendanceDataAsync(userId);
        }
    }
}
