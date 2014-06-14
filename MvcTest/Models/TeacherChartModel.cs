using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mvc.Entity;

namespace MvcTest.Models
{
    public class TeacherChartModel
    {
        public Exam Exam { get; set; }
        public TeacherChartModel()
        {
            this.Exam = new Exam();
        }
    }
}
