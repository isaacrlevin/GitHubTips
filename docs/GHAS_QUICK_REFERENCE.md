# GHAS Quick Reference Card

Quick commands and tips for using GitHub Advanced Security features.

## 🚀 Quick Setup Commands

```bash
# Enable GHAS via GitHub CLI
gh api -X PATCH repos/:owner/:repo \
  -f security_and_analysis[advanced_security][status]=enabled

# Enable secret scanning
gh api -X PATCH repos/:owner/:repo \
  -f security_and_analysis[secret_scanning][status]=enabled

# Enable push protection
gh api -X PATCH repos/:owner/:repo \
  -f security_and_analysis[secret_scanning_push_protection][status]=enabled

# Trigger CodeQL workflow
gh workflow run codeql.yml
```

## 📊 View Security Alerts

```bash
# Code Scanning Alerts
gh api repos/:owner/:repo/code-scanning/alerts
gh api repos/:owner/:repo/code-scanning/alerts?state=open&severity=high

# Secret Scanning Alerts
gh api repos/:owner/:repo/secret-scanning/alerts
gh api repos/:owner/:repo/secret-scanning/alerts?state=open

# Dependabot Alerts
gh api repos/:owner/:repo/dependabot/alerts
gh api repos/:owner/:repo/dependabot/alerts?state=open&severity=high

# View specific alert
gh api repos/:owner/:repo/code-scanning/alerts/{alert_number}
```

## ✅ Manage Alerts

```bash
# Close code scanning alert as false positive
gh api repos/:owner/:repo/code-scanning/alerts/{alert_number} \
  -X PATCH -f state=dismissed -f dismissed_reason=false_positive

# Close secret scanning alert
gh api repos/:owner/:repo/secret-scanning/alerts/{alert_number} \
  -X PATCH -f state=resolved -f resolution=revoked

# Dismiss Dependabot alert
gh api repos/:owner/:repo/dependabot/alerts/{alert_number}/dismissals \
  -X POST -f dismiss_reason=inaccurate
```

## 🔍 CodeQL Queries

```bash
# List available query packs
gh api repos/:owner/:repo/code-scanning/codeql/databases

# Run custom query
codeql database analyze ./db \
  --format=sarif-latest \
  --output=results.sarif \
  custom-query.ql

# Upload SARIF results
gh api repos/:owner/:repo/code-scanning/sarifs \
  -X POST -F sarif=@results.sarif
```

## 🛡️ Secret Patterns

Common patterns detected:
- AWS Keys: `AKIA[0-9A-Z]{16}`
- GitHub PAT: `ghp_[a-zA-Z0-9]{36}`
- Azure: `DefaultEndpointsProtocol=https...`
- Private Keys: `-----BEGIN RSA PRIVATE KEY-----`

## 📦 Dependabot Commands

```bash
# List security advisories
gh api repos/:owner/:repo/security-advisories

# Trigger Dependabot update
gh api repos/:owner/:repo/dependabot/updates -X POST

# View Dependabot PRs
gh pr list --label dependencies --json number,title,updatedAt

# Auto-merge Dependabot PR (if tests pass)
gh pr merge {pr_number} --auto --squash
```

## 🔐 Security Best Practices

### Before Commit:
```bash
# Scan for secrets locally
git secrets --scan
trufflehog git file://. --json

# Check dependencies
dotnet list package --vulnerable
npm audit

# Run security linting
dotnet format --verify-no-changes
```

### In CI/CD:
```yaml
# Required checks
- CodeQL Analysis
- Dependency Review
- Secret Scanning
- Unit Tests
```

### In Pull Requests:
- ✅ All security checks must pass
- ✅ No critical/high vulnerabilities
- ✅ Security team approval for sensitive areas
- ✅ Conversation resolution required

## 🎯 Severity Levels

| Severity | CVSS Score | Action |
|----------|------------|--------|
| Critical | 9.0-10.0 | Fix immediately |
| High | 7.0-8.9 | Fix within 7 days |
| Medium | 4.0-6.9 | Fix within 30 days |
| Low | 0.1-3.9 | Fix in next cycle |

## 📈 Metrics to Monitor

```bash
# Security overview
gh api repos/:owner/:repo/code-scanning/alerts/summary

# Alert trends
gh api /repos/:owner/:repo/code-scanning/alerts \
  --jq 'group_by(.created_at[:7]) |
        map({month: .[0].created_at[:7], count: length})'

# Mean time to remediation
gh api repos/:owner/:repo/code-scanning/alerts?state=closed \
  --jq 'map((.created_at | fromdateiso8601) as $c |
            (.closed_at | fromdateiso8601) as $cl |
            ($cl - $c) / 86400) |
        add / length'
```

## 🚨 Incident Response

### If Secret Exposed:
1. **Immediately** rotate the credential
2. Review usage logs for compromise
3. Update all services using the secret
4. Close the alert as "revoked"
5. Add to .gitignore if file-based
6. Consider rewriting git history if needed

### If Vulnerability Found:
1. Assess severity and exploitability
2. Create tracking issue
3. Develop and test fix
4. Deploy fix to production
5. Close alert
6. Document lessons learned

## 🔗 Quick Links

- [Security Tab](../../security)
- [Code Scanning Alerts](../../security/code-scanning)
- [Secret Scanning Alerts](../../security/secret-scanning)
- [Dependabot Alerts](../../security/dependabot)
- [Security Policy](../../security/policy)
- [Actions Workflows](../../actions)

## 📚 Documentation

- [GHAS Overview](GITHUB_ADVANCED_SECURITY.md)
- [Setup Guide](GHAS_SETUP_GUIDE.md)
- [Security Policy](../SECURITY.md)
- [Example Vulnerabilities](../src/MealPlannerApi/Examples/VulnerableCodeExamples.cs)

## 🆘 Support

- GitHub Docs: https://docs.github.com/en/code-security
- Community: https://github.com/orgs/community/discussions/categories/code-security
- Support: https://support.github.com

---

**Pro Tip**: Bookmark this page for quick reference! 📌
