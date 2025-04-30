namespace FarmOps.Models.Table
{
    public class tbl_FJobDetails
    {
        public string JobId { get; set; }  // Primary key
        public string JobName { get; set; }  // Primary key
        public int JobCat { get; set; }
        public int GrowerId { get; set; }
        public string JobTitle { get; set; }
        public string JobDescription { get; set; }
        public DateTime? JobPostedDate { get; set; }  // Nullable
        public string JobStatus { get; set; }
        public decimal JobPay { get; set; }
        public int JobDuration { get; set; }
        public int NumWorkers { get; set; }
    }
}
