using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Web.Http.Controllers;
using System.Net.Http;

namespace MvcTest.Utility
{
    /// <summary>
    /// Represent action routing-based data
    /// </summary>
    public class ApiActionRoutingMetadata
    {
        private object mutex;

        public IList<HttpMethod> HttpMethods { get; private set; }
        public IList<string> RouteTemplates { get; private set; }

        public MethodInfo MethodInfo { get; set; }

        public ApiActionRoutingMetadata()
        {
            mutex = new object();
            this.HttpMethods = new List<HttpMethod>();
            this.RouteTemplates = new List<string>();
        }

        private HttpActionDescriptor actionDescriptor;
        public HttpActionDescriptor CreateHttpActionDescriptor(HttpControllerDescriptor controllerDescriptor)
        {
            if (this.actionDescriptor == null)
            {
                lock (this.mutex)
                {
                    if (this.actionDescriptor == null)
                    {
                        this.actionDescriptor = new CustomReflectedHttpActionDescriptor(controllerDescriptor, this.MethodInfo, this.HttpMethods.ToArray());
                    }
                }
            }

            return this.actionDescriptor;
        }
    }
}
