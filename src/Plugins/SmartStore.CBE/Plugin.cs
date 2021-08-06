using SmartStore.Core.Logging;
using SmartStore.Core.Plugins;
using SmartStore.Services;
using SmartStore.Services.Cms;
using System;
using System.Collections.Generic;
using System.Web.Routing;

namespace SmartStore.CBE
{
    [SystemName("Widgets.CBE")]
    [FriendlyName("CBE")]
    public class Plugin : BasePlugin
    {
        private readonly ICommonServices _services;

        public Plugin(
            ICommonServices services,ILogger logger)

        {
            _services = services;
            Logger = logger;
        }

        public ILogger Logger { get; set; }

        public static string SystemName => "SmartStore.PayPal";

        public override void Install()
        {
            _services.Localization.ImportPluginResourcesFromXml(this.PluginDescriptor);

            base.Install();
        }

        public override void Uninstall()
        {
            _services.Localization.DeleteLocaleStringResources(PluginDescriptor.ResourceRootKey);

            base.Uninstall();
        }

        public IEnumerable<CookieInfo> GetCookieInfo()
        {
            var cookieInfo = new CookieInfo
            {
                Name = _services.Localization.GetResource("Plugins.FriendlyName.Widgets.PayPal"),
                Description = _services.Localization.GetResource("Plugins.SmartStore.PayPal.CookieInfo"),
                CookieType = CookieType.Required
            };

            return new List<CookieInfo> { cookieInfo };
        }

        public IList<string> GetWidgetZones()
        {
            return new List<string>
            {
                "productdetails_add_info",
                "order_summary_totals_after",
                "orderdetails_page_aftertotal",
                "invoice_aftertotal"
            };
        }

       

    }
}
