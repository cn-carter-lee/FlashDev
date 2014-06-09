using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations.Schema;

namespace Mvc.Entity
{
    [Table("StudentTag")]
    public class StudentTag
    {
        public int Id { set; get; }
        public int StudentId { set; get; }
        public int TeacherId { set; get; }
        public string Name { set; get; }
    }
}
