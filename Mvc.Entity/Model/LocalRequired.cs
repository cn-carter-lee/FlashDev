using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace Mvc.Entity.Model
{
    public class LocalRequired : RequiredAttribute
    {
        public override string FormatErrorMessage(string name)
        {
            return string.Format("{0}不能为空.", name);
        }
    }
}
