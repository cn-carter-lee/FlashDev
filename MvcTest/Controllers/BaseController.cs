using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mvc.Data.Interface;
using Mvc.Data;
using Mvc.Entity.Member;

namespace MvcTest.Controllers
{
    public class BaseController : Controller
    {
        protected IStudentRepository StudentRepository;
        protected MemeberReposiatory MemeberReposiatory;

        protected User CurrentUser
        {
            get
            {
                if (this.CurrentUser == null) return MemeberReposiatory.GetUser(User.Identity.Name);
                return CurrentUser;
            }
        }

        protected override void Initialize(System.Web.Routing.RequestContext requestContext)
        {
            if (StudentRepository == null) StudentRepository = new StudentRepository();
            if (MemeberReposiatory == null) MemeberReposiatory = new MemeberReposiatory();
            base.Initialize(requestContext);
        }
    }
}
