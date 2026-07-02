// This project has been consolidated into API.Gateway
// Identity endpoints are now available at /api/auth in API.Gateway

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
app.MapGet("/health", () => "IdentityAccess module consolidated - use API.Gateway");
app.Run();
