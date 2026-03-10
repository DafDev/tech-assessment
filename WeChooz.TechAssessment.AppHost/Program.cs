var builder = DistributedApplication.CreateBuilder(args);

var sqlServerPassword = builder.AddParameter("sql-server-password", true);
var sqlServer = builder.AddSqlServer("sql-server", sqlServerPassword, 5678)
                        .WithContainerName("sql_server")
                        .WithLifetime(ContainerLifetime.Persistent)
                        .WithEndpoint("tcp", endpoint => endpoint.IsProxied = false);
var formationDb = sqlServer.AddDatabase("formation");

var dacpacPath = Path.GetFullPath(
    Path.Combine(builder.AppHostDirectory, "..",
        "WeChooz.TechAssessment.Database.SqlServer",
        "bin", "Debug", "net10.0",
        "WeChooz.TechAssessment.Database.SqlServer.dacpac"));

builder.AddSqlProject("formation-db")
    .WithDacpac(dacpacPath)
    .WithReference(formationDb)
    .WaitFor(sqlServer);

var cache = builder.AddRedis("cache")
                    .WithContainerName("redis_cache")
                    .WithLifetime(ContainerLifetime.Persistent)
                    .WithRedisInsight(options => options
                        .WithContainerName("redis_insight")
                        .WithLifetime(ContainerLifetime.Persistent)
                    );

builder.AddProject<Projects.WeChooz_TechAssessment_Web>("webfrontend")
    .AddNpmRestore()
    .WithExternalHttpEndpoints()
    .WithReference(formationDb).WaitFor(formationDb)
    .WithReference(cache).WaitFor(cache)
    ;

builder.Build().Run();
