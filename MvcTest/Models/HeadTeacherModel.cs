using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mvc.Entity;

namespace MvcTest.Models
{
    public class HeadTeacherModel
    {
        public IEnumerable<Award> Awards { get; set; }
    }
}