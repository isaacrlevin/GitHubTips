# 🍽️ Meal Planner

[![.NET Build](https://github.com/isaacrlevin/MealPlanner/workflows/.NET%20Build/badge.svg)](https://github.com/isaacrlevin/MealPlanner/actions)
[![CodeQL](https://github.com/isaacrlevin/GitHubTips/workflows/CodeQL%20Security%20Analysis/badge.svg)](https://github.com/isaacrlevin/GitHubTips/actions/workflows/codeql.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://github.com/isaacrlevin/MealPlanner/releases)

A modern, full-stack meal planning application built with **Blazor WebAssembly** and **ASP.NET Core**. Plan your meals, manage ingredients, organize recipes, and streamline your weekly cooking with a beautiful, responsive UI.

> **🔒 Security First**: This repository showcases [GitHub Advanced Security](docs/GITHUB_ADVANCED_SECURITY.md) features including CodeQL analysis, secret scanning, and dependency review.

![Meal Planner Screenshot](docs/screenshot.png)

> **Note**: Replace `isaacrlevin` in badge URLs with your GitHub username.

## ✨ Features

### Current
- 📖 **Recipe Management** - Create, organize, and manage your favorite recipes
- 🧺 **Ingredient Tracking** - Maintain a digital pantry and grocery list
- 📅 **Meal Planning** - Schedule meals by date with easy-to-use interface
- 🎨 **Modern UI** - Beautiful gradient design with glassmorphism effects
- 💾 **SQLite Database** - Lightweight, file-based persistence
- 🔄 **RESTful API** - Clean separation between frontend and backend
- 📱 **Responsive Design** - Works seamlessly on desktop and mobile
- 🐳 **Dev Container Ready** - GitHub Codespaces compatible

### Planned (See [ROADMAP.md](ROADMAP.md))
- 🔐 User authentication and multi-user support
- 🤖 AI-powered meal recommendations
- 🔍 Advanced search and filtering
- 📊 Nutritional information tracking
- 🛒 Auto-generated shopping lists
- 📤 Export/import recipes
- 🌐 Recipe sharing and social features

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Blazor WebAssembly                      │
│                    (MealPlannerApp)                         │
│  Modern UI • Routing • Forms • State Management             │
└────────────────────┬────────────────────────────────────────┘
                     │ HTTP/JSON
                     ▼
┌─────────────────────────────────────────────────────────────┐
│                  ASP.NET Core Web API                       │
│                   (MealPlannerApi)                          │
│  Minimal APIs • CORS • EF Core • Dependency Injection       │
└────────────────────┬────────────────────────────────────────┘
                     │ Entity Framework Core
                     ▼
┌─────────────────────────────────────────────────────────────┐
│                      SQLite Database                        │
│            Recipes • Ingredients • MealPlans                │
└─────────────────────────────────────────────────────────────┘
```

### Project Structure
- **`src/MealPlannerApp/`** - Blazor WebAssembly client application
- **`src/MealPlannerApi/`** - ASP.NET Core Web API backend
- **`src/MealPlannerShared/`** - Shared models and contracts
- **`.github/`** - GitHub workflows, issue templates, and configurations
- **`.devcontainer/`** - Dev container configuration for Codespaces

## Endpoints (API)
- `GET /api/recipes` list recipes
- `POST /api/recipes` create recipe
- `GET /api/ingredients` list ingredients
- `POST /api/ingredients` create ingredient
- `GET /api/mealplans` list meal plans
- `POST /api/mealplans` create meal plan

## 🚀 Getting Started

### Prerequisites
- [.NET 9 SDK](https://dotnet.microsoft.com/download/dotnet/9.0)
- Any modern web browser
- (Optional) [Visual Studio Code](https://code.visualstudio.com/) with C# Dev Kit

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/isaacrlevin/MealPlanner.git
   cd MealPlanner
   ```

2. **Build the solution**
   ```bash
   dotnet build src/MealPlanner.sln
   ```

3. **Run the API** (in first terminal)
   ```bash
   dotnet run --project src/MealPlannerApi/MealPlannerApi.csproj
   ```
   API will be available at `http://localhost:5001`

4. **Run the Client** (in second terminal)
   ```bash
   dotnet run --project src/MealPlannerApp/MealPlannerApp.csproj
   ```
   App will be available at `http://localhost:5000`

5. **Open your browser** and navigate to `http://localhost:5000`

### Using VS Code Tasks

The project includes pre-configured tasks in `.vscode/tasks.json`:

- **Build All** - `Ctrl+Shift+B` or `Tasks: Run Build Task`
- **Run API** - `Tasks: Run Task` → `run-api`
- **Run Client** - `Tasks: Run Task` → `run-client`

## 🐳 Development Environments

### GitHub Codespaces
1. Click the "Code" button on the GitHub repository
2. Select "Codespaces" → "Create codespace on main"
3. Wait for the environment to initialize
4. Run the tasks as described above

### Local Dev Container
1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop)
2. Install the [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension
3. Open the repository in VS Code
4. Click "Reopen in Container" when prompted
5. Wait for the container to build and start

## 🛠️ Technology Stack

- **Frontend**: Blazor WebAssembly, Bootstrap 5, Custom CSS with modern effects
- **Backend**: ASP.NET Core 9 Minimal APIs
- **Database**: SQLite with Entity Framework Core
- **Styling**: CSS3 with glassmorphism, gradients, and animations
- **Icons**: Bootstrap Icons
- **Fonts**: Inter, Playfair Display (Google Fonts)

## 📚 API Documentation

### Recipes
- `GET /api/recipes` - List all recipes
- `POST /api/recipes` - Create a new recipe
- `DELETE /api/recipes/{id}` - Delete a recipe

### Ingredients
- `GET /api/ingredients` - List all ingredients
- `POST /api/ingredients` - Create a new ingredient
- `DELETE /api/ingredients/{id}` - Delete an ingredient

### Meal Plans
- `GET /api/mealplans` - List all meal plans
- `POST /api/mealplans` - Create a new meal plan

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details on:
- Code of conduct
- Development workflow
- Pull request process
- Coding standards

## 🔒 Security

This repository uses **GitHub Advanced Security** to maintain high security standards:

- **Code Scanning**: Automated CodeQL analysis detects security vulnerabilities
- **Secret Scanning**: Prevents credentials from being committed
- **Dependency Review**: Blocks vulnerable dependencies in pull requests
- **Dependabot**: Automated security updates for dependencies

**Learn more:**
- 📖 [GitHub Advanced Security Overview](docs/GITHUB_ADVANCED_SECURITY.md)
- 🚀 [GHAS Setup Guide](docs/GHAS_SETUP_GUIDE.md)
- 🔐 [Security Policy](SECURITY.md) - Report vulnerabilities
- 📝 [Example Vulnerable Code](src/MealPlannerApi/Examples/VulnerableCodeExamples.cs) - For CodeQL testing

## 📋 Roadmap

See [ROADMAP.md](ROADMAP.md) for planned features and future enhancements.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [Blazor](https://dotnet.microsoft.com/apps/aspnet/web-apps/blazor)
- UI inspired by modern design trends
- Icons by [Bootstrap Icons](https://icons.getbootstrap.com/)

## 📞 Support

- 📖 [Documentation](https://github.com/isaacrlevin/MealPlanner/wiki)
- 🐛 [Issue Tracker](https://github.com/isaacrlevin/MealPlanner/issues)
- 💬 [Discussions](https://github.com/isaacrlevin/MealPlanner/discussions)

---

Made with ❤️ by the MealPlanner team
