﻿namespace FarmOps.Models.Application
{
    public class Signup
    {
        public string? Email { get; set; }
        public string? Password { get; set; }
        public string? Type { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? MiddleName { get; set; }
        public dynamic? Picture { get; set; }
        public DateTime? Dob { get; set; }
        public string? PassportNumber { get; set; }
        public string? Phone { get; set; }
        public int? PayRate { get; set; }
        public string? Ird { get; set; }
        public bool? ForkliftCert { get; set; }
        public string? Ir330 { get; set; }
        public string? Licence { get; set; }
        public bool? WorkAuth { get; set; }
        public string? WorkType { get; set; }
        public int? WorkEvId { get; set; }
        public dynamic? Document { get; set; }
        public dynamic? Ir330Document { get; set; }
        public string? AccNum { get; set; }
        public string? PayrollId { get; set; }
        public string? PreEmployment { get; set; }
        public dynamic? SignPic { get; set; }
    }
}
