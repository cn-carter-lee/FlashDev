using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Mvc.Entity;
using Mvc.Data.Interface;

namespace Mvc.Data
{
    public class StudentRepository : IStudentRepository
    {
        private LocalContext entities = new LocalContext();

        #region Tag
        Tag IStudentRepository.Add(Tag tag)
        {
            var ret = entities.Tags.Add(tag);
            entities.Save();
            return ret;
        }
        IEnumerable<Tag> IStudentRepository.GetList()
        {
            throw new NotImplementedException();
        }
        public IEnumerable<Tag> GetTagList(int studentId)
        {
            throw new NotImplementedException();
        }


        #endregion

        #region Award

        Award IStudentRepository.Add(Award award)
        {
            var ret = entities.Awards.Add(award);
            entities.Save();
            return ret;
        }

        public IEnumerable<Award> GetAwardList(int classId)
        {
            return from award in entities.Awards
                   where award.ClassId == classId
                   orderby award.EventTime
                   select award;
        }

        #endregion

        #region Student

        public Student GetStudent(int studentId)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Student> GetStudentList(int classId)
        {
            return from student in entities.Students
                   where student.ClassId == classId
                   orderby student.DisplayOrder
                   select student;
        }

        #endregion
    }
}
