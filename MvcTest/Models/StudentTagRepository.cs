using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Mvc.Entity;

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
            DataGateway<DataContext>.Instance.Add(tag);
            DataGateway<DataContext>.Instance.Save();
            return tag;
        }

        void IStudentTagRepository.Remove(int id)
        {
            throw new NotImplementedException();
        }



        Award IStudentTagRepository.Add(Award award)
        {
            DataGateway<DataContext>.Instance.Add(award);
            DataGateway<DataContext>.Instance.Save();
            return award;
        }
    }
}