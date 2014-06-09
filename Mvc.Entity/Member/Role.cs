using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Mvc.Entity.Member
{
    [Table("Role")]
    public class Role
    {
        [Key]
        public int RoleId { get; set; }

        public string Name { get; set; }
    }
}
