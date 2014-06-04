using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MvcTest.Utility
{
    /// <summary>
    /// Represent route parameter, include name, pattern information.
    /// </summary>
    public class ApiRouteParameterDescriptor
    {
        public string Name { get; set; }
        public string Pattern { get; set; }
        public bool IsOptional { get; set; }
    }
}
