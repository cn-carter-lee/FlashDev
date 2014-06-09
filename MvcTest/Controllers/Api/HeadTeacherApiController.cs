using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Collections;
using MvcTest.Models;
using Mvc.Entity;

namespace MvcTest.Controllers
{
    public class HeadTeacherApiController : ApiController
    {
        static readonly IStudentTagRepository repository = new StudentTagRepository();
        public IEnumerable<Award> GetTags()
        {
            Award[] awards = new Award[]
            {
               new Award{Id=1, Content="!!!!!!"},
               new Award{Id=1, Content="!!!!!!!!!!!"}
            };
            return awards;
        }

        public Award Post(Award value)
        {
            value.EventTime = DateTime.Now;
            repository.Add(value);
            return value;
        }

        public void Delete(int id)
        {
            repository.Remove(id);
        }
    }
}
