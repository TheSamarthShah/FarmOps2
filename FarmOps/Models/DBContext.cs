﻿using Microsoft.EntityFrameworkCore;

namespace FarmOps.Models
{
    public class DBContext : DbContext
    {
        public DBContext(DbContextOptions<DBContext> options): base(options) { 
            
        }
    }
}
