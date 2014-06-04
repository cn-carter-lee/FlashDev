using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Http;
using System.Reflection;
using System.Web.Http.Controllers;
using System.Web.Http.Routing;

namespace MvcTest.Utility
{
    /// <summary>
    /// Configure based on routing.
    /// </summary>
    public class ApiRoutingConfig
    {
        public static Func<MethodInfo, bool> ControllerActionFilter;
        public static Func<Type, bool> ControllerFilter;

        /// <summary>
        /// Configure routing
        /// </summary>
        /// <param name="controllerActionsMap"></param>
        public static void ConfigureActionSelector(IDictionary<Type, IList<ApiActionRoutingMetadata>> controllerActionsMap)
        {
            var routingBasedActionSelector = new RoutingBasedHttpActionSelector(controllerActionsMap);
            GlobalConfiguration.Configuration.Services.Replace(typeof(IHttpActionSelector), routingBasedActionSelector);
        }

        public static IDictionary<Type, IList<ApiActionRoutingMetadata>> AddHttpRoutesFromTypes(Func<IEnumerable<Type>> typeSelector, HttpRouteCollection routes, string urlPrefix = null)
        {
            var allTypes = typeSelector();
            Dictionary<Type, IList<ApiActionRoutingMetadata>> result = new Dictionary<Type, IList<ApiActionRoutingMetadata>>();
            foreach (var controllerType in allTypes)
            {
                var routingMetadatas = AddHttpRoutesFromType(controllerType, routes, urlPrefix).ToList();
                if (routingMetadatas.Count > 0)
                {
                    result.Add(controllerType, routingMetadatas);
                }
            }

            return result;
        }

        public static IEnumerable<ApiActionRoutingMetadata> AddHttpRoutesFromType(Type controllerType, HttpRouteCollection routes, string urlPrefix = null)
        {
            if (controllerType == null || controllerType.IsAbstract || !typeof(ApiController).IsAssignableFrom(controllerType))
            {
                yield break;
            }

            if (ControllerFilter != null && !ControllerFilter(controllerType))
            {
                yield break;
            }

            string controller = controllerType.Name.Substring(0, controllerType.Name.LastIndexOf("Controller"));
            var routingQuery = (from method in controllerType.GetMethods(BindingFlags.Instance | BindingFlags.Public)
                                let routeMaps = method.GetCustomAttributes(typeof(ApiRouteMapAttribute), false)
                                where (ControllerActionFilter == null || ControllerActionFilter(method)) && routeMaps.Length > 0
                                let meta = new ApiActionRoutingMetadata { MethodInfo = method }
                                from desc in routeMaps.Select(attr => ((ApiRouteMapAttribute)attr).CreateApiRouteDescriptor(controller, method.Name))
                                select new
                                {
                                    RouteDesc = desc,
                                    RoutingMetadata = meta
                                }).OrderByDescending(r => r.RouteDesc.Priority);

            foreach (var routing in routingQuery)
            {
                IHttpRoute httpRoute = routing.RouteDesc.CreateIHttpRoute(urlPrefix);
                string routeName = string.Format("{0}.{1}.{2}", routing.RouteDesc.Controller, routing.RouteDesc.Action, Guid.NewGuid().ToString());
                routing.RoutingMetadata.RouteTemplates.Add(httpRoute.RouteTemplate);

                // add route with ext;
                routing.RouteDesc.UrlTemplate = string.Concat(routing.RouteDesc.UrlTemplate, ".{ext}");
                routing.RouteDesc.ConstrainedParameters.Add(new ApiRouteParameterDescriptor { Name = "ext", Pattern = "json|xml" });

                IHttpRoute httpRouteWithExt = routing.RouteDesc.CreateIHttpRoute(urlPrefix);
                string routeNameWithExt = string.Concat(routeName, ".ext");
                routing.RoutingMetadata.RouteTemplates.Add(httpRouteWithExt.RouteTemplate);
                routes.Add(routeNameWithExt, httpRouteWithExt);

                // add route
                routes.Add(routeName, httpRoute);

                foreach (var mt in routing.RouteDesc.AllowedMethods)
                {
                    if (!routing.RoutingMetadata.HttpMethods.Contains(mt))
                    {
                        routing.RoutingMetadata.HttpMethods.Add(mt);
                    }
                }

                yield return routing.RoutingMetadata;
            }
        }
    }
}
