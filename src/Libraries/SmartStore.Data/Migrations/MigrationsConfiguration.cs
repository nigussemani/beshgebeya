namespace SmartStore.Data.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    using System.Linq;
    using Setup;
    using SmartStore.Core.Data;
    using SmartStore.Utilities;

    public sealed class MigrationsConfiguration : DbMigrationsConfiguration<SmartObjectContext>
    {
        public MigrationsConfiguration()
        {
            AutomaticMigrationsEnabled = false;
            AutomaticMigrationDataLossAllowed = true;
            ContextKey = "SmartStore.Core";

            if (DataSettings.Current.IsSqlServer)
            {
                var commandTimeout = CommonHelper.GetAppSetting<int?>("sm:EfMigrationsCommandTimeout");
                if (commandTimeout.HasValue)
                {
                    CommandTimeout = commandTimeout.Value;
                }

                CommandTimeout = 9999999;
            }
        }

        public void SeedDatabase(SmartObjectContext context)
        {
            using (var scope = new DbContextScope(context, hooksEnabled: false))
            {
                Seed(context);
                scope.Commit();
            }
        }

        protected override void Seed(SmartObjectContext context)
        {
            context.MigrateLocaleResources(MigrateLocaleResources);
            MigrateSettings(context);
        }

        public void MigrateSettings(SmartObjectContext context)
        {

        }

        public void MigrateLocaleResources(LocaleResourcesBuilder builder)
        {
            builder.AddOrUpdate("Common.UnsupportedBrowser",
                "You are using an unsupported browser! Please consider switching to a modern browser such as Google Chrome, Firefox or Opera to fully enjoy your shopping experience.",
                "Sie verwenden einen nicht unterstützten Browser! Bitte ziehen Sie in Betracht, zu einem modernen Browser wie Google Chrome, Firefox oder Opera zu wechseln, um Ihr Einkaufserlebnis in vollen Zügen genießen zu können.");
        }
    }
}
