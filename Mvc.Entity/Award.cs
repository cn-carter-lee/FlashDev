using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations.Schema;

namespace Mvc.Entity
{
    [Table("Award")]
    public class Award
    {
        public int Id { set; get; }
        public byte TypeId { set; get; }
        public int StudentId { set; get; }
        public int TeacherId { set; get; }
        public string Content { set; get; }
        public DateTime EventTime { set; get; }
    }
}
