namespace FarmOps.Models.AttendanceModels
{
    public class AttendanceView
    {
        public class TimeBasedAttendance
        {
            public string RosterId { get; set; }
            public DateTime AttendanceDate { get; set; }
            public TimeSpan StartTime { get; set; }
            public TimeSpan EndTime { get; set; }
            public decimal? TotalHours { get; set; }
            public decimal? BreakTime { get; set; }
            public decimal? Pay { get; set; }
            public string AttendanceSignPic { get; set; }
            public int? BlockId { get; set; }
            public int? LineId { get; set; }
            public string JobPaid { get; set; }
            public string Remarks { get; set; }
            public string AppliedBy { get; set; }
            public string ApprovedStatus { get; set; }
            public string ApprovedBy { get; set; }
            public DateTime? ApprovedDt { get; set; }
        }

        public class JobBasedAttendance
        {
            public string RosterId { get; set; }
            public DateTime AttendanceDate { get; set; }
            public TimeSpan StartTime { get; set; }
            public TimeSpan EndTime { get; set; }
            public decimal? TotalHours { get; set; }
            public decimal? BreakTime { get; set; }
            public int? BlockId { get; set; }
            public decimal? Pay { get; set; }
            public string AttendanceType { get; set; }
            public int? JobId { get; set; }
            public string JobName { get; set; }
            public string AttendanceSignPic { get; set; }
            public int? LineId { get; set; }
            public string JobPaid { get; set; }
            public string Remarks { get; set; }
            public string AppliedBy { get; set; }
            public string ApprovedStatus { get; set; }
            public string ApprovedBy { get; set; }
            public DateTime? ApprovedDt { get; set; }
        }


        public class AttendanceDataDto
        {
            public List<TimeBasedAttendance> TimeBased { get; set; }
            public List<JobBasedAttendance> JobBased { get; set; }
        }

        public class TimeBasedSave
        {
            public List<TimeBasedAttendance> InsertList { get; set; }
            public List<TimeBasedAttendance> UpdateList { get; set; }
            public List<TimeBasedAttendance> DeleteList { get; set; }
        }

        public class JobBasedSave
        {
            public List<JobBasedAttendance> InsertList { get; set; }
            public List<JobBasedAttendance> UpdateList { get; set; }
            public List<JobBasedAttendance> DeleteList { get; set; }
        }
    }
}
