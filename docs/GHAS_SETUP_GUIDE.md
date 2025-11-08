# GitHub Advanced Security Setup Guide

Step-by-step instructions to enable and configure all GHAS features in this repository.

## Prerequisites

- Repository must have GitHub Advanced Security enabled (available for GitHub Enterprise or public repositories)
- Admin access to repository settings
- GitHub CLI installed (optional, for automation)

## Step 1: Enable GitHub Advanced Security

### For Organization Owners:
1. Navigate to **Organization Settings** → **Code security and analysis**
2. Enable **GitHub Advanced Security** for all repositories or select repositories
3. Choose billing settings if using private repositories

### For Repository Admins:
1. Go to **Repository Settings** → **Code security and analysis**
2. Click **Enable** for GitHub Advanced Security
3. Confirm the action

## Step 2: Enable Code Scanning with CodeQL

### Automated Setup (Recommended):
1. Go to **Security** tab → **Code scanning**
2. Click **Set up code scanning**
3. Choose **CodeQL Analysis** → **Configure**
4. GitHub will create `.github/workflows/codeql.yml`
5. Review and commit the workflow file

### Manual Setup:
The CodeQL workflow is already configured in this repository:
- File: `.github/workflows/codeql.yml`
- Runs on: Push to main/develop, Pull requests, Weekly schedule
- Languages: C#

**What it does:**
```yaml
✅ Scans code for 200+ security vulnerability types
✅ Uses security-extended query suite
✅ Comments on PRs with findings
✅ Uploads results to Security tab
✅ Integrates with branch protection
```

**Verify it's working:**
```bash
# Check workflow runs
gh run list --workflow=codeql.yml

# View latest results
gh api repos/:owner/:repo/code-scanning/alerts
```

## Step 3: Enable Secret Scanning

### Enable Secret Scanning:
1. Go to **Settings** → **Code security and analysis**
2. Under **Secret scanning**, click **Enable**
3. Review any detected secrets immediately

### Enable Push Protection:
1. In the same section, click **Enable** for **Push protection**
2. This prevents secrets from being committed

**What it detects:**
- AWS, Azure, GCP credentials
- GitHub tokens
- Database connection strings
- API keys from 200+ partners
- Private keys and certificates

**Test it:**
```bash
# Try to commit a test secret (will be blocked):
echo "AWS_KEY=AKIAIOSFODNN7EXAMPLE" >> test.txt
git add test.txt
git commit -m "test"
# ❌ Push will be blocked with explanation
```

### Configure Custom Patterns (Optional):
1. Go to **Settings** → **Code security** → **Secret scanning**
2. Click **New pattern**
3. Add custom regex for internal secrets

Example custom pattern:
```regex
Pattern: INTERNAL_API_[0-9A-Za-z]{32}
```

## Step 4: Enable Dependency Scanning

### Enable Dependabot Alerts:
1. Go to **Settings** → **Code security and analysis**
2. Enable **Dependency graph** (usually enabled by default)
3. Enable **Dependabot alerts**
4. Enable **Dependabot security updates**

### Configure Dependabot Updates:
The configuration is already in `.github/dependabot.yml`:

```yaml
✅ Weekly updates for NuGet packages
✅ Weekly updates for GitHub Actions
✅ Automatic PR creation
✅ Grouped updates for related packages
✅ Auto-assignment to maintainers
```

**Verify it's working:**
```bash
# Check for security advisories
gh api repos/:owner/:repo/vulnerability-alerts

# List Dependabot PRs
gh pr list --label dependencies
```

## Step 5: Enable Dependency Review

The workflow is configured in `.github/workflows/dependency-review.yml`:

**What it does:**
```yaml
✅ Scans dependency changes in PRs
✅ Blocks high/critical vulnerabilities
✅ Checks license compatibility
✅ Comments on PRs with findings
✅ Uploads SARIF results
```

**Allowed licenses:**
- MIT
- Apache-2.0
- BSD-2-Clause, BSD-3-Clause
- ISC

**Blocked licenses:**
- GPL-3.0
- LGPL-2.0
- AGPL-3.0

**Test it:**
1. Create a branch
2. Downgrade a package to a vulnerable version
3. Open a PR
4. See the dependency review check fail with details

## Step 6: Configure Branch Protection

Add security requirements to branch protection rules:

1. Go to **Settings** → **Branches** → **Add rule**
2. Branch name pattern: `main`
3. Enable:
   - ✅ Require status checks to pass
   - ✅ Select: CodeQL, Dependency Review, Build
   - ✅ Require approval from code owners
   - ✅ Require conversation resolution
4. Save changes

**Recommended settings:**
```yaml
Branch: main
└── Require status checks:
    ├── CodeQL Analysis (csharp)
    ├── Dependency Review
    ├── Build on ubuntu-latest
    └── Build on windows-latest
```

## Step 7: Configure Code Owners

Create `.github/CODEOWNERS` for security-sensitive files:

```
# Security-sensitive files require security team review
/.github/workflows/          @isaacrlevin @security-team
/src/**/Security/            @isaacrlevin @security-team
SECURITY.md                  @isaacrlevin
*.key                        @isaacrlevin @security-team
*.pem                        @isaacrlevin @security-team
```

## Step 8: Set Up Notifications

### Email Notifications:
1. Go to **Settings** → **Notifications**
2. Enable notifications for:
   - Security alerts
   - Dependabot alerts
   - Code scanning alerts

### Slack Integration (Optional):
1. Install GitHub app in Slack workspace
2. Subscribe to security alerts:
   ```
   /github subscribe owner/repo security-alerts
   ```

### Custom Webhooks (Optional):
1. Go to **Settings** → **Webhooks** → **Add webhook**
2. Set payload URL to your service
3. Select events:
   - Security advisory
   - Code scanning alert
   - Secret scanning alert

## Step 9: Review Existing Findings

### Code Scanning Alerts:
```bash
# List all alerts
gh api repos/:owner/:repo/code-scanning/alerts

# Filter by severity
gh api repos/:owner/:repo/code-scanning/alerts?severity=high

# View specific alert
gh api repos/:owner/:repo/code-scanning/alerts/{alert_number}
```

### Secret Scanning Alerts:
```bash
# List secret alerts
gh api repos/:owner/:repo/secret-scanning/alerts

# Close false positive
gh api repos/:owner/:repo/secret-scanning/alerts/{alert_number} \
  -X PATCH -f state=resolved -f resolution=false_positive
```

### Dependabot Alerts:
```bash
# List vulnerability alerts
gh api repos/:owner/:repo/vulnerability-alerts

# View Dependabot PRs
gh pr list --label dependencies --state open
```

## Step 10: Triage and Remediate

### Priority Order:
1. **Critical/High severity secrets** - Rotate immediately
2. **Critical/High code scanning** - Fix in current sprint
3. **Critical/High dependencies** - Update ASAP
4. **Medium severity** - Plan for next sprint
5. **Low severity** - Backlog

### Remediation Workflow:
```bash
# 1. Create fix branch
git checkout -b fix/security-issue-123

# 2. Fix the vulnerability
# (Refer to the alert for guidance)

# 3. Commit and push
git commit -m "fix: resolve SQL injection in recipe search"
git push origin fix/security-issue-123

# 4. Open PR
gh pr create --title "Fix: SQL injection vulnerability" \
  --body "Fixes code scanning alert #123"

# 5. Alert will auto-close when merged
```

## Step 11: Monitor and Maintain

### Weekly Tasks:
- [ ] Review new security alerts
- [ ] Merge Dependabot PRs
- [ ] Check CodeQL workflow runs
- [ ] Review secret scanning findings

### Monthly Tasks:
- [ ] Audit security posture
- [ ] Update security policies
- [ ] Review custom CodeQL queries
- [ ] Train team on new threats

### Quarterly Tasks:
- [ ] Full security audit
- [ ] Update branch protection rules
- [ ] Review and update SECURITY.md
- [ ] Conduct security retrospective

## Metrics to Track

Monitor these metrics in **Insights** → **Security**:

1. **Mean Time to Remediation (MTTR)**
   - Target: < 7 days for critical, < 30 days for high

2. **Alert Trends**
   - Track: New vs. fixed alerts over time
   - Goal: Decreasing trend

3. **Coverage**
   - Code scanning: 100% of code
   - Dependency scanning: All manifests

4. **False Positive Rate**
   - Target: < 10%
   - Refine queries if higher

## Troubleshooting

### CodeQL not running:
```bash
# Check workflow permissions
gh api repos/:owner/:repo/actions/permissions

# Re-run failed workflow
gh run rerun <run-id>

# View logs
gh run view <run-id> --log
```

### Secret scanning not detecting:
- Verify push protection is enabled
- Check if pattern is supported
- Add custom pattern if needed

### Dependabot not creating PRs:
```bash
# Trigger manual update
gh api repos/:owner/:repo/dependabot/updates -X POST

# Check Dependabot logs in Security tab
```

## Advanced Configuration

### Custom CodeQL Queries:
Create `.github/codeql/custom-queries.ql`:
```ql
import csharp

from MethodCall call
where call.getTarget().hasName("ExecuteSql")
  and not call.getAnArgument().toString().matches("@%")
select call, "Potential SQL injection"
```

### SARIF Upload:
```yaml
- name: Upload SARIF
  uses: github/codeql-action/upload-sarif@v4
  with:
    sarif_file: results.sarif
    category: custom-analysis
```

### Security Scorecard:
```bash
# Install scorecard
go install github.com/ossf/scorecard/v4/cmd/scorecard@latest

# Run scorecard
scorecard --repo=github.com/:owner/:repo
```

## Resources

- [GHAS Documentation](https://docs.github.com/en/code-security)
- [CodeQL Query Docs](https://codeql.github.com/docs/)
- [Security Best Practices](https://github.com/ossf/scorecard)
- [Sample Queries](https://github.com/github/codeql)

## Support

- GitHub Support: https://support.github.com
- Community Forum: https://github.com/community
- Security Lab: https://securitylab.github.com

---

**Next Steps:**
1. ✅ Complete this setup checklist
2. 📊 Review your first security findings
3. 🔧 Fix high-priority issues
4. 📚 Train your team on GHAS features
5. 🔄 Integrate security into your workflow
