# GitHub Projects Setup Script
# This script creates labels, milestones, and issues for the Meal Planner project
# Prerequisites: GitHub CLI (gh) must be installed and authenticated

param(
    [string]$repo = "isaacrlevin/GitHubTips"
)

Write-Host "🚀 Setting up GitHub Projects for $repo" -ForegroundColor Cyan
Write-Host ""

# Check if GitHub CLI is installed
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "❌ GitHub CLI is not installed. Please install it from https://cli.github.com/" -ForegroundColor Red
    exit 1
}

# Check if authenticated
$authStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Not authenticated with GitHub CLI. Run: gh auth login" -ForegroundColor Red
    exit 1
}

Write-Host "✅ GitHub CLI is authenticated" -ForegroundColor Green
Write-Host ""

# Create Labels
Write-Host "📝 Creating labels..." -ForegroundColor Yellow

$labels = @(
    @{name="enhancement"; color="a2eeef"; description="New feature or request"},
    @{name="feature"; color="0e8a16"; description="New functionality"},
    @{name="bug"; color="d73a4a"; description="Something isn't working"},
    @{name="technical-debt"; color="f9d0c4"; description="Code quality improvements"},
    @{name="frontend"; color="1d76db"; description="Blazor/UI work"},
    @{name="backend"; color="5319e7"; description="API/server work"},
    @{name="database"; color="fbca04"; description="Database related"},
    @{name="testing"; color="d4c5f9"; description="Test coverage"},
    @{name="documentation"; color="0075ca"; description="Documentation improvements"},
    @{name="performance"; color="ff6b6b"; description="Performance optimization"},
    @{name="ux"; color="c5def5"; description="User experience"},
    @{name="a11y"; color="7057ff"; description="Accessibility"},
    @{name="mobile"; color="bfd4f2"; description="Mobile specific"},
    @{name="security"; color="ee0701"; description="Security improvements"},
    @{name="priority: high"; color="b60205"; description="High priority"},
    @{name="priority: medium"; color="fbca04"; description="Medium priority"},
    @{name="priority: low"; color="0e8a16"; description="Low priority"},
    @{name="good first issue"; color="7057ff"; description="Good for newcomers"},
    @{name="help wanted"; color="008672"; description="Extra attention needed"}
)

foreach ($label in $labels) {
    gh label create $label.name --color $label.color --description $label.description --repo $repo 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ Created label: $($label.name)" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ Label already exists or error: $($label.name)" -ForegroundColor Gray
    }
}

Write-Host ""

# Create Milestones
Write-Host "🎯 Creating milestones..." -ForegroundColor Yellow

$milestones = @(
    @{title="v0.2.0 - Enhanced Recipe Management"; due="2026-03-31"; description="Recipe details, categories, search, and import/export"},
    @{title="v0.3.0 - Advanced Meal Planning"; due="2026-06-30"; description="Weekly planner, templates, shopping lists, and nutrition"},
    @{title="v0.4.0 - Multi-User Support"; due="2026-09-30"; description="Authentication, user profiles, and sharing"},
    @{title="v0.5.0 - AI & Smart Features"; due="2026-12-31"; description="AI recommendations and smart features"},
    @{title="v1.0.0 - Production Ready"; due="2027-12-31"; description="Mobile apps, social features, and production deployment"}
)

foreach ($milestone in $milestones) {
    gh api repos/$repo/milestones -f title="$($milestone.title)" -f due_on="$($milestone.due)T23:59:59Z" -f description="$($milestone.description)" 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ Created milestone: $($milestone.title)" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ Milestone already exists or error: $($milestone.title)" -ForegroundColor Gray
    }
}

Write-Host ""

# Get milestone numbers for assignment
Write-Host "🔍 Fetching milestone IDs..." -ForegroundColor Yellow
$milestonesJson = gh api repos/$repo/milestones | ConvertFrom-Json
$milestoneMap = @{}
foreach ($m in $milestonesJson) {
    $milestoneMap[$m.title] = $m.number
}

Write-Host ""

# Create Issues
Write-Host "📋 Creating issues..." -ForegroundColor Yellow
Write-Host ""

# v0.2.0 Issues

# Issue 1
$issue1 = gh issue create --repo $repo `
    --title "Create detailed recipe view page" `
    --label "enhancement,feature,frontend,backend,priority: high" `
    --milestone "v0.2.0 - Enhanced Recipe Management" `
    --body @"
Implement a dedicated page to view full recipe details including ingredients, instructions, cooking time, and servings.

## Acceptance Criteria
- [ ] New page accessible from recipe list
- [ ] Display recipe name prominently
- [ ] Show complete ingredients list with quantities
- [ ] Display step-by-step cooking instructions
- [ ] Show cooking time and number of servings
- [ ] Support recipe image/photo display
- [ ] Include edit and delete buttons
- [ ] Responsive design for mobile

## Technical Notes
- Create new Razor component in ``Pages/RecipeDetails.razor``
- Add new API endpoint: ``GET /api/recipes/{id}``
- Update navigation routing
"@

Write-Host "  ✓ Issue #1: Recipe Details Page" -ForegroundColor Green

# Issue 2
$issue2 = gh issue create --repo $repo `
    --title "Implement recipe categorization system" `
    --label "enhancement,feature,database,frontend,backend,priority: high" `
    --milestone "v0.2.0 - Enhanced Recipe Management" `
    --body @"
Add category support to organize recipes by meal type (Breakfast, Lunch, Dinner, Snacks, Desserts).

## Acceptance Criteria
- [ ] Add Category field to Recipe model
- [ ] Update database schema with Categories table
- [ ] Create migration for category support
- [ ] Add category dropdown to recipe creation form
- [ ] Display category badges on recipe cards
- [ ] Implement category filter in UI
- [ ] API endpoint to get recipes by category

## Technical Notes
- Update ``Recipe.cs`` model in MealPlannerShared
- Create ``Category.cs`` model
- Add migration: ``dotnet ef migrations add AddRecipeCategories``
- Update API endpoints to support filtering
"@

Write-Host "  ✓ Issue #2: Recipe Categories" -ForegroundColor Green

# Issue 3
$issue3 = gh issue create --repo $repo `
    --title "Add search capability for recipes" `
    --label "enhancement,feature,frontend,backend,priority: medium" `
    --milestone "v0.2.0 - Enhanced Recipe Management" `
    --body @"
Implement search functionality to find recipes by name and ingredients with fuzzy search support.

## Acceptance Criteria
- [ ] Add search bar to recipes page
- [ ] Search by recipe name
- [ ] Search by ingredient names
- [ ] Implement fuzzy/partial matching
- [ ] Highlight matching terms in results
- [ ] Real-time search as user types
- [ ] Show "no results" message when appropriate
- [ ] Maintain good performance with large datasets

## Technical Notes
- Add search input component in ``Pages/Recipes.razor``
- Create API endpoint: ``GET /api/recipes/search?q={query}``
- Consider using LINQ Contains or Entity Framework LIKE
- Add debouncing to reduce API calls
"@

Write-Host "  ✓ Issue #3: Recipe Search" -ForegroundColor Green

# Issue 4
$issue4 = gh issue create --repo $repo `
    --title "Add recipe import and export functionality" `
    --label "enhancement,feature,backend,frontend,priority: low" `
    --milestone "v0.2.0 - Enhanced Recipe Management" `
    --body @"
Allow users to export recipes as JSON files and import recipes from JSON files.

## Acceptance Criteria
- [ ] Export single recipe as JSON
- [ ] Export all recipes as JSON
- [ ] Import recipe from JSON file
- [ ] Validate imported recipe data
- [ ] Handle import errors gracefully
- [ ] Show success/error messages
- [ ] Download exports with meaningful filename
- [ ] Support batch import

## Technical Notes
- Create export endpoint: ``GET /api/recipes/{id}/export``
- Create import endpoint: ``POST /api/recipes/import``
- Use ``System.Text.Json`` for serialization
- Add file upload component in Blazor
- Implement JSON schema validation
"@

Write-Host "  ✓ Issue #4: Recipe Import/Export" -ForegroundColor Green

# Issue 5
$issue5 = gh issue create --repo $repo `
    --title "Implement unit test suite with xUnit" `
    --label "testing,technical-debt,backend,priority: high" `
    --milestone "v0.2.0 - Enhanced Recipe Management" `
    --body @"
Create comprehensive unit tests for API endpoints, models, and business logic.

## Acceptance Criteria
- [ ] Set up xUnit test project
- [ ] Test all API endpoints (recipes, ingredients, meal plans)
- [ ] Test model validation
- [ ] Test database context operations
- [ ] Achieve at least 70% code coverage
- [ ] Add tests to CI/CD pipeline
- [ ] Mock database for isolated testing

## Technical Notes
- Create ``MealPlannerApi.Tests`` project
- Use ``Microsoft.EntityFrameworkCore.InMemory`` for testing
- Install packages: xUnit, Moq, FluentAssertions
- Update ``.github/workflows`` to run tests
"@

Write-Host "  ✓ Issue #5: Unit Tests" -ForegroundColor Green

# Issue 6
$issue6 = gh issue create --repo $repo `
    --title "Implement API versioning strategy" `
    --label "enhancement,technical-debt,backend,priority: medium" `
    --milestone "v0.2.0 - Enhanced Recipe Management" `
    --body @"
Add version support to the API to manage breaking changes and support multiple API versions.

## Acceptance Criteria
- [ ] Install API versioning package
- [ ] Configure version routes (e.g., ``/api/v1/recipes``)
- [ ] Update existing endpoints to v1
- [ ] Add versioning documentation
- [ ] Update OpenAPI/Swagger configuration
- [ ] Set up default version handling

## Technical Notes
- Install ``Asp.Versioning.Mvc.ApiExplorer``
- Configure in ``Program.cs``
- Use URL path versioning or header versioning
- Update all API calls in Blazor app
"@

Write-Host "  ✓ Issue #6: API Versioning" -ForegroundColor Green

# Issue 7
$issue7 = gh issue create --repo $repo `
    --title "Add response caching to improve performance" `
    --label "enhancement,performance,backend,priority: low" `
    --milestone "v0.2.0 - Enhanced Recipe Management" `
    --body @"
Implement response caching for frequently accessed, read-only endpoints.

## Acceptance Criteria
- [ ] Add response caching middleware
- [ ] Cache GET endpoints for recipes
- [ ] Cache GET endpoints for ingredients
- [ ] Set appropriate cache durations
- [ ] Invalidate cache on updates
- [ ] Add cache headers
- [ ] Test cache behavior

## Technical Notes
- Use ``[ResponseCache]`` attribute
- Configure cache profiles in ``Program.cs``
- Consider memory cache for small datasets
- Add cache-control headers
"@

Write-Host "  ✓ Issue #7: Response Caching" -ForegroundColor Green

# Issue 8
$issue8 = gh issue create --repo $repo `
    --title "Implement comprehensive request validation" `
    --label "enhancement,technical-debt,backend,frontend,priority: medium" `
    --milestone "v0.2.0 - Enhanced Recipe Management" `
    --body @"
Add validation middleware to ensure data integrity and provide meaningful error messages.

## Acceptance Criteria
- [ ] Install FluentValidation package
- [ ] Create validators for Recipe model
- [ ] Create validators for Ingredient model
- [ ] Create validators for MealPlan model
- [ ] Return structured validation errors
- [ ] Add validation to POST/PUT endpoints
- [ ] Display validation errors in UI

## Technical Notes
- Install ``FluentValidation.AspNetCore``
- Create validator classes in ``Validators/`` folder
- Register validators in DI container
- Update Blazor forms to show validation messages
"@

Write-Host "  ✓ Issue #8: Request Validation" -ForegroundColor Green

# v0.3.0 Issues

# Issue 9
$issue9 = gh issue create --repo $repo `
    --title "Create calendar-style weekly meal planner" `
    --label "enhancement,feature,frontend,backend,priority: high" `
    --milestone "v0.3.0 - Advanced Meal Planning" `
    --body @"
Build an interactive weekly calendar view where users can plan meals with drag-and-drop functionality.

## Acceptance Criteria
- [ ] Calendar grid showing 7 days
- [ ] Three meal slots per day (breakfast, lunch, dinner)
- [ ] Drag recipes from list to calendar
- [ ] Drop recipes onto meal slots
- [ ] Navigate between weeks
- [ ] Show current week by default
- [ ] Save meal assignments to database
- [ ] Mobile-friendly touch support

## Technical Notes
- Create ``Pages/WeeklyPlanner.razor``
- Consider using a Blazor drag-drop library
- Add meal type field to MealPlan model
- Create API endpoint: ``GET /api/mealplans/week?startDate={date}``
"@

Write-Host "  ✓ Issue #9: Weekly Meal Planner" -ForegroundColor Green

# Issue 10
$issue10 = gh issue create --repo $repo `
    --title "Implement reusable meal plan templates" `
    --label "enhancement,feature,frontend,backend,database,priority: medium" `
    --milestone "v0.3.0 - Advanced Meal Planning" `
    --body @"
Allow users to save favorite weekly meal plans as templates and reuse them.

## Acceptance Criteria
- [ ] Save current week as template
- [ ] Name templates
- [ ] View list of saved templates
- [ ] Apply template to new week
- [ ] Edit templates
- [ ] Delete templates
- [ ] Duplicate templates

## Technical Notes
- Create ``MealPlanTemplate`` model
- Add templates table to database
- Create API endpoints for template CRUD
- Add template management UI
"@

Write-Host "  ✓ Issue #10: Meal Plan Templates" -ForegroundColor Green

# Issue 11
$issue11 = gh issue create --repo $repo `
    --title "Auto-generate shopping lists from meal plans" `
    --label "enhancement,feature,frontend,backend,priority: high" `
    --milestone "v0.3.0 - Advanced Meal Planning" `
    --body @"
Create shopping lists from selected meal plans with aggregated ingredient quantities.

## Acceptance Criteria
- [ ] Generate list from week's meal plans
- [ ] Aggregate duplicate ingredients
- [ ] Sum ingredient quantities
- [ ] Allow manual item additions
- [ ] Check off items as purchased
- [ ] Clear completed items
- [ ] Export list as text/PDF
- [ ] Save shopping lists

## Technical Notes
- Create ``ShoppingList`` and ``ShoppingListItem`` models
- Implement ingredient aggregation logic
- Create API endpoint: ``POST /api/shoppinglists/generate``
- Add PDF export using library like QuestPDF
"@

Write-Host "  ✓ Issue #11: Shopping List Generation" -ForegroundColor Green

# Issue 12
$issue12 = gh issue create --repo $repo `
    --title "Add basic nutritional information to recipes" `
    --label "enhancement,feature,frontend,backend,database,priority: medium" `
    --milestone "v0.3.0 - Advanced Meal Planning" `
    --body @"
Track and display macronutrients (calories, protein, carbs, fat) for recipes and meal plans.

## Acceptance Criteria
- [ ] Add nutrition fields to Recipe model
- [ ] Display nutrition info on recipe details
- [ ] Calculate total nutrition for meal plan
- [ ] Show daily nutrition summary
- [ ] Show weekly nutrition summary
- [ ] Optional: nutrition per serving
- [ ] Visual charts for nutrition data

## Technical Notes
- Update Recipe model with nutrition properties
- Create migration for nutrition fields
- Add nutrition input to recipe form
- Consider using Chart.js or similar for visualizations
"@

Write-Host "  ✓ Issue #12: Nutritional Information" -ForegroundColor Green

# Issue 13
$issue13 = gh issue create --repo $repo `
    --title "Implement proper EF Core migrations workflow" `
    --label "enhancement,technical-debt,database,backend,priority: high" `
    --milestone "v0.3.0 - Advanced Meal Planning" `
    --body @"
Set up robust database migration system for schema changes and version management.

## Acceptance Criteria
- [ ] Document migration creation process
- [ ] Add migration scripts to repository
- [ ] Auto-apply migrations on startup (dev)
- [ ] Migration rollback capability
- [ ] Seed data for development
- [ ] Production migration strategy
- [ ] Migration testing

## Technical Notes
- Create ``Migrations/`` folder structure
- Add ``EnsureCreated()`` or ``Migrate()`` in startup
- Document ``dotnet ef migrations`` commands
- Create seed data script
"@

Write-Host "  ✓ Issue #13: Database Migrations" -ForegroundColor Green

# Issue 14
$issue14 = gh issue create --repo $repo `
    --title "Add OpenAPI/Swagger documentation" `
    --label "enhancement,documentation,backend,priority: medium" `
    --milestone "v0.3.0 - Advanced Meal Planning" `
    --body @"
Implement comprehensive API documentation using Swagger/OpenAPI.

## Acceptance Criteria
- [ ] Install Swashbuckle.AspNetCore
- [ ] Configure Swagger middleware
- [ ] Document all endpoints
- [ ] Add XML comments to API methods
- [ ] Include request/response examples
- [ ] Show authentication requirements
- [ ] Make available at ``/swagger``

## Technical Notes
- Add package: ``Swashbuckle.AspNetCore``
- Enable XML documentation in csproj
- Add Swagger configuration to ``Program.cs``
- Write comprehensive XML comments
"@

Write-Host "  ✓ Issue #14: API Documentation" -ForegroundColor Green

# Issue 15
$issue15 = gh issue create --repo $repo `
    --title "Optimize API and database performance" `
    --label "enhancement,performance,backend,database,priority: medium" `
    --milestone "v0.3.0 - Advanced Meal Planning" `
    --body @"
Improve application performance through query optimization, indexing, and efficient data loading.

## Acceptance Criteria
- [ ] Add database indexes on frequently queried fields
- [ ] Implement pagination for list endpoints
- [ ] Use eager/lazy loading appropriately
- [ ] Profile and optimize slow queries
- [ ] Add query result caching where appropriate
- [ ] Reduce payload sizes
- [ ] Measure and document improvements

## Technical Notes
- Add indexes to Recipe.Name, Ingredient.Name, etc.
- Implement pagination helper
- Use ``.Include()`` for related data
- Profile with EF Core logging
- Consider using projection for DTOs
"@

Write-Host "  ✓ Issue #15: Performance Optimizations" -ForegroundColor Green

# Issue 16
$issue16 = gh issue create --repo $repo `
    --title "Add component tests with bUnit" `
    --label "testing,technical-debt,frontend,priority: low" `
    --milestone "v0.3.0 - Advanced Meal Planning" `
    --body @"
Implement component-level testing for Blazor UI using bUnit framework.

## Acceptance Criteria
- [ ] Set up bUnit test project
- [ ] Test recipe list component
- [ ] Test recipe form component
- [ ] Test meal plan component
- [ ] Test navigation component
- [ ] Mock HTTP calls
- [ ] Achieve 60% component coverage

## Technical Notes
- Create ``MealPlannerApp.Tests`` project
- Install bUnit and related packages
- Mock ``HttpClient`` for API calls
- Test component rendering and interactions
"@

Write-Host "  ✓ Issue #16: Blazor Component Tests" -ForegroundColor Green

# Immediate Improvements

# Issue 17
$issue17 = gh issue create --repo $repo `
    --title "Implement loading spinners for async operations" `
    --label "enhancement,ux,frontend,priority: high" `
    --body @"
Add visual feedback when data is loading to improve user experience.

## Acceptance Criteria
- [ ] Loading spinner for recipes page
- [ ] Loading spinner for ingredients page
- [ ] Loading spinner for meal plans page
- [ ] Loading spinner for form submissions
- [ ] Disable buttons during operations
- [ ] Show loading text/skeleton screens

## Technical Notes
- Create reusable ``LoadingSpinner.razor`` component
- Use CSS animations
- Wrap async calls with loading state
"@

Write-Host "  ✓ Issue #17: Loading Indicators" -ForegroundColor Green

# Issue 18
$issue18 = gh issue create --repo $repo `
    --title "Improve error handling and user notifications" `
    --label "enhancement,ux,frontend,backend,priority: high" `
    --body @"
Implement comprehensive error handling with clear user feedback for failures.

## Acceptance Criteria
- [ ] Try-catch blocks on API calls
- [ ] Display error messages to users
- [ ] Toast notifications for success/error
- [ ] Validation error display
- [ ] Network error handling
- [ ] 404 error page
- [ ] Graceful degradation

## Technical Notes
- Create notification service
- Add error boundary components
- Use try-catch with proper logging
- Show user-friendly error messages
"@

Write-Host "  ✓ Issue #18: Error Handling" -ForegroundColor Green

# Issue 19
$issue19 = gh issue create --repo $repo `
    --title "Enhance mobile experience and touch interactions" `
    --label "enhancement,ux,frontend,mobile,priority: medium" `
    --body @"
Optimize the UI for smaller screens and touch-based interactions.

## Acceptance Criteria
- [ ] Test on various mobile screen sizes
- [ ] Improve touch target sizes
- [ ] Optimize navigation for mobile
- [ ] Stack cards properly on small screens
- [ ] Test gestures (swipe, tap)
- [ ] Reduce font sizes for mobile
- [ ] Optimize images for mobile

## Technical Notes
- Review and update CSS media queries
- Test on actual devices or emulators
- Use responsive Bootstrap classes
- Consider mobile-first approach
"@

Write-Host "  ✓ Issue #19: Mobile Responsiveness" -ForegroundColor Green

# Issue 20
$issue20 = gh issue create --repo $repo `
    --title "Implement confirmation dialogs for destructive actions" `
    --label "enhancement,ux,frontend,priority: medium" `
    --body @"
Add confirmation prompts before deleting recipes, ingredients, or meal plans.

## Acceptance Criteria
- [ ] Confirm before deleting recipe
- [ ] Confirm before deleting ingredient
- [ ] Confirm before deleting meal plan
- [ ] Show what will be deleted
- [ ] Allow cancel action
- [ ] Use modal dialogs
- [ ] Keyboard accessible (ESC to cancel)

## Technical Notes
- Create reusable ``ConfirmDialog.razor`` component
- Use Bootstrap modals or custom component
- Emit events for confirm/cancel actions
"@

Write-Host "  ✓ Issue #20: Confirmation Dialogs" -ForegroundColor Green

# Issue 21
$issue21 = gh issue create --repo $repo `
    --title "Add consistent code formatting standards" `
    --label "technical-debt,documentation,priority: low" `
    --body @"
Implement ``.editorconfig`` and code formatting rules for consistent code style.

## Acceptance Criteria
- [ ] Create ``.editorconfig`` file
- [ ] Define C# formatting rules
- [ ] Configure indentation standards
- [ ] Set up line ending rules
- [ ] Add to documentation
- [ ] Run format check in CI

## Technical Notes
- Create ``.editorconfig`` in root
- Use ``dotnet format`` command
- Add format check to GitHub Actions
- Document in CONTRIBUTING.md
"@

Write-Host "  ✓ Issue #21: Code Formatting" -ForegroundColor Green

# Issue 22
$issue22 = gh issue create --repo $repo `
    --title "Improve environment-specific configuration" `
    --label "enhancement,technical-debt,backend,priority: medium" `
    --body @"
Better manage configuration for development, staging, and production environments.

## Acceptance Criteria
- [ ] Separate appsettings files
- [ ] Environment-specific connection strings
- [ ] Manage API URLs per environment
- [ ] Use secrets for sensitive data
- [ ] Document configuration setup
- [ ] Use .NET configuration best practices

## Technical Notes
- Use ``appsettings.{Environment}.json`` pattern
- Implement ``IConfiguration`` properly
- Use user secrets for development
- Environment variables for production
"@

Write-Host "  ✓ Issue #22: Environment Configuration" -ForegroundColor Green

# Issue 23
$issue23 = gh issue create --repo $repo `
    --title "Enhance application accessibility (a11y)" `
    --label "enhancement,a11y,frontend,priority: medium" `
    --body @"
Improve keyboard navigation, screen reader support, and WCAG compliance.

## Acceptance Criteria
- [ ] All interactive elements keyboard accessible
- [ ] Proper ARIA labels
- [ ] Focus indicators visible
- [ ] Screen reader tested
- [ ] Color contrast compliance
- [ ] Skip navigation links
- [ ] Semantic HTML structure

## Technical Notes
- Use semantic HTML5 elements
- Add aria-label attributes
- Test with screen reader (NVDA/JAWS)
- Use accessibility checker tools
- Follow WCAG 2.1 AA standards
"@

Write-Host "  ✓ Issue #23: Accessibility Improvements" -ForegroundColor Green

# Issue 24
$issue24 = gh issue create --repo $repo `
    --title "Update README with application screenshots" `
    --label "documentation,priority: low" `
    --body @"
Add screenshots of key features to the README and documentation.

## Acceptance Criteria
- [ ] Screenshot of recipe list page
- [ ] Screenshot of meal planning interface
- [ ] Screenshot of recipe details page
- [ ] Screenshot of ingredient management
- [ ] Architecture diagram
- [ ] Mobile screenshots
- [ ] Update docs/ folder

## Technical Notes
- Create ``docs/images/`` folder
- Take high-quality screenshots
- Optimize image sizes
- Update README.md with images
"@

Write-Host "  ✓ Issue #24: README Screenshots" -ForegroundColor Green

Write-Host ""
Write-Host "✨ All done! Created 24 issues across multiple milestones." -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Go to your GitHub repository" -ForegroundColor White
Write-Host "  2. Navigate to Projects and create a new project" -ForegroundColor White
Write-Host "  3. Add the created issues to your project board" -ForegroundColor White
Write-Host "  4. Organize them into columns (Backlog, To Do, In Progress, etc.)" -ForegroundColor White
Write-Host ""
Write-Host "Repository: https://github.com/$repo/issues" -ForegroundColor Cyan
