using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Http.Controllers;
using System.Reflection;
using System.Collections.Concurrent;
using System.Web.Http;
using System.Web.Http.Routing;
using System.Net;
using System.Net.Http;
using System;

namespace MvcTest.Utility
{
    /// <summary>
    /// Api controllerAction selector based on routing, It's faster that the default one.
    /// </summary>
    public class RoutingBasedHttpActionSelector : IHttpActionSelector
    {
        /// <summary>
        /// Key: controllerTypeName;
        /// </summary>
        private IDictionary<string, IList<ApiActionRoutingMetadata>> controllerMethodsCache;

        public RoutingBasedHttpActionSelector(IDictionary<Type, IList<ApiActionRoutingMetadata>> controllerActionsMap)
        {
            if (controllerActionsMap == null)
            {
                throw new ArgumentNullException("controllerActionsMap");
            }

            this.controllerMethodsCache = controllerActionsMap.Where(kvp => typeof(ApiController).IsAssignableFrom(kvp.Key)).ToDictionary(kvp => kvp.Key.FullName, kvp => kvp.Value);
        }

        #region IHttpActionSelector Members

        public HttpActionDescriptor SelectAction(HttpControllerContext controllerContext)
        {
            if (controllerContext == null)
            {
                throw new ArgumentNullException("controllerContext");
            }

            string methodName = controllerContext.RouteData.GetVariable<string>(Utils.ACTION_ROUTE_KEY);
            if (!string.IsNullOrWhiteSpace(methodName))
            {
                IList<ApiActionRoutingMetadata> methods = null;
                this.controllerMethodsCache.TryGetValue(controllerContext.ControllerDescriptor.ControllerType.FullName, out methods);
                if (methods != null)
                {
                    var action = FindMatchedAction(controllerContext, methods);
                    if (action != null)
                    {
                        return action;
                    }
                }
            }

            throw new HttpResponseException(HttpStatusCode.NotFound);
        }

        public ILookup<string, HttpActionDescriptor> GetActionMapping(HttpControllerDescriptor controllerDescriptor)
        {
            IList<ApiActionRoutingMetadata> actionList = null;
            this.controllerMethodsCache.TryGetValue(controllerDescriptor.ControllerType.FullName, out actionList);
            if (actionList != null)
            {
                return actionList.Select(act => act.CreateHttpActionDescriptor(controllerDescriptor)).ToLookup(actDesc => actDesc.ActionName, StringComparer.OrdinalIgnoreCase);
            }

            return null;
        }

        #endregion

        private HttpActionDescriptor FindMatchedAction(HttpControllerContext context, IEnumerable<ApiActionRoutingMetadata> actionMetadataList)
        {
            string actionName = context.RouteData.GetVariable<string>(Utils.ACTION_ROUTE_KEY);

            ApiActionRoutingMetadata action = actionMetadataList.FirstOrDefault(meta => string.Equals(meta.MethodInfo.Name, actionName, StringComparison.OrdinalIgnoreCase)
                && meta.HttpMethods.Contains(context.Request.Method)
                && meta.RouteTemplates.Contains(context.RouteData.Route.RouteTemplate, StringComparer.OrdinalIgnoreCase));

            if (action != null)
            {
                return action.CreateHttpActionDescriptor(context.ControllerDescriptor);
            }

            return null;
        }
    }
}
