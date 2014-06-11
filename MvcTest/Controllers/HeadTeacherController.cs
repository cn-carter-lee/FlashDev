using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcTest.Models;

namespace MvcTest.Controllers
{
    //[Authorize(Roles = "headteacher")]
    public class HeadTeacherController : BaseController
    {
        public ActionResult Index()
        {
            HeadTeacherModel model = new HeadTeacherModel();
            model.Awards = StudentRepository.GetAwardList(1000);
            return View(model);
        }

        public ActionResult Student()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult Test()
        {
            ViewBag.Message = "Your app description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}
