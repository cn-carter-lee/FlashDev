using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;
using Mvc.Entity.Member;
using Mvc.Entity;

namespace Mvc.Data
{
    public class LocalContext : DbContext
    {
        public LocalContext()
            : base("TeacherDB")
        {

        }

        public DbSet<Student> Students { get; set; }
        public DbSet<Tag> Tags { get; set; }
        public DbSet<Award> Awards { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Role> Roles { get; set; }
      

        public int Save()
        {
            return this.SaveChanges();
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }
    }
}
