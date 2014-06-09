using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations.Schema;

namespace Mvc.Entity.Member
{
    [Table("User")]
    public class User
    {
        public int UserID { get; set; }
        public string Name { get; set; }
        public int RoleId { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }

        public Role Role { get; set; }
    }
}
