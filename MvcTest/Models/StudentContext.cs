using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace MvcTest.Models
{
    public class StudentContext : DbContext
    {
        public StudentContext()
            : base("name=")
        {

        }

        public DbSet<Student> Students { get; set; }
        public DbSet<StudentTag> Tags { get; set; }
    }
}