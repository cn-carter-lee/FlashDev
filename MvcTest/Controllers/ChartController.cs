using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcTest.Models;
using Mvc.Entity;

namespace MvcTest.Controllers
{
    public class ChartController : BaseController
    {
        public ActionResult Index()
        {
            ViewBag.Message = "Modify this template to jump-start your ASP.NET MVC application.";

            return View();
        }

        public ActionResult Teacher()
        {
            TeacherChartModel teacherChartModel = new TeacherChartModel();
            ViewBag.Message = "Your app description page.";

            return View(teacherChartModel);
        }

        public ActionResult Student()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }


        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}
