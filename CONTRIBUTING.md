# Contributing to Meal Planner

Thank you for your interest in contributing to Meal Planner! We welcome contributions from the community.

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue using the [Bug Report template](.github/ISSUE_TEMPLATE/bug_report.yml):
- Use a clear, descriptive title
- Describe the steps to reproduce the issue
- Include screenshots if applicable
- Note your environment (OS, .NET version, browser)

### Suggesting Features

We love new ideas! Use the [Feature Request template](.github/ISSUE_TEMPLATE/feature_request.yml):
- Describe the feature and its benefits
- Provide examples or mockups if possible
- Explain why this feature would be useful

### Pull Requests

1. **Fork the repository** and create a new branch from `main`
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow the existing code style
   - Add or update tests if applicable
   - Update documentation as needed

3. **Format your code**
   ```bash
   dotnet format
   ```

4. **Build and test locally**
   ```bash
   dotnet build
   dotnet test
   ```

5. **Commit your changes** with clear, descriptive messages
   ```bash
   git commit -m "feat: add recipe search functionality"
   ```

6. **Push to your fork** and create a pull request
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Fill out the PR template** with all required information

## Development Guidelines

### Code Style

- Use meaningful variable and method names
- Add XML documentation comments for public APIs
- Keep methods focused and concise
- Follow C# naming conventions (PascalCase for public members, camelCase for private)

### Commit Message Convention

We follow [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code refactoring
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks

### Branch Naming

- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation updates
- `refactor/` - Code refactoring

### Testing

- Write unit tests for new functionality
- Ensure all tests pass before submitting PR
- Aim for meaningful test coverage

### Documentation

- Update README.md if adding new features
- Add XML comments to public APIs
- Update ROADMAP.md if implementing planned features

## Development Setup

1. Install [.NET 9 SDK](https://dotnet.microsoft.com/download/dotnet/9.0)
2. Clone your fork
3. Open in Visual Studio Code or your preferred IDE
4. Run `dotnet restore` to install dependencies
5. Use VS Code tasks or run projects manually

## Project Structure

```
MealPlanner/
├── src/
│   ├── MealPlannerApi/      # ASP.NET Core API
│   ├── MealPlannerApp/      # Blazor WebAssembly UI
│   └── MealPlannerShared/   # Shared models
├── .github/                 # GitHub workflows and templates
├── .devcontainer/           # Dev container configuration
└── docs/                    # Documentation
```

## Code Review Process

1. All submissions require review
2. Reviewers will provide feedback within 48-72 hours
3. Address feedback and update your PR
4. Once approved, a maintainer will merge your PR

## Community

- Be respectful and constructive
- Help others learn and grow
- Ask questions if you're unsure
- Have fun and enjoy the process!

## Questions?

Feel free to:
- Open a [Discussion](https://github.com/isaacrlevin/MealPlanner/discussions)
- Ask in your PR or issue
- Reach out to maintainers

Thank you for contributing! 🎉
