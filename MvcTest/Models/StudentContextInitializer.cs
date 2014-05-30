using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace MvcTest.Models
{
    public class StudentContextInitializer : DropCreateDatabaseIfModelChanges<StudentContext>
    {
        protected override void Seed(StudentContext context)
        {
            var students = new List<Student>()
            {

            };

            students.ForEach(s => context.Students.Add(s));
            context.SaveChanges();

        }
    }
}