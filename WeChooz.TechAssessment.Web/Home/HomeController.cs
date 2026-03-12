using Microsoft.AspNetCore.Mvc;
using Microsoft.Net.Http.Headers;
using WeChooz.TechAssessment.Domain.Adapters;

namespace WeChooz.TechAssessment.Web.Home;

public class HomeController(IManageSessions sessionManager) : Controller
{
    [HttpGet]
    public IActionResult Handle()
    {
        Response.Headers[HeaderNames.CacheControl] = "no-cache, must-revalidate";
        return View();
    }

    [HttpGet, Route("api/sessions")]
    public async Task<IActionResult> GetSessions()
    {
        var sessions = await sessionManager.GetSessions();
        var result = sessions.Select(s => new
        {
            courseTitle = s.Course.Title,
            shortDescription = s.Course.ShortDescription,
            startDate = s.StartDate.ToString("yyyy-MM-dd"),
            durationInDays = s.Course.DurationInDays,
            instructor = s.Course.Instructor.ToString()
        });
        return Ok(result);
    }
}
