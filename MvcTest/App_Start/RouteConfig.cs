using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace MvcTest
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {

            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
            
            /*
           routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
           routes.IgnoreRoute("favicon.ico");

           IAssembliesResolver assembliesResolver = GlobalConfiguration.Configuration.Services.GetAssembliesResolver();
           IHttpControllerTypeResolver controllersResolver = GlobalConfiguration.Configuration.Services.GetHttpControllerTypeResolver();
           ICollection<Type> controllerTypes = controllersResolver.GetControllerTypes(assembliesResolver);

           var routingMetas = ApiRoutingConfig.AddHttpRoutesFromTypes(() => { return controllerTypes.Where(t => t != typeof(BackwardCompatibleApiController) && t != typeof(CoupleController)); }, GlobalConfiguration.Configuration.Routes, "api/v1");
           routingMetas[typeof(BackwardCompatibleApiController)] = ApiRoutingConfig.AddHttpRoutesFromType(typeof(BackwardCompatibleApiController), GlobalConfiguration.Configuration.Routes).ToList();
           routingMetas[typeof(CoupleController)] = ApiRoutingConfig.AddHttpRoutesFromType(typeof(CoupleController), GlobalConfiguration.Configuration.Routes, "api/v1").ToList();
           ApiRoutingConfig.ConfigureActionSelector(routingMetas);
              
             */
        }
    }
}