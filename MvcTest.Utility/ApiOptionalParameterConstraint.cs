using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Http.Routing;
using System.Text.RegularExpressions;
using System.Net.Http;
using System.Web.Http;

namespace MvcTest.Utility
{
    /// <summary>
    /// Constraint for optional parameters
    /// </summary>
    public class ApiOptionalParameterConstraint : IHttpRouteConstraint
    {
        private string pattern;
        private Regex regex;

        public ApiOptionalParameterConstraint(string pattern)
        {
            this.pattern = pattern;
        }

        public ApiOptionalParameterConstraint(Regex pattern)
        {
            this.regex = pattern;
        }

        public bool Match(HttpRequestMessage request, IHttpRoute route, string parameterName, IDictionary<string, object> values, HttpRouteDirection routeDirection)
        {
            // if the parameter is optional and has no value, then return true;
            if (route.Defaults.ContainsKey(parameterName)
                && route.Defaults[parameterName] == RouteParameter.Optional)
            {
                if (values[parameterName] == RouteParameter.Optional)
                {
                    return true;
                }
            }

            if (this.regex == null)
            {
                if (this.pattern == null)
                {
                    throw new ArgumentNullException("pattern");
                }

                this.regex = new Regex("^(" + this.pattern + ")$", RegexOptions.CultureInvariant | RegexOptions.Compiled | RegexOptions.IgnoreCase);
            }

            return this.regex.IsMatch(values[parameterName].ToString());
        }
    }
}
