using SmartStore.Core.Plugins;
using SmartStore.Services.Payments;
using System;
using System.Web.Routing;

namespace SmartStore.CBE.Providers
{
    [SystemName("Payments.CBEPayment")]
    [FriendlyName("Pay with CBE")]
    [DisplayOrder(10)]
    [DependentWidgets("Widgets.Paycbe")]
    public class CBEPaymentProvider : PaymentMethodBase
    {
        public override void GetConfigurationRoute(out string actionName, out string controllerName, out RouteValueDictionary routeValues)
        {
            throw new NotImplementedException();
        }

        public override Type GetControllerType()
        {
            throw new NotImplementedException();
        }

        public override void GetPaymentInfoRoute(out string actionName, out string controllerName, out RouteValueDictionary routeValues)
        {
            throw new NotImplementedException();
        }

        public override ProcessPaymentResult ProcessPayment(ProcessPaymentRequest processPaymentRequest)
        {
            throw new NotImplementedException();
        }
    }
}
