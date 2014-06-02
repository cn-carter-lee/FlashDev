using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MvcTest.Models
{
    [Table("StudentTag")]
    public class StudentTag
    {
        //[Key]
        public int Id { set; get; }
        public int StudentId { set; get; }
        public int TeacherId { set; get; }
        public string Name { set; get; }
    }
}