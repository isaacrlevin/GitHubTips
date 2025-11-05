# Security Policy

## Supported Versions

We release security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Reporting a Vulnerability

We take security seriously. If you discover a security vulnerability, please follow these steps:

### 1. Do Not Disclose Publicly

Please **do not** create a public GitHub issue for security vulnerabilities.

### 2. Report Privately

Use one of these methods:

- **GitHub Security Advisories** (Recommended)
  1. Go to the [Security tab](https://github.com/isaacrlevin/MealPlanner/security)
  2. Click "Report a vulnerability"
  3. Fill out the form with details

- **Email**
  - Send details to: security@yourdomain.com
  - Include "SECURITY" in the subject line
  - Encrypt sensitive information if possible

### 3. Include These Details

- Type of vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if known)
- Your contact information

### 4. Response Timeline

- **Initial Response**: Within 48 hours
- **Status Update**: Within 7 days
- **Fix Timeline**: Depends on severity
  - Critical: 1-7 days
  - High: 7-14 days
  - Medium: 14-30 days
  - Low: 30-90 days

## Security Best Practices

### For Users

1. **Keep Updated**
   - Use the latest version
   - Enable Dependabot alerts
   - Monitor release notes

2. **Secure Configuration**
   - Don't commit secrets to repository
   - Use environment variables for sensitive data
   - Use user secrets for local development

3. **Database Security**
   - Secure your SQLite database file
   - Use appropriate file permissions
   - Back up regularly

### For Contributors

1. **Code Security**
   - Validate all user inputs
   - Use parameterized queries (EF Core handles this)
   - Avoid exposing sensitive information in logs
   - Follow OWASP best practices

2. **Dependencies**
   - Review dependency updates
   - Check for known vulnerabilities
   - Use `dotnet list package --vulnerable`

3. **Authentication (Future)**
   - When implementing auth, use industry standards
   - Never store passwords in plain text
   - Use ASP.NET Core Identity or similar

## Known Security Considerations

### Current Version (0.1.0)

- **No Authentication**: Application is open to all users
  - Planned for future release
  - Do not deploy publicly without authentication

- **SQLite File Access**: Database file is accessible
  - Use appropriate file permissions
  - Consider encryption for sensitive data

- **CORS Configuration**: Currently allows all origins
  - Configure restrictive CORS in production
  - See `MealPlannerApi/Program.cs`

## Security Updates

Security patches will be:
- Released as soon as possible
- Announced in release notes
- Tagged with `[SECURITY]` prefix
- Documented in CHANGELOG.md

## Disclosure Policy

- We follow coordinated disclosure
- Public disclosure after fix is available
- Credit given to reporters (if desired)
- CVE assigned for significant vulnerabilities

## Contact

For security concerns:
- GitHub Security Advisories (preferred)
- Email: security@yourdomain.com

For general questions:
- Use GitHub Discussions
- See SUPPORT.md

Thank you for helping keep Meal Planner secure! 🔒
