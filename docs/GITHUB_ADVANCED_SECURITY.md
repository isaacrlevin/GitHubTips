# GitHub Advanced Security Showcase

This repository demonstrates the key features of **GitHub Advanced Security (GHAS)** to help secure your applications throughout the development lifecycle.

## 🔒 GHAS Features Enabled

### 1. **Code Scanning with CodeQL**
Automatically identifies security vulnerabilities and coding errors in your codebase.

**What it does:**
- Scans C# code for common security vulnerabilities (SQL injection, XSS, path traversal, etc.)
- Runs on every push, pull request, and weekly schedule
- Creates security alerts viewable in the Security tab
- Integrates with pull requests to block vulnerable code

**See it in action:**
- Navigate to **Security → Code scanning**
- Check the `.github/workflows/codeql.yml` workflow
- View alerts and remediation guidance

**Example vulnerabilities detected:**
- SQL Injection risks
- Path traversal vulnerabilities
- Insecure deserialization
- Weak cryptography
- Command injection

### 2. **Secret Scanning**
Prevents credentials and tokens from being committed to the repository.

**What it does:**
- Automatically scans commits for secrets (API keys, passwords, tokens)
- Alerts maintainers when secrets are detected
- Supports 200+ token types and patterns
- Partner program notifies service providers to revoke exposed tokens

**See it in action:**
- Navigate to **Security → Secret scanning**
- Push protection prevents secrets from being committed
- Alerts show historical secret exposures

**Supported secret types:**
- API keys (AWS, Azure, Google Cloud)
- Database connection strings
- Private keys
- OAuth tokens
- Service account credentials

### 3. **Dependency Review**
Analyzes dependencies in pull requests to identify vulnerable or malicious packages.

**What it does:**
- Scans package changes in PRs (NuGet, npm, etc.)
- Identifies known CVEs in dependencies
- Shows license compliance information
- Blocks PRs with high-severity vulnerabilities

**See it in action:**
- Create a PR that adds or updates dependencies
- Check the Dependency Review workflow results
- View the **Security → Dependabot** alerts

**Example checks:**
- Vulnerable NuGet packages
- Outdated dependencies with security patches
- License compliance (GPL, MIT, Apache)
- Malicious package detection

### 4. **Dependabot Security Updates**
Automatically creates pull requests to update vulnerable dependencies.

**What it does:**
- Monitors dependencies for known vulnerabilities
- Creates automated PRs to update vulnerable packages
- Prioritizes updates based on severity
- Includes changelog and release notes

**See it in action:**
- Navigate to **Security → Dependabot**
- View automated update PRs in the Pull Requests tab
- Configure via `.github/dependabot.yml`

## 📊 Security Dashboard

Access the centralized security view:
1. Go to **Security** tab in your repository
2. View **Overview** for security posture summary
3. Explore each category:
   - **Code scanning alerts**
   - **Secret scanning alerts**
   - **Dependabot alerts**
   - **Security advisories**

## 🚀 Getting Started

### Enable GHAS Features

1. **Code Scanning (CodeQL)**
   - Already configured in `.github/workflows/codeql.yml`
   - Runs automatically on push/PR to main branch
   - Weekly scheduled scans every Monday

2. **Secret Scanning**
   - Enable in **Settings → Code security → Secret scanning**
   - Turn on "Push protection" to prevent secret commits
   - Configure custom patterns if needed

3. **Dependency Review**
   - Already configured in `.github/workflows/dependency-review.yml`
   - Runs automatically on pull requests
   - Configurable severity thresholds

4. **Dependabot**
   - Enable in **Settings → Code security → Dependabot**
   - Configure via `.github/dependabot.yml`
   - Set update frequency and scope

### Repository Settings

To showcase all features:

```
Settings → Code security and analysis
├── Dependency graph: ✅ Enabled
├── Dependabot alerts: ✅ Enabled
├── Dependabot security updates: ✅ Enabled
├── Grouped security updates: ✅ Enabled
├── Dependabot version updates: ✅ Enabled
├── Code scanning: ✅ Enabled (CodeQL)
├── Secret scanning: ✅ Enabled
└── Push protection: ✅ Enabled
```

## 🎯 Demo Scenarios

### Scenario 1: Catch SQL Injection
1. Create a branch with SQL injection vulnerability
2. Open a PR - CodeQL will flag the issue
3. View the alert with remediation steps
4. Fix the code and see the alert resolve

### Scenario 2: Prevent Secret Leakage
1. Try to commit an AWS access key
2. Push protection blocks the commit
3. Remove the secret and commit successfully
4. View secret scanning alerts if any historical secrets exist

### Scenario 3: Block Vulnerable Dependencies
1. Create a PR that downgrades a package to a vulnerable version
2. Dependency Review workflow fails the check
3. View CVE details and severity
4. Update to a secure version

### Scenario 4: Automated Security Patches
1. Wait for Dependabot to detect a vulnerability
2. Review the automated PR it creates
3. Check the changelog and compatibility
4. Merge the automated fix

## 📈 Metrics and Reporting

GHAS provides metrics for security posture:

- **Mean Time to Remediation (MTTR)**: How quickly vulnerabilities are fixed
- **Alert trends**: Security improvements over time
- **Coverage**: Percentage of code scanned
- **Compliance**: Security policy adherence

Access via:
- Repository Insights → Security
- Organization Security Overview (for enterprise)
- REST API for custom dashboards

## 🔧 Advanced Configuration

### Custom CodeQL Queries
Add custom security rules in `.github/codeql/`:
```yaml
# Example: Custom query pack
- uses: github/codeql-action/init@v4
  with:
    queries: security-extended,security-and-quality
    packs: my-org/my-security-queries
```

### Secret Scanning Patterns
Add custom patterns via repository settings or `secret_scanning.yml`:
```yaml
patterns:
  - name: Internal API Key
    pattern: 'INTAPI[0-9a-f]{32}'
    confidence: high
```

### Dependency Review Policies
Configure in `.github/workflows/dependency-review.yml`:
```yaml
- severity: high  # Fail on high/critical
- license: GPL-3.0  # Block incompatible licenses
- allow-dependencies-licenses: MIT,Apache-2.0
```

## 📚 Resources

- [GitHub Advanced Security Documentation](https://docs.github.com/en/code-security)
- [CodeQL Documentation](https://codeql.github.com/docs/)
- [Secret Scanning Partner Program](https://docs.github.com/en/code-security/secret-scanning/secret-scanning-partner-program)
- [Dependabot Documentation](https://docs.github.com/en/code-security/dependabot)
- [Security Best Practices](https://docs.github.com/en/code-security/getting-started/securing-your-repository)

## 🎓 Learning Path

1. **Week 1**: Enable all GHAS features and review existing alerts
2. **Week 2**: Triage and remediate code scanning findings
3. **Week 3**: Configure Dependabot and merge security updates
4. **Week 4**: Implement custom CodeQL queries for your domain
5. **Week 5**: Set up security policies and review processes

## 💡 Best Practices

✅ **Enable all GHAS features** for comprehensive coverage
✅ **Review alerts regularly** - set up notifications
✅ **Use branch protection** - require security checks to pass
✅ **Rotate secrets immediately** if exposed
✅ **Keep dependencies updated** - merge Dependabot PRs promptly
✅ **Write secure code** - follow OWASP guidelines
✅ **Train your team** on security best practices
✅ **Monitor metrics** to track improvement
✅ **Document security policies** in SECURITY.md
✅ **Automate remediation** where possible

## 🔐 Security Policies

This repository follows security best practices:
- See [SECURITY.md](../SECURITY.md) for vulnerability reporting
- See [CONTRIBUTING.md](../CONTRIBUTING.md) for secure development guidelines
- All dependencies must be approved and scanned
- Secrets must never be committed
- All code must pass security scans before merge

## 🤝 Contributing to Security

Help improve security:
1. Review security alerts and propose fixes
2. Add CodeQL queries for new vulnerability patterns
3. Improve documentation and examples
4. Report security issues responsibly via private disclosure

---

**Questions?** Check the [GitHub Community Discussions](https://github.com/orgs/community/discussions/categories/code-security) or open an issue.
