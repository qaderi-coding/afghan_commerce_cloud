var builder = WebApplication.CreateBuilder(args);

builder.Services.AddGraphQLServer();

var app = builder.Build();

app.MapGraphQL();

app.MapGet("/health", () => "Afghan Commerce Cloud Identity Access API is running");

app.Run();
