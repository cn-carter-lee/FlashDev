using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations.Schema;

namespace Mvc.Entity
{
    [Table("Tag")]
    public class Tag
    {
        public int Id { set; get; }
        public int StudentId { set; get; }
        public int TeacherId { set; get; }
        public string Name { set; get; }
    }
}
