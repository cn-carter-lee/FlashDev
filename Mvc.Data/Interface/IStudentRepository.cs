using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Mvc.Entity;

namespace Mvc.Data.Interface
{
    public interface IStudentRepository
    {
        IEnumerable<Tag> GetList();
        IEnumerable<Tag> GetTagList(int studentId);
        Tag Add(Tag tag);
        
        Award Add(Award award);
        IEnumerable<Award> GetAwardList(int classId);

        Student GetStudent(int studentId);
        IEnumerable<Student> GetStudentList(int classId);
    }
}
