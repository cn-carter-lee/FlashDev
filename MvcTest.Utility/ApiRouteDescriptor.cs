using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Http.Routing;
using System.Web.Http;
using System.Net.Http;

namespace MvcTest.Utility
{
    /// <summary>
    /// Route description, it provide infomation for route.
    /// </summary>
    public class ApiRouteDescriptor
    {
        const string HTTP_METHOD_KEY = "httpMethod";
        const string CONTROLLER_KEY = "controller";
        const string ACTION_KEY = "action";

        protected HttpRouteValueDictionary defaultValues = new HttpRouteValueDictionary();
        protected HttpRouteValueDictionary defaultConstraints = new HttpRouteValueDictionary();

        public string UrlTemplate { get; set; }

        public string HttpMethods
        {
            get
            {
                return string.Join(",", this.AllowedMethods.Select(m => m.Method));
            }
            set
            {
                if (value == null)
                {
                    this.defaultConstraints.Remove(HTTP_METHOD_KEY);
                }
                else
                {
                    var methods = value.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                    if (methods.Length > 0)
                    {
                        this.defaultConstraints[HTTP_METHOD_KEY] = new System.Web.Http.Routing.HttpMethodConstraint(methods.Distinct().Select(m => new HttpMethod(m)).ToArray());
                    }
                    else
                    {
                        this.defaultConstraints.Remove(HTTP_METHOD_KEY);
                    }
                }
            }
        }

        public string Controller
        {
            get
            {
                return this.TryGetValue<string>(this.defaultValues, CONTROLLER_KEY);
            }
            set
            {
                this.defaultValues[CONTROLLER_KEY] = value;
            }
        }

        public string Action
        {
            get
            {
                return this.TryGetValue<string>(this.defaultValues, ACTION_KEY);
            }
            set
            {
                this.defaultValues[ACTION_KEY] = value;
            }
        }

        public int Priority { get; set; }

        public bool CatchAllArgs
        {
            get
            {
                var routeParameter = this.TryGetValue<RouteParameter>(this.defaultValues, "args");
                return routeParameter != null;
            }
            set
            {
                if (value)
                {
                    this.defaultValues["args"] = RouteParameter.Optional;
                }
                else
                {
                    this.defaultValues.Remove("args");
                }
            }
        }

        public IList<ApiRouteParameterDescriptor> ConstrainedParameters { get; set; }

        public IEnumerable<HttpMethod> AllowedMethods
        {
            get
            {
                HttpMethodConstraint constraint = this.TryGetValue<HttpMethodConstraint>(this.defaultConstraints, HTTP_METHOD_KEY);
                if (constraint != null)
                {
                    return constraint.AllowedMethods;
                }

                return Enumerable.Empty<HttpMethod>();
            }
        }

        public IHttpRoute CreateIHttpRoute(string urlPrefix)
        {
            var routeDefaultValues = new HttpRouteValueDictionary(this.defaultValues);
            var routeConstraints = new HttpRouteValueDictionary(this.defaultConstraints);

            if (this.ConstrainedParameters != null)
            {
                foreach (var desc in this.ConstrainedParameters)
                {
                    bool hasPattern = !string.IsNullOrWhiteSpace(desc.Pattern);
                    if (desc.IsOptional)
                    {
                        routeDefaultValues[desc.Name] = RouteParameter.Optional;
                        if (hasPattern)
                        {
                            routeConstraints[desc.Name] = new ApiOptionalParameterConstraint(desc.Pattern);
                        }
                    }
                    else
                    {
                        if (hasPattern)
                        {
                            routeConstraints[desc.Name] = desc.Pattern;
                        }
                    }
                }
            }

            string routeTempl = this.UrlTemplate.Trim('/', ' ');
            if (this.CatchAllArgs)
            {
                routeTempl = string.Concat(routeTempl, "/{*args}");
            }

            if (!string.IsNullOrWhiteSpace(urlPrefix))
            {
                routeTempl = string.Concat(urlPrefix.TrimEnd('/'), "/", routeTempl);
            }

            return new HttpRoute(routeTempl, routeDefaultValues, routeConstraints);
        }

        protected T TryGetValue<T>(IDictionary<string, object> dict, string key)
        {
            object value = null;
            dict.TryGetValue(key, out value);
            if (value == null)
            {
                return default(T);
            }

            return value.As<T>();
        }
    }
}
