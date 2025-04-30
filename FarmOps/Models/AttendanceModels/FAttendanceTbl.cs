public class FAttendanceTbl
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
    public int? PaidBreak { get; set; }
    public string AttendanceSignPic { get; set; }
    public int? LineId { get; set; }
    public string JobPaid { get; set; }
    public string Remarks { get; set; }
    public string AppliedBy { get; set; }
    public string ApprovedStatus { get; set; }
    public string ApprovedBy { get; set; }
    public DateTime? ApprovedDt { get; set; }
}
