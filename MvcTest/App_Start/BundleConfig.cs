using System.Web;
using System.Web.Optimization;

namespace MvcTest
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
                        "~/Scripts/jquery-ui-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.unobtrusive*",
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/Scripts/js").Include(
                        "~/Scripts/jquery-1.10.2.js",
                        "~/Scripts/jquery-ui-1.10.4.custom.js",
                        "~/Scripts/jquery.jqtimeline.js",
                        "~/Scripts/jquery.handsontable.full.js",
                        "~/Scripts/select2.js",
                        "~/Scripts/perfect-scrollbar.js",
                        "~/Scripts/swfobject.js",
                        "~/Scripts/dataloader.js",
                        "~/Scripts/site.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include("~/Content/css/jquery-ui-1.10.4.custom.css",
                "~/Content/css/jquery.jqtimeline.css",
                "~/Content/css/jquery.handsontable.full.css",
                "~/Content/css/select2.css",
                "~/Content/css/perfect-scrollbar.css",
                "~/Content/css/basic.css"));

            bundles.Add(new StyleBundle("~/Content/themes/base/css").Include(
                        "~/Content/themes/base/jquery.ui.core.css",
                        "~/Content/themes/base/jquery.ui.resizable.css",
                        "~/Content/themes/base/jquery.ui.selectable.css",
                        "~/Content/themes/base/jquery.ui.accordion.css",
                        "~/Content/themes/base/jquery.ui.autocomplete.css",
                        "~/Content/themes/base/jquery.ui.button.css",
                        "~/Content/themes/base/jquery.ui.dialog.css",
                        "~/Content/themes/base/jquery.ui.slider.css",
                        "~/Content/themes/base/jquery.ui.tabs.css",
                        "~/Content/themes/base/jquery.ui.datepicker.css",
                        "~/Content/themes/base/jquery.ui.progressbar.css",
                        "~/Content/themes/base/jquery.ui.theme.css"));
        }
    }
}