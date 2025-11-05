# Support

Thank you for using Meal Planner! We're here to help.

## Getting Help

### Documentation

Start with our documentation:
- [README.md](README.md) - Quick start and overview
- [CONTRIBUTING.md](CONTRIBUTING.md) - Development guidelines
- [ROADMAP.md](ROADMAP.md) - Planned features
- [GitHub Wiki](https://github.com/isaacrlevin/MealPlanner/wiki) - Detailed guides

### Common Questions

#### Installation & Setup

**Q: Which .NET version do I need?**
A: .NET 9 SDK. Download from [dotnet.microsoft.com](https://dotnet.microsoft.com/download/dotnet/9.0)

**Q: How do I run the application?**
A: See the Quick Start section in [README.md](README.md#-getting-started)

**Q: Can I use this in production?**
A: Currently v0.1.0 is suitable for personal use. Production deployment requires authentication and security hardening.

#### Development

**Q: How do I contribute?**
A: See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines

**Q: Where do I report bugs?**
A: Use the [Bug Report template](.github/ISSUE_TEMPLATE/bug_report.yml)

**Q: How do I request a feature?**
A: Use the [Feature Request template](.github/ISSUE_TEMPLATE/feature_request.yml)

#### Troubleshooting

**Q: Build fails with "SDK not found"**
A: Install .NET 9 SDK and restart your terminal/IDE

**Q: API returns 404 errors**
A: Ensure the API is running on port 5001 before starting the client

**Q: Database not persisting data**
A: Check file permissions for `mealplanner.db` in the API directory

**Q: CORS errors in browser console**
A: Verify API is running and CORS is configured in `Program.cs`

## Support Channels

### 1. GitHub Issues

For bugs and feature requests:
- [Open an issue](https://github.com/isaacrlevin/MealPlanner/issues/new/choose)
- Use appropriate template
- Provide clear reproduction steps
- Include environment details

### 2. GitHub Discussions

For questions and general discussion:
- [Start a discussion](https://github.com/isaacrlevin/MealPlanner/discussions)
- Search existing discussions first
- Categories:
  - **Q&A**: Ask questions
  - **Ideas**: Share feature ideas
  - **Show and Tell**: Share your projects
  - **General**: Everything else

### 3. Community

- Follow development updates in discussions
- Join conversations on pull requests
- Help other users with their questions

## Response Times

We aim to respond to:
- Security issues: Within 48 hours
- Bug reports: Within 3-5 business days
- Feature requests: Within 1-2 weeks
- Questions: Within 3-7 days

*Note: We're a small team. Response times may vary.*

## Self-Service Resources

### Debugging Tips

1. **Enable verbose logging**
   ```json
   // In appsettings.Development.json
   "Logging": {
     "LogLevel": {
       "Default": "Debug"
     }
   }
   ```

2. **Check browser console** for client-side errors

3. **Verify API endpoints** using browser or Postman:
   - `http://localhost:5001/api/recipes`
   - `http://localhost:5001/api/ingredients`
   - `http://localhost:5001/api/mealplans`

4. **Clear browser cache** if seeing stale UI

5. **Delete `mealplanner.db`** to reset database

### Development Tools

- **VS Code Extensions**:
  - C# Dev Kit
  - REST Client
  - SQLite Viewer

- **Useful Commands**:
  ```bash
  dotnet restore           # Restore packages
  dotnet build             # Build solution
  dotnet clean             # Clean build artifacts
  dotnet format            # Format code
  ```

## Providing Feedback

We value your feedback! Help us improve:

### What to Include

- **Version**: Which version are you using?
- **Environment**: OS, browser, .NET SDK version
- **Steps**: What did you do?
- **Expected**: What should happen?
- **Actual**: What actually happened?
- **Screenshots**: Visual evidence helps!

### Where to Share

- 🐛 **Bugs**: [Issue Tracker](https://github.com/isaacrlevin/MealPlanner/issues)
- 💡 **Ideas**: [Discussions](https://github.com/isaacrlevin/MealPlanner/discussions)
- ⭐ **Likes**: Star the repository!
- 🐦 **Social**: Share your experience

## Additional Resources

- [.NET Documentation](https://docs.microsoft.com/dotnet/)
- [Blazor Documentation](https://docs.microsoft.com/aspnet/core/blazor/)
- [Entity Framework Core](https://docs.microsoft.com/ef/core/)
- [Bootstrap 5 Docs](https://getbootstrap.com/docs/5.3/)

## Still Need Help?

If you can't find an answer:
1. Search [existing issues](https://github.com/isaacrlevin/MealPlanner/issues)
2. Search [discussions](https://github.com/isaacrlevin/MealPlanner/discussions)
3. Create a new issue or discussion
4. Provide as much detail as possible

We're here to help you succeed! 🚀

---

**Remember**: Be kind, patient, and respectful. We're all learning together!
