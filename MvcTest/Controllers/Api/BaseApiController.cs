using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Collections;
using MvcTest.Models;
using Mvc.Entity;
using Mvc.Data.Interface;
using Mvc.Data;
using Mvc.Entity.Member;

namespace MvcTest.Controllers.Api
{
    public class BaseApiController : ApiController
    {
        protected IStudentRepository StudentRepository;
        protected MemeberReposiatory MemeberReposiatory;

        private User _currentUser;
        protected User CurrentUser
        {
            get
            {
                if (this._currentUser == null) _currentUser = MemeberReposiatory.GetUser(User.Identity.Name);
                return _currentUser;
            }
        }

        protected override void Initialize(System.Web.Http.Controllers.HttpControllerContext controllerContext)
        {
            if (StudentRepository == null) StudentRepository = new StudentRepository();
            if (MemeberReposiatory == null) MemeberReposiatory = new MemeberReposiatory();
            base.Initialize(controllerContext);
        }
    }
}
