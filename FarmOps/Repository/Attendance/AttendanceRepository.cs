using Dapper;
using FarmOps.Common;
using FarmOps.Models;
using FarmOps.Models.AttendanceModels;
using Microsoft.Data.SqlClient;
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

    public async Task SaveAppliedAttendanceAsync(
        List<FAttendanceTbl> insertList,
        List<FAttendanceTbl> updateList,
        List<FAttendanceTbl> deleteList)
    {
        using (IDbConnection connection = new SqlConnection(_connectionString))
        {
            connection.Open();
            using (var transaction = connection.BeginTransaction())
            {
                try
                {
                    // 1. INSERT
                    if (insertList?.Count > 0)
                    {
                        string insertQuery = @"
                        INSERT INTO tbl_FAttendance
                        (rosterId, attendanceDate, startTime, endTime, totalHours, breakTime, blockId, pay, 
                         attendanceType, jobId, paidBreak, attendanceSignPic, lineId, jobPaid, remarks, 
                         appliedBy, approvedStatus, approvedBy, approvedDt)
                        VALUES
                        (@RosterId, @AttendanceDate, @StartTime, @EndTime, @TotalHours, @BreakTime, @BlockId, @Pay,
                         @AttendanceType, @JobId, @PaidBreak, @AttendanceSignPic, @LineId, @JobPaid, @Remarks,
                         @AppliedBy, @ApprovedStatus, @ApprovedBy, @ApprovedDt)";
                        await connection.ExecuteAsync(insertQuery, insertList, transaction);
                    }

                    // 2. UPDATE
                    if (updateList?.Count > 0)
                    {
                        string updateQuery = @"
                        UPDATE tbl_FAttendance
                        SET totalHours = @TotalHours,
                            breakTime = @BreakTime,
                            blockId = @BlockId,
                            pay = @Pay,
                            attendanceType = @AttendanceType,
                            jobId = @JobId,
                            paidBreak = @PaidBreak,
                            attendanceSignPic = @AttendanceSignPic,
                            lineId = @LineId,
                            jobPaid = @JobPaid,
                            remarks = @Remarks,
                            appliedBy = @AppliedBy,
                            approvedStatus = @ApprovedStatus,
                            approvedBy = @ApprovedBy,
                            approvedDt = @ApprovedDt
                        WHERE rosterId = @RosterId 
                          AND attendanceDate = @AttendanceDate 
                          AND startTime = @StartTime 
                          AND endTime = @EndTime";
                        await connection.ExecuteAsync(updateQuery, updateList, transaction);
                    }

                    // 3. DELETE
                    if (deleteList?.Count > 0)
                    {
                        string deleteQuery = @"
                        DELETE FROM tbl_FAttendance
                        WHERE rosterId = @RosterId 
                          AND attendanceDate = @AttendanceDate 
                          AND startTime = @StartTime 
                          AND endTime = @EndTime";
                        await connection.ExecuteAsync(deleteQuery, deleteList, transaction);
                    }

                    transaction.Commit();
                }
                catch
                {
                    transaction.Rollback();
                    throw;
                }
            }
        }
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

    public async Task<AttendanceView.AttendanceDataDto> GetAttendanceDataAsync(string userId)
    {
        try
        {
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();

            string timeSql = @"
SELECT 
    A.rosterId, 
    A.attendanceDate, 
    A.startTime AS StartTime, -- Return as raw TIME type
    A.endTime AS EndTime,     -- Return as raw TIME type
    A.totalHours, 
    A.breakTime, 
    A.pay,
    A.attendanceSignPic, 
    A.blockId, 
    A.lineId, 
    CASE WHEN A.jobPaid = 'Y' THEN 1 ELSE 0 END AS JobPaid,
    A.remarks, 
    A.appliedBy, 
    A.approvedStatus, 
    A.approvedBy, 
    A.approvedDt
FROM tbl_FAttendance A
INNER JOIN tbl_FRoster R ON A.rosterId = R.RosterID
WHERE A.attendanceType = 'Time' 
  AND (
        R.WorkerID = @UserId OR
        R.SupervisorId = @UserId OR
        R.GrowerID = @UserId OR
        R.MonitorID = @UserId
      );
";


            string jobSql = @"
SELECT 
    A.rosterId,
    A.attendanceDate,
    A.startTime,
    A.endTime,
    A.totalHours,
    A.breakTime,
    A.blockId,
    A.pay,
    A.attendanceType,
    A.jobId,
    J.jobName,
    A.attendanceSignPic,
    A.lineId,
    CASE WHEN A.jobPaid = 'Y' THEN 1 ELSE 0 END AS JobPaid,
    A.remarks,
    A.appliedBy,
    A.approvedStatus,
    A.approvedBy,
    A.approvedDt
FROM tbl_FAttendance A
INNER JOIN tbl_FRoster R ON A.rosterId = R.RosterID
LEFT JOIN tbl_FJobDetails J ON A.jobId = J.jobId
WHERE A.attendanceType = 'Job'
  AND (
        R.WorkerID = @UserId OR
        R.SupervisorId = @UserId OR
        R.GrowerID = @UserId OR
        R.MonitorID = @UserId
      );
";

            var timeBased = await connection.QueryAsync<AttendanceView.TimeBasedAttendance>(timeSql, new { UserId = userId });
            var jobBased = await connection.QueryAsync<AttendanceView.JobBasedAttendance>(jobSql, new { UserId = userId });

            return new AttendanceView.AttendanceDataDto
            {
                TimeBased = timeBased.ToList(),
                JobBased = jobBased.ToList()
            };
        }
        catch (SqlException ex)
        {
            throw new ApplicationException("Database query failed", ex);
        }
        catch (Exception ex)
        {
            throw new ApplicationException("Unexpected error in repository", ex);
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
