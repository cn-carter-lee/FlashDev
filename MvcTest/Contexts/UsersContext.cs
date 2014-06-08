using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using Mvc.Entity.Member;

namespace MvcTest.Contexts
{
    public class UsersContext : DbContext
    {
        public UsersContext()
            : base("TeacherDB")
        {

        }

        public DbSet<User> Users { get; set; }

        // Helper methods. User can also directly access "Users" property
        public void AddUser(User user)
        {
            Users.Add(user);
            SaveChanges();
        }

        public User GetUser(string userName)
        {
            var user = Users.SingleOrDefault(u => u.UserName == userName);
            return user;
        }

        public User GetUser(string userName, string password)
        {
            var user = Users.SingleOrDefault(u => u.UserName == userName && u.Password == password);
            return user;
        }
    }
}