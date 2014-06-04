using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MvcTest.Utility
{
    [AttributeUsage(AttributeTargets.Method, AllowMultiple = true)]
    public class ApiRouteMapAttribute : Attribute
    {
        private string[] constraintedParams;

        /// <summary>
        /// .ctor
        /// </summary>
        /// <param name="constraintedParameters">ext=json|xml, id?=\d+</param>
        public ApiRouteMapAttribute(params string[] constraintedParameters)
        {
            this.constraintedParams = constraintedParameters ?? new string[0];
        }

        public string HttpMethod { get; set; }
        public int Priority { get; set; }
        public bool CatchAllArgs { get; set; }
        public string UrlTemplate { get; set; }

        public ApiRouteDescriptor CreateApiRouteDescriptor(string controller, string action)
        {
            ApiRouteDescriptor routeDesc = new ApiRouteDescriptor
            {
                UrlTemplate = this.UrlTemplate,
                HttpMethods = this.HttpMethod ?? "GET",
                Controller = controller,
                Action = action,
                CatchAllArgs = this.CatchAllArgs,
                Priority = this.Priority,
                ConstrainedParameters = new List<ApiRouteParameterDescriptor>()
            };

            foreach (var param in this.constraintedParams)
            {
                var splittedChars = param.Split(new char[] { '=' }, StringSplitOptions.RemoveEmptyEntries);
                if (splittedChars.Length > 1)
                {
                    string name = splittedChars[0].Trim();
                    bool isOptional = name.EndsWith("?");

                    routeDesc.ConstrainedParameters.Add(new ApiRouteParameterDescriptor
                    {
                        Name = isOptional ? name.TrimEnd('?') : name,
                        Pattern = splittedChars[1].Trim(),
                        IsOptional = isOptional
                    });
                }
            }

            return routeDesc;
        }
    }
}
