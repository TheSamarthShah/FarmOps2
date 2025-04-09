using FarmOps.Common;
using FarmOps.Models;
using FarmOps.Models.AttendanceModels;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;

namespace FarmOps.Repos;

public class AttendanceRepository
{
    private readonly DBContext _dbContext;
    private readonly string _connectionString;

    public AttendanceRepository(DBContext dbContext, IConfiguration configuration)
    {
        _dbContext = dbContext;
        _connectionString = configuration.GetConnectionString("DefaultConnection")!;
    }

    public long GetNextAttendanceId()
    {
        try
        {
            using var connection = new SqlConnection(_connectionString);
            connection.Open();

            var command = new SqlCommand("SELECT ISNULL(MAX(attendanceId), 0) FROM tbl_AppliedAttendance", connection);
            var result = command.ExecuteScalar();

            return (long)result + 1;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error while fetching next AttendanceId: {ex.Message}");
            throw new ApplicationException("Error while fetching next AttendanceId: " + ex.Message);
        }
    }

    public string SaveAppliedAttendance(List<FAttendanceTbl> data)
    {
        const string insertQuery = @"
INSERT INTO tbl_FAttendance (
    RosterId, AttendanceDate, StartTime, EndTime, TotalHours, BreakTime,
    BlockId, Pay, AttendanceType, JobId, PaidBreak, AttendanceSignPic,
    LineId, JobPaid, Remarks, AppliedBy, ApprovedStatus, ApprovedBy, ApprovedDt
) VALUES (
    @RosterId, @AttendanceDate, @StartTime, @EndTime, @TotalHours, @BreakTime,
    @BlockId, @Pay, @AttendanceType, @JobId, @PaidBreak, @AttendanceSignPic,
    @LineId, @JobPaid, @Remarks, @AppliedBy, @ApprovedStatus, @ApprovedBy, @ApprovedDt
);";

        try
        {
            using var connection = new SqlConnection(_connectionString);
            connection.Open();

            using var transaction = connection.BeginTransaction();

            foreach (var record in data)
            {
                using var command = new SqlCommand(insertQuery, connection, transaction);
                command.Parameters.AddWithValue("@RosterId", record.RosterId);
                command.Parameters.AddWithValue("@AttendanceDate", record.AttendanceDate);
                command.Parameters.AddWithValue("@StartTime", record.StartTime);
                command.Parameters.AddWithValue("@EndTime", record.EndTime);
                command.Parameters.AddWithValue("@TotalHours", record.TotalHours ?? (object)DBNull.Value);
                command.Parameters.AddWithValue("@BreakTime", record.BreakTime ?? (object)DBNull.Value);
                command.Parameters.AddWithValue("@BlockId", record.BlockId ?? (object)DBNull.Value);
                command.Parameters.AddWithValue("@Pay", record.Pay ?? (object)DBNull.Value);
                command.Parameters.AddWithValue("@AttendanceType", string.IsNullOrWhiteSpace(record.AttendanceType) ? DBNull.Value : record.AttendanceType);
                command.Parameters.AddWithValue("@JobId", record.JobId ?? (object)DBNull.Value);
                command.Parameters.AddWithValue("@PaidBreak", record.PaidBreak ?? (object)DBNull.Value);
                command.Parameters.AddWithValue("@AttendanceSignPic", string.IsNullOrWhiteSpace(record.AttendanceSignPic) ? DBNull.Value : record.AttendanceSignPic);
                command.Parameters.AddWithValue("@LineId", record.LineId ?? (object)DBNull.Value);
                command.Parameters.AddWithValue("@JobPaid", record.JobPaid);
                command.Parameters.AddWithValue("@Remarks", string.IsNullOrWhiteSpace(record.Remarks) ? DBNull.Value : record.Remarks);
                command.Parameters.AddWithValue("@AppliedBy", string.IsNullOrWhiteSpace(record.AppliedBy) ? DBNull.Value : record.AppliedBy);
                command.Parameters.AddWithValue("@ApprovedStatus", record.ApprovedStatus);
                command.Parameters.AddWithValue("@ApprovedBy", string.IsNullOrWhiteSpace(record.ApprovedBy) ? DBNull.Value : record.ApprovedBy);
                command.Parameters.AddWithValue("@ApprovedDt", record.ApprovedDt ?? (object)DBNull.Value);

                command.ExecuteNonQuery();
            }

            transaction.Commit();
            return "Attendance data saved successfully.";
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error during insert: {ex.Message}");
            throw new ApplicationException($"An error occurred while inserting attendance data: {ex.Message}");
        }
    }

    public string SaveAttendanceDetails(AttendanceDetailTblModel data)
    {
        // Placeholder for saving attendance detail logic
        return "success";
    }

    public DataTable GetAssignedWorkers(string clmName, string userId)
    {
        try
        {
            using var connection = new SqlConnection(_connectionString);
            connection.Open();

            var query = DbConstants.selectTblDuty.Replace("[IDCOLUMNNAME]", clmName);

            using var command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@p0", userId);

            var dataTable = new DataTable();
            using var adapter = new SqlDataAdapter(command);
            adapter.Fill(dataTable);

            return dataTable;
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
            throw new ApplicationException("Error fetching assigned workers: " + ex.Message);
        }
    }

    public DataTable GetAllAttendanceData(string clmName, string userId)
    {
        try
        {
            using var connection = new SqlConnection(_connectionString);
            connection.Open();

            var query = DbConstants.selectAllAttendanceData.Replace("[IDCOLUMNNAME]", clmName);

            using var command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@p0", userId);

            var dataTable = new DataTable();
            using var adapter = new SqlDataAdapter(command);
            adapter.Fill(dataTable);

            return dataTable;
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
            throw new ApplicationException("Error fetching attendance data: " + ex.Message);
        }
    }
}
