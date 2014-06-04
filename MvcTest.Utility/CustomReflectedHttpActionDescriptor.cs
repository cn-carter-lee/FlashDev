using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Http.Controllers;
using System.Reflection;
using System.Collections.ObjectModel;
using System.Net.Http;

namespace MvcTest.Utility
{
    /// <summary>
    /// Custom reflectedHttpActionDescriptor.
    /// </summary>
    internal class CustomReflectedHttpActionDescriptor : ReflectedHttpActionDescriptor
    {
        private Collection<HttpMethod> supportedMethods;

        public CustomReflectedHttpActionDescriptor(HttpControllerDescriptor controllerDescriptor, MethodInfo method, IList<HttpMethod> httpMethods)
            : base(controllerDescriptor, method)
        {
            this.supportedMethods = new Collection<System.Net.Http.HttpMethod>(httpMethods);
        }

        public override Collection<System.Net.Http.HttpMethod> SupportedHttpMethods
        {
            get
            {
                return this.supportedMethods;
            }
        }
    }
}
