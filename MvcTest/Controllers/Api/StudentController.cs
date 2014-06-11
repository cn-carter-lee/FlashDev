using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Collections;
using MvcTest.Models;
using Mvc.Entity;
using Mvc.Data;
using Mvc.Data.Interface;

namespace MvcTest.Controllers.Api
{
    public class StudentController : BaseApiController
    {
        public IEnumerable<Student> GetTags()
        {
            int classId = 1000;
            return StudentRepository.GetStudentList(classId);
        }

        public Tag Post(Tag value)
        {
            StudentRepository.Add(value);
            return value;
        }

        public void Delete(int id)
        {

        }
    }
}
