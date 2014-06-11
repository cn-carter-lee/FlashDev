using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Mvc.Entity
{
    [Table("Student")]
    public class Student
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int ClassId { get; set; }
        public string Name { get; set; }
        public bool Sex { get; set; }
        public int DisplayOrder { get; set; }
    }
}
