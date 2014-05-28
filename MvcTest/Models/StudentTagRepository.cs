using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MvcTest.Models
{
    public class StudentTagRepository : IStudentTagRepository
    {
        IEnumerable<StudentTag> IStudentTagRepository.GetAll()
        {
            throw new NotImplementedException();
        }

        StudentTag IStudentTagRepository.Add(StudentTag tag)
        {
            throw new NotImplementedException();
        }

        void IStudentTagRepository.Remove(int id)
        {
            throw new NotImplementedException();
        }
    }
}