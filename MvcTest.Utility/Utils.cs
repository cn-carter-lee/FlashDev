using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Http.Routing;

namespace MvcTest.Utility
{
    internal static class Utils
    {
        public const string CONTROLLER_ROUTE_KEY = "controller";
        public const string ACTION_ROUTE_KEY = "action";
        public const string VERSION_ROUTE_KEY = "version";

        public static T GetVariable<T>(this IHttpRouteData routeData, string key)
        {
            object result = null;
            routeData.Values.TryGetValue(key, out result);
            if (result != null)
            {
                return result.As<T>();
            }

            return default(T);
        }
    }
}
