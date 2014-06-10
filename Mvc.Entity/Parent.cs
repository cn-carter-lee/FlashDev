using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations.Schema;

namespace Mvc.Entity
{
    [Table("Parent")]
    public class Parent
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string StudentUniversalNo { get; set; }
        public string StudentSchoolNo { get; set; }
        public string StudentName { get; set; }
        public string Phone { get; set; }
        public int StudentId { get; set; }
    }
}
