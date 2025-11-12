# GitHub Advanced Security Health Check Script
# Checks the status of GHAS features and provides recommendations

param(
    [string]$repo = "isaacrlevin/GitHubTips"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  GitHub Advanced Security Health Check" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Repository: $repo" -ForegroundColor White
Write-Host ""

# Check if GitHub CLI is installed
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: GitHub CLI is not installed" -ForegroundColor Red
    Write-Host "Install from: https://cli.github.com/" -ForegroundColor Yellow
    exit 1
}

# Check authentication
gh auth status 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Not authenticated with GitHub CLI" -ForegroundColor Red
    Write-Host "Run: gh auth login" -ForegroundColor Yellow
    exit 1
}

Write-Host "GitHub CLI authenticated" -ForegroundColor Green
Write-Host ""

# Function to check feature status
function Test-FeatureStatus {
    param(
        [string]$FeatureName,
        [string]$ApiPath,
        [string]$JsonPath
    )

    Write-Host "Checking $FeatureName..." -NoNewline

    try {
        $result = gh api $ApiPath 2>&1 | ConvertFrom-Json

        # Navigate nested properties
        $pathParts = $JsonPath -split '\.'
        $value = $result
        foreach ($part in $pathParts) {
            $value = $value.$part
            if ($null -eq $value) {
                Write-Host " NOT AVAILABLE" -ForegroundColor Yellow
                return $false
            }
        }

        if ($value -eq "enabled") {
            Write-Host " ENABLED" -ForegroundColor Green
            return $true
        }
        else {
            Write-Host " DISABLED" -ForegroundColor Red
            return $false
        }
    }
    catch {
        Write-Host " ERROR" -ForegroundColor Red
        return $false
    }
}

# Check repository features
Write-Host "Repository Security Features:" -ForegroundColor Yellow
Write-Host "-----------------------------" -ForegroundColor Yellow

$advancedSecurityEnabled = Test-FeatureStatus `
    -FeatureName "Advanced Security" `
    -ApiPath "repos/$repo" `
    -JsonPath "security_and_analysis.advanced_security.status"

$secretScanningEnabled = Test-FeatureStatus `
    -FeatureName "Secret Scanning" `
    -ApiPath "repos/$repo" `
    -JsonPath "security_and_analysis.secret_scanning.status"

$pushProtectionEnabled = Test-FeatureStatus `
    -FeatureName "Push Protection" `
    -ApiPath "repos/$repo" `
    -JsonPath "security_and_analysis.secret_scanning_push_protection.status"

$dependabotAlertsEnabled = Test-FeatureStatus `
    -FeatureName "Dependabot Alerts" `
    -ApiPath "repos/$repo" `
    -JsonPath "security_and_analysis.dependabot_security_updates.status"

Write-Host ""

# Check for workflow files
Write-Host "Security Workflows:" -ForegroundColor Yellow
Write-Host "------------------" -ForegroundColor Yellow

$workflows = @("codeql.yml", "dependency-review.yml")
foreach ($workflow in $workflows) {
    $path = ".github/workflows/$workflow"
    if (Test-Path $path) {
        Write-Host "$workflow exists" -ForegroundColor Green
    }
    else {
        Write-Host "$workflow missing" -ForegroundColor Red
    }
}

Write-Host ""

# Check for security alerts
Write-Host "Active Security Alerts:" -ForegroundColor Yellow
Write-Host "----------------------" -ForegroundColor Yellow

# Code Scanning Alerts
try {
    $codeAlerts = gh api "repos/$repo/code-scanning/alerts?state=open" 2>&1 | ConvertFrom-Json
    $criticalCode = ($codeAlerts | Where-Object { $_.rule.severity -eq "error" }).Count
    $highCode = ($codeAlerts | Where-Object { $_.rule.severity -eq "warning" }).Count
    $totalCode = $codeAlerts.Count

    if ($totalCode -gt 0) {
        $alertColor = if ($criticalCode -gt 0) { "Red" } else { "Yellow" }
        Write-Host "Code Scanning: $totalCode open, $criticalCode critical, $highCode high" -ForegroundColor $alertColor
    }
    else {
        Write-Host "Code Scanning: No open alerts" -ForegroundColor Green
    }
}
catch {
    Write-Host "Code Scanning: Not available or no access" -ForegroundColor Gray
}

# Secret Scanning Alerts
try {
    $secretAlerts = gh api "repos/$repo/secret-scanning/alerts?state=open" 2>&1 | ConvertFrom-Json
    $totalSecrets = $secretAlerts.Count

    if ($totalSecrets -gt 0) {
        Write-Host "Secret Scanning: $totalSecrets exposed secrets" -ForegroundColor Red
    }
    else {
        Write-Host "Secret Scanning: No exposed secrets" -ForegroundColor Green
    }
}
catch {
    Write-Host "Secret Scanning: Not available or no access" -ForegroundColor Gray
}

# Dependabot Alerts
try {
    $dependabotAlerts = gh api "repos/$repo/dependabot/alerts?state=open" 2>&1 | ConvertFrom-Json
    $criticalDeps = ($dependabotAlerts | Where-Object { $_.security_advisory.severity -eq "critical" }).Count
    $highDeps = ($dependabotAlerts | Where-Object { $_.security_advisory.severity -eq "high" }).Count
    $totalDeps = $dependabotAlerts.Count

    if ($totalDeps -gt 0) {
        $depColor = if ($criticalDeps -gt 0) { "Red" } else { "Yellow" }
        Write-Host "Dependabot: $totalDeps vulnerable dependencies, $criticalDeps critical, $highDeps high" -ForegroundColor $depColor
    }
    else {
        Write-Host "Dependabot: No vulnerable dependencies" -ForegroundColor Green
    }
}
catch {
    Write-Host "Dependabot: Not available or no access" -ForegroundColor Gray
}

Write-Host ""

# Generate recommendations
Write-Host "Recommendations:" -ForegroundColor Yellow
Write-Host "----------------" -ForegroundColor Yellow

$recommendations = @()

if (-not $advancedSecurityEnabled) {
    $recommendations += "Enable GitHub Advanced Security in Settings -> Code security"
}

if (-not $secretScanningEnabled) {
    $recommendations += "Enable Secret Scanning in Settings -> Code security"
}

if (-not $pushProtectionEnabled) {
    $recommendations += "Enable Push Protection to prevent secret commits"
}

if (-not $dependabotAlertsEnabled) {
    $recommendations += "Enable Dependabot security updates"
}

if (-not (Test-Path ".github/workflows/codeql.yml")) {
    $recommendations += "Set up CodeQL workflow for code scanning"
}

if (-not (Test-Path ".github/workflows/dependency-review.yml")) {
    $recommendations += "Add Dependency Review workflow"
}

if (-not (Test-Path ".github/dependabot.yml")) {
    $recommendations += "Configure Dependabot with dependabot.yml"
}

if ($recommendations.Count -eq 0) {
    Write-Host "All GHAS features are properly configured!" -ForegroundColor Green
}
else {
    foreach ($rec in $recommendations) {
        Write-Host "- $rec" -ForegroundColor Yellow
    }
}

Write-Host ""

# Check recent workflow runs
Write-Host "Recent Security Workflow Runs:" -ForegroundColor Yellow
Write-Host "-----------------------------" -ForegroundColor Yellow

try {
    $runs = gh run list --workflow=codeql.yml --limit 5 --json conclusion,createdAt,displayTitle 2>&1 | ConvertFrom-Json

    foreach ($run in $runs) {
        $status = if ($run.conclusion -eq "success") { "[SUCCESS]" } else { "[FAILED]" }
        $color = if ($run.conclusion -eq "success") { "Green" } else { "Red" }
        $date = [DateTime]::Parse($run.createdAt).ToString("yyyy-MM-dd HH:mm")

        Write-Host "$status $date - $($run.displayTitle)" -ForegroundColor $color
    }
}
catch {
    Write-Host "No recent CodeQL runs found" -ForegroundColor Gray
}

Write-Host ""

# Security Score
Write-Host "Security Score:" -ForegroundColor Yellow
Write-Host "--------------" -ForegroundColor Yellow

$score = 0
$maxScore = 7

if ($advancedSecurityEnabled) { $score++ }
if ($secretScanningEnabled) { $score++ }
if ($pushProtectionEnabled) { $score++ }
if ($dependabotAlertsEnabled) { $score++ }
if (Test-Path ".github/workflows/codeql.yml") { $score++ }
if (Test-Path ".github/workflows/dependency-review.yml") { $score++ }
if (Test-Path ".github/dependabot.yml") { $score++ }

$percentage = [math]::Round(($score / $maxScore) * 100)
$color = if ($percentage -ge 80) { "Green" } elseif ($percentage -ge 50) { "Yellow" } else { "Red" }

Write-Host "$score / $maxScore features enabled ($percentage%)" -ForegroundColor $color

if ($percentage -ge 90) {
    $grade = "A+"
}
elseif ($percentage -ge 80) {
    $grade = "A"
}
elseif ($percentage -ge 70) {
    $grade = "B"
}
elseif ($percentage -ge 60) {
    $grade = "C"
}
elseif ($percentage -ge 50) {
    $grade = "D"
}
else {
    $grade = "F"
}

Write-Host "Grade: $grade" -ForegroundColor $color

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Provide next steps
if ($percentage -lt 100) {
    Write-Host "Next Steps:" -ForegroundColor Cyan
    Write-Host "1. Review recommendations above" -ForegroundColor White
    Write-Host "2. Read the setup guide: docs/GHAS_SETUP_GUIDE.md" -ForegroundColor White
    Write-Host "3. Enable missing features" -ForegroundColor White
    Write-Host "4. Run this script again to verify" -ForegroundColor White
}
else {
    Write-Host "Excellent! Your repository has comprehensive security coverage." -ForegroundColor Green
    Write-Host "Keep monitoring alerts and keeping dependencies updated." -ForegroundColor Green
}

Write-Host ""
Write-Host "For detailed information, visit:" -ForegroundColor Cyan
Write-Host "https://github.com/$repo/security" -ForegroundColor White
Write-Host ""
