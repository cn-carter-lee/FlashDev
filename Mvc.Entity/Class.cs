using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations.Schema;

namespace Mvc.Entity
{
    [Table("Class")]
    public class Class
    {
        public int Id { get; set; }
        public int SchoolId { get; set; }
        public int HeadTeacherId { get; set; }
        public string Name { get; set; }

        public int SchollId { get; set; }
        public virtual School School { get; set; }
    }
}
