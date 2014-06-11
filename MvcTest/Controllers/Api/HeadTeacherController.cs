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

namespace MvcTest.Controllers.Api
{
    public class HeadTeacherController : BaseApiController
    {
        protected int ClassId { get { return 1000; } }

        public IEnumerable<Award> GetTags()
        {
            return this.StudentRepository.GetAwardList(this.ClassId);
        }

        public Award Post(Award value)
        {
            value.EventTime = DateTime.Now;
            value.ClassId = this.ClassId;
            value.TeacherId = this.CurrentUser.UserID;
            StudentRepository.Add(value);
            return value;
        }

        public void Delete(int id)
        {

        }
    }
}
