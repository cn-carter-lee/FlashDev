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
               new StudentTag{Id=1, Name="好动"},
               new StudentTag{Id=1, Name="善良"}
            };
            return tags;
        }

        public StudentTag Post(StudentTag value)
        {
            repository.Add(value);
            return value;
        }

        public void Delete(int id)
        {
            repository.Remove(id);
        }
    }
}
