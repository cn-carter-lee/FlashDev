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
    public class TagController : BaseApiController
    {
        public IEnumerable<Tag> GetTags()
        {
            Tag[] tags = new Tag[]
            {
               new Tag{Id=1, Name="好动"},
               new Tag{Id=1, Name="善良"}
            };
            return tags;
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
