using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mvc.Entity
{
    public class Exam
    {
        public Exam()
        {
            List<ClassScore> listClassScore = new List<ClassScore>()
            {
               new ClassScore(){ Id=1, Name="1班", Score=39} ,
               new ClassScore(){ Id=2, Name="2班", Score=45} ,
               new ClassScore(){ Id=3, Name="3班", Score=49} ,
               new ClassScore(){ Id=4, Name="4班", Score=54} ,
               new ClassScore(){ Id=5, Name="5班", Score=54} ,
               new ClassScore(){ Id=6, Name="6班", Score=60} ,
               new ClassScore(){ Id=7, Name="7班", Score=65} ,
               new ClassScore(){ Id=8, Name="8班", Score=70} ,
               new ClassScore(){ Id=9, Name="9班", Score=75} 
            };
            Classes = from exam in listClassScore select exam;
        }

        public IEnumerable<ClassScore> Classes { get; set; }
    }

    public class ClassScore : Class
    {
        public float Score { get; set; }
    }
}
