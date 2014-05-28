using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Collections;
using MvcTest.Models;

namespace MvcTest.Controllers
{
    public class StudentApiController : ApiController
    {
        static readonly IStudentTagRepository repository = new StudentTagRepository();
        public IEnumerable<StudentTag> GetTags()
        {
            StudentTag[] tags = new StudentTag[]
            {
               new StudentTag{TagId=1, TagName="good"},
               new StudentTag{TagId=1, TagName="kind"}
            };
            return tags;
        }

        public void AddTag(string name)
        {

        }
    }
}
