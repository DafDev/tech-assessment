using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;
using WeChooz.TechAssessment.Domain.Adapters;

namespace WeChooz.TechAssessment.Web.Home;

public class HomeController(IManageSessions sessionManager) : Controller
{

    [HttpGet]
    public async Task<IActionResult> Handle()
    {
        Response.Headers[HeaderNames.CacheControl] = "no-cache, must-revalidate";
        var sessions = await sessionManager.GetSessions();
        return View(sessions);
    }
}
