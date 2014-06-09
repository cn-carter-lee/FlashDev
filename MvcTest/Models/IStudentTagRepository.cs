using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Mvc.Entity;

namespace MvcTest.Models
{
    public interface IStudentTagRepository
    {
        IEnumerable<StudentTag> GetAll();
        StudentTag Add(StudentTag tag);
        void Remove(int id);
        Award Add(Award award);
    }
}
