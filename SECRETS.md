# Secrets & Configuration Management

This guide explains how to manage sensitive data and configuration in the Meal Planner application.

## Table of Contents
- [Local Development](#local-development)
- [Configuration Files](#configuration-files)
- [User Secrets](#user-secrets)
- [Environment Variables](#environment-variables)
- [Production Deployment](#production-deployment)
- [Best Practices](#best-practices)

## Local Development

### Current Configuration (v0.1.0)

The application currently uses SQLite with minimal configuration requirements. No sensitive secrets are needed for local development.

### Configuration Files

#### `appsettings.json`
**Location**: `src/MealPlannerApi/appsettings.json`

**Purpose**: Shared configuration for all environments
- Non-sensitive settings
- Default logging levels
- CORS configuration
- Committed to repository

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "AllowedHosts": "*"
}
```

#### `appsettings.Development.json`
**Location**: `src/MealPlannerApi/appsettings.Development.json`

**Purpose**: Development-specific overrides
- Local database connection strings
- Verbose logging
- Development-only features
- **Committed to repository** (currently safe)

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Debug",
      "Microsoft.AspNetCore": "Information"
    }
  },
  "ConnectionStrings": {
    "DefaultConnection": "Data Source=mealplanner.db"
  }
}
```

⚠️ **Warning**: If you add sensitive data (API keys, passwords), move to user secrets!

## User Secrets

### What are User Secrets?

User Secrets is a secure way to store sensitive data during development. Secrets are stored **outside your project directory** and never committed to source control.

### When to Use User Secrets

Use User Secrets when you add:
- API keys (OpenAI, Azure, third-party services)
- Connection strings with passwords
- OAuth client secrets
- Email service credentials
- Any other sensitive data

### Setting Up User Secrets

#### 1. Initialize User Secrets
```bash
cd src/MealPlannerApi
dotnet user-secrets init
```

This adds a `UserSecretsId` to your `.csproj` file:
```xml
<PropertyGroup>
  <UserSecretsId>unique-guid-here</UserSecretsId>
</PropertyGroup>
```

#### 2. Add Secrets
```bash
# Individual secrets
dotnet user-secrets set "OpenAI:ApiKey" "sk-your-key-here"
dotnet user-secrets set "ConnectionStrings:Production" "Server=..."

# From JSON file
dotnet user-secrets set --json @secrets.json
```

#### 3. List Secrets
```bash
dotnet user-secrets list
```

#### 4. Remove Secrets
```bash
# Remove specific secret
dotnet user-secrets remove "OpenAI:ApiKey"

# Clear all secrets
dotnet user-secrets clear
```

### Accessing User Secrets in Code

User Secrets are automatically loaded in Development environment:

```csharp
// In Program.cs or Startup.cs
var apiKey = builder.Configuration["OpenAI:ApiKey"];
var connectionString = builder.Configuration.GetConnectionString("Production");
```

### Storage Location

**Windows**: `%APPDATA%\Microsoft\UserSecrets\<user_secrets_id>\secrets.json`
**macOS/Linux**: `~/.microsoft/usersecrets/<user_secrets_id>/secrets.json`

### Example `secrets.json`
```json
{
  "OpenAI": {
    "ApiKey": "sk-your-api-key",
    "Organization": "org-your-org-id"
  },
  "Email": {
    "ApiKey": "sendgrid-api-key",
    "FromAddress": "noreply@mealplanner.com"
  },
  "ConnectionStrings": {
    "Production": "Server=prod-server;Database=MealPlanner;..."
  }
}
```

## Environment Variables

### Local Development

Set environment variables for runtime configuration:

#### Windows (PowerShell)
```powershell
$env:ASPNETCORE_ENVIRONMENT="Development"
$env:OpenAI__ApiKey="sk-your-key"
dotnet run
```

#### macOS/Linux (Bash)
```bash
export ASPNETCORE_ENVIRONMENT=Development
export OpenAI__ApiKey=sk-your-key
dotnet run
```

### VS Code Launch Configuration

Add environment variables to `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": ".NET Core Launch (API)",
      "type": "coreclr",
      "request": "launch",
      "preLaunchTask": "build",
      "program": "${workspaceFolder}/src/MealPlannerApi/bin/Debug/net9.0/MealPlannerApi.dll",
      "args": [],
      "cwd": "${workspaceFolder}/src/MealPlannerApi",
      "env": {
        "ASPNETCORE_ENVIRONMENT": "Development",
        "OpenAI__ApiKey": "${env:OPENAI_API_KEY}"
      }
    }
  ]
}
```

## Production Deployment

### Cloud Provider Secret Management

#### Azure
- **Azure Key Vault**: Recommended for production secrets
- **Azure App Service**: Application Settings (encrypted at rest)
- **Managed Identity**: Access Key Vault without credentials

```csharp
// Add to Program.cs for Azure Key Vault
builder.Configuration.AddAzureKeyVault(
    new Uri($"https://{keyVaultName}.vault.azure.net/"),
    new DefaultAzureCredential());
```

#### AWS
- **AWS Secrets Manager**: Store and rotate secrets
- **Systems Manager Parameter Store**: Configuration values
- **IAM Roles**: Access secrets without keys

#### GitHub Actions
Store secrets in repository settings:
1. Go to repository Settings → Secrets and variables → Actions
2. Add secrets (e.g., `AZURE_WEBAPP_PUBLISH_PROFILE`)
3. Reference in workflows:

```yaml
- name: Deploy
  env:
    AZURE_WEBAPP_PUBLISH_PROFILE: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}
    OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
```

### Environment-Specific Configuration

Create environment-specific settings files:

- `appsettings.json` (base)
- `appsettings.Development.json` (local dev)
- `appsettings.Staging.json` (staging environment)
- `appsettings.Production.json` (production)

**Important**: Only commit non-sensitive files!

## Best Practices

### ✅ Do's

1. **Never commit secrets** to source control
   - Use `.gitignore` to exclude sensitive files
   - Review changes before committing

2. **Use User Secrets** for local development
   - Easy to manage
   - Automatically excluded from commits

3. **Use Environment Variables** for deployments
   - Cloud-native
   - Easy to rotate

4. **Use Key Vaults** for production
   - Centralized management
   - Audit logging
   - Automatic rotation

5. **Rotate secrets regularly**
   - API keys every 90 days
   - Database passwords quarterly

6. **Limit secret access**
   - Principle of least privilege
   - Use different keys per environment

7. **Document required secrets**
   - Create `secrets.template.json` example
   - List in CONTRIBUTING.md

8. **Use connection string builders**
   ```csharp
   var builder = new SqlConnectionStringBuilder
   {
       DataSource = config["Database:Server"],
       InitialCatalog = config["Database:Name"],
       UserID = config["Database:User"],
       Password = config["Database:Password"]
   };
   ```

### ❌ Don'ts

1. **Don't hardcode secrets** in code
   ```csharp
   // ❌ BAD
   var apiKey = "sk-123456789";

   // ✅ GOOD
   var apiKey = configuration["OpenAI:ApiKey"];
   ```

2. **Don't commit** configuration files with secrets
   - `appsettings.Production.json` (if contains secrets)
   - `secrets.json`
   - `.env` files

3. **Don't share secrets** via:
   - Email
   - Slack/Teams
   - GitHub issues/discussions
   - Commit messages

4. **Don't use same secrets** across environments
   - Use different keys for dev/staging/prod
   - Limit blast radius of compromised secrets

5. **Don't store secrets** in:
   - Session storage
   - Local storage
   - Client-side code
   - Logs

## Configuration Priority

ASP.NET Core loads configuration in this order (later overrides earlier):

1. `appsettings.json`
2. `appsettings.{Environment}.json`
3. User Secrets (Development only)
4. Environment variables
5. Command-line arguments

## Future Enhancements (v0.2.0+)

When implementing authentication and third-party services:

### User Authentication
```json
{
  "Authentication": {
    "JwtKey": "<use-user-secrets>",
    "JwtIssuer": "MealPlanner",
    "JwtAudience": "MealPlannerUsers",
    "ExpirationMinutes": 60
  }
}
```

### Email Service
```json
{
  "Email": {
    "Provider": "SendGrid",
    "ApiKey": "<use-user-secrets>",
    "FromAddress": "noreply@mealplanner.com",
    "FromName": "Meal Planner"
  }
}
```

### OpenAI Integration
```json
{
  "OpenAI": {
    "ApiKey": "<use-user-secrets>",
    "Model": "gpt-4",
    "MaxTokens": 500
  }
}
```

## Template for New Secrets

Create `secrets.template.json` in documentation:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "YOUR_CONNECTION_STRING_HERE"
  },
  "Authentication": {
    "JwtKey": "YOUR_JWT_SECRET_KEY_HERE"
  },
  "OpenAI": {
    "ApiKey": "sk-YOUR_OPENAI_API_KEY",
    "Organization": "org-YOUR_ORGANIZATION_ID"
  },
  "Email": {
    "ApiKey": "YOUR_EMAIL_API_KEY",
    "FromAddress": "your-email@example.com"
  }
}
```

## Getting Help

- Security issues: See [SECURITY.md](SECURITY.md)
- Questions: [GitHub Discussions](https://github.com/isaacrlevin/MealPlanner/discussions)
- Configuration issues: Open an issue

## Additional Resources

- [ASP.NET Core Configuration](https://docs.microsoft.com/aspnet/core/fundamentals/configuration/)
- [User Secrets](https://docs.microsoft.com/aspnet/core/security/app-secrets)
- [Azure Key Vault](https://docs.microsoft.com/azure/key-vault/)
- [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/)

---

**Remember**: When in doubt, use User Secrets or environment variables. Never commit secrets! 🔒
