# GitHub Advanced Security Demo Script

A step-by-step guide for demonstrating GHAS capabilities to stakeholders.

## 🎯 Demo Objectives

By the end of this demo, viewers will understand:
1. What GitHub Advanced Security provides
2. How it prevents security vulnerabilities
3. How it fits into the development workflow
4. The value it brings to the organization

**Duration**: 20-30 minutes
**Audience**: Developers, Security teams, Leadership

---

## 📋 Pre-Demo Checklist

- [ ] Repository with GHAS enabled
- [ ] CodeQL workflow running
- [ ] Some example alerts present (use VulnerableCodeExamples.cs)
- [ ] Browser tabs open:
  - Repository main page
  - Security tab
  - Pull request with security checks
  - Settings → Code security
- [ ] Terminal ready with GitHub CLI authenticated
- [ ] Screen sharing tested

---

## Part 1: Introduction (3 minutes)

### Talking Points:

**"Today I'll show you how GitHub Advanced Security helps us ship secure code faster."**

**The Challenge:**
- Security vulnerabilities cost companies $millions
- Traditional security tools run too late (after deployment)
- Manual security reviews slow down development
- Secrets getting committed is a common problem

**The Solution:**
- Shift security left - catch issues during development
- Automated scanning integrated into GitHub workflow
- Actionable alerts with remediation guidance
- Prevention before problems reach production

### Show: Repository Overview

1. Navigate to repository main page
2. Point out security badge in README
3. Click **Security** tab to show dashboard

**Script:**
> "This is our meal planning application. Notice the security indicators in our README showing CodeQL is running. Let's dive into the Security tab..."

---

## Part 2: Code Scanning with CodeQL (8 minutes)

### Demo: Finding Vulnerabilities

1. Click **Code scanning** in Security tab
2. Show list of alerts (use the VulnerableCodeExamples.cs alerts)
3. Click on a **SQL Injection** alert

**Script:**
> "CodeQL automatically scans every push and pull request. Here we see it found a SQL injection vulnerability. Let's look at the details..."

### Walkthrough of an Alert:

Point out these elements:
- **Severity** (Critical/High/Medium/Low)
- **Description** of the vulnerability
- **Location** in code with line numbers
- **Data flow** visualization
- **Recommendation** for fixing
- **CWE/CVE** references

**Script:**
> "Notice how CodeQL shows us exactly where the vulnerability is, explains what could happen if exploited, and provides guidance on how to fix it. The data flow visualization shows how user input could flow into a dangerous sink."

### Demo: The Fix

1. Open the vulnerable file in editor
2. Show the vulnerable code (string concatenation in SQL)
3. Show the secure version (parameterized query)
4. Explain the difference

**Script:**
> "The fix is straightforward - use parameterized queries instead of string concatenation. Once we merge this fix, CodeQL will automatically close the alert."

### Demo: Pull Request Integration

1. Open a PR with security findings
2. Show the CodeQL check in the status checks
3. Show how it blocks merging if configured
4. Show the security comment posted by the bot

**Script:**
> "Security checks run automatically on every PR. If CodeQL finds a critical vulnerability, we can configure branch protection to block the merge. This prevents vulnerable code from reaching main."

---

## Part 3: Secret Scanning (5 minutes)

### Demo: Preventing Secret Leaks

1. Go to **Security → Secret scanning**
2. Show any alerts (or explain what would be shown)
3. Go to **Settings → Code security**
4. Point out **Push protection** is enabled

**Script:**
> "Secret scanning prevents credentials from being committed. It scans for over 200 types of tokens and keys from AWS, Azure, GitHub, and many partners."

### Live Demo: Push Protection

**Option A** (if you can demo):
```bash
# Try to commit a test secret
echo "AWS_KEY=AKIAIOSFODNN7EXAMPLE" >> test.txt
git add test.txt
git commit -m "test"
# Shows the push protection error
```

**Option B** (screenshots):
- Show screenshot of push protection blocking a commit
- Show the detailed warning message
- Show how to resolve it

**Script:**
> "Watch what happens when someone tries to commit a secret. Push protection blocks it immediately with a clear message explaining the issue. The developer can remove the secret and commit safely."

### Demo: Partner Program

**Script:**
> "When secrets are detected, GitHub notifies the service provider through the Secret Scanning Partner Program. For example, if an AWS key is found, AWS is notified and can automatically revoke it. This limits the exposure window."

---

## Part 4: Dependency Management (7 minutes)

### Demo: Dependabot Alerts

1. Navigate to **Security → Dependabot**
2. Show vulnerable dependencies
3. Click on a **Critical** or **High** severity alert
4. Show the CVE details, CVSS score, and patch availability

**Script:**
> "Dependabot continuously monitors our dependencies for known vulnerabilities. Here's a critical vulnerability in one of our packages. Let's look at the details..."

Point out:
- **CVE number** and description
- **CVSS score** and severity
- **Affected versions** and patch version
- **Impact** and exploitation details

### Demo: Automated Updates

1. Go to **Pull Requests** tab
2. Filter by label: `dependencies`
3. Show a Dependabot-created PR
4. Open the PR to show:
   - Automatic version bump
   - Changelog included
   - Compatibility score
   - CI checks running

**Script:**
> "Dependabot doesn't just alert us - it automatically creates PRs to fix vulnerabilities. This PR updates the package to a secure version. Notice the changelog and release notes are included. Our CI tests run automatically to verify compatibility."

### Demo: Dependency Review in PRs

1. Open a PR that adds or updates dependencies
2. Show the **Dependency Review** workflow check
3. Click **Details** to see the dependency changes
4. Show how it would fail for vulnerable packages

**Script:**
> "Dependency Review runs on every PR that changes dependencies. It checks for vulnerabilities, license compliance, and security advisories. If someone tries to add a vulnerable package, the check fails and blocks the merge."

---

## Part 5: The Developer Experience (4 minutes)

### Demo: Typical Workflow

Walk through a developer's day:

**Morning:**
```bash
# Developer starts work
git checkout -b feature/new-recipe-search

# Write some code...
# Run tests locally
dotnet test
```

**Create PR:**
1. Push code and open PR
2. Automated checks run:
   - ✓ Build
   - ✓ Tests
   - ✓ CodeQL
   - ✓ Dependency Review

**If security issues found:**
- Clear alerts in PR
- Specific guidance on fixes
- Can't merge until resolved (if branch protection enabled)

**Script:**
> "Security is seamlessly integrated into the workflow developers already use. They don't need to learn new tools or run separate scans. If there's a problem, they see it immediately in their PR with actionable guidance on how to fix it."

### Show: Security in IDE

If possible, show:
- CodeQL extension in VS Code
- Inline security annotations
- Quick fixes for common issues

---

## Part 6: Management & Reporting (3 minutes)

### Demo: Security Overview

1. Navigate to **Insights → Security**
2. Show metrics:
   - Open alerts by severity
   - Alert trends over time
   - Mean time to remediation
   - Coverage statistics

**Script:**
> "Management gets visibility into security posture through built-in dashboards. We can track trends, measure remediation time, and demonstrate improvement over time."

### Demo: Organization-Level View

If organization owner:
1. Go to Organization → Security
2. Show aggregated view across all repos
3. Filter by severity, status, team

**Script:**
> "At the organization level, security teams can see security across all repositories, prioritize remediation efforts, and identify patterns that need training or policy updates."

---

## Part 7: Value Proposition (2 minutes)

### Key Benefits Summary:

**For Developers:**
- ✅ Find and fix issues before code review
- ✅ Clear guidance on remediation
- ✅ Integrated into existing workflow
- ✅ No context switching

**For Security Teams:**
- ✅ Automated vulnerability detection
- ✅ Comprehensive coverage (code, secrets, dependencies)
- ✅ Metrics and trends
- ✅ Policy enforcement

**For Business:**
- ✅ Reduce security incidents
- ✅ Lower remediation costs
- ✅ Faster time to market
- ✅ Compliance and audit support

### ROI Example:

**Script:**
> "Let's talk about ROI. The average data breach costs $4.45 million. GitHub Advanced Security helps prevent breaches by catching vulnerabilities before deployment. If we prevent just one incident, the investment pays for itself many times over. Plus, developers spend less time on security remediation because issues are caught early when they're cheaper and easier to fix."

---

## Part 8: Q&A and Next Steps (3 minutes)

### Common Questions:

**Q: Does this slow down development?**
**A:** No, it actually speeds it up by catching issues early. Fixing a vulnerability in a PR takes minutes vs. hours/days in production.

**Q: What about false positives?**
**A:** CodeQL is highly accurate (~10% false positive rate). You can dismiss false positives and they won't reappear.

**Q: Can we customize the rules?**
**A:** Yes, you can add custom CodeQL queries, secret patterns, and dependency policies.

**Q: What languages are supported?**
**A:** CodeQL supports 20+ languages including C#, Java, JavaScript, Python, Go, and more.

**Q: How does this compare to other security tools?**
**A:** GHAS is integrated into the development workflow, provides actionable results, and covers multiple security domains (SAST, secrets, SCA) in one platform.

### Next Steps:

**For this repository:**
1. ✅ GHAS is enabled
2. ✅ Workflows are configured
3. 📝 Review and triage existing alerts
4. 📝 Configure branch protection rules
5. 📝 Train team on security best practices

**Resources:**
- 📖 [GHAS Documentation](docs/GITHUB_ADVANCED_SECURITY.md)
- 🚀 [Setup Guide](docs/GHAS_SETUP_GUIDE.md)
- 📋 [Quick Reference](docs/GHAS_QUICK_REFERENCE.md)
- 💻 Example code: `src/MealPlannerApi/Examples/VulnerableCodeExamples.cs`

---

## 🎬 Demo Tips

### Before the Demo:
- Practice the flow 2-3 times
- Have backup screenshots for live demo failures
- Test screen sharing and audio
- Close unnecessary browser tabs
- Disable notifications

### During the Demo:
- Speak slowly and clearly
- Pause after showing new concepts
- Use the cursor to point at important elements
- Encourage questions
- Watch the time

### After the Demo:
- Share documentation links
- Offer follow-up sessions
- Gather feedback
- Schedule enablement workshops

---

## 📊 Demo Variations

### Quick Demo (10 minutes):
- Part 1: Introduction (2 min)
- Part 2: CodeQL alert walkthrough (4 min)
- Part 3: Secret scanning overview (2 min)
- Part 7: Value proposition (2 min)

### Technical Deep Dive (45 minutes):
- Add: Custom CodeQL query development
- Add: SARIF upload and custom integrations
- Add: Security policies and governance
- Add: API and automation examples

### Executive Demo (15 minutes):
- Focus on: Business value and ROI
- Show: High-level metrics and trends
- Emphasize: Risk reduction and compliance
- Skip: Technical implementation details

---

**Good luck with your demo! 🚀**
