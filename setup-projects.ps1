# GitHub Projects Setup Script
# Creates labels, milestones, and issues for the Meal Planner project
# Prerequisites: GitHub CLI (gh) must be installed and authenticated

param(
    [string]$repo = "isaacrlevin/GitHubTips"
)

Write-Host "Setting up GitHub Projects for $repo" -ForegroundColor Cyan
Write-Host ""

# Check if GitHub CLI is installed
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: GitHub CLI is not installed. Install from https://cli.github.com/" -ForegroundColor Red
    exit 1
}

# Check if authenticated
gh auth status 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Not authenticated with GitHub CLI. Run: gh auth login" -ForegroundColor Red
    exit 1
}

Write-Host "GitHub CLI is authenticated" -ForegroundColor Green
Write-Host ""

# Create Labels
Write-Host "Creating labels..." -ForegroundColor Yellow

$labels = @(
    @{name="enhancement"; color="a2eeef"; description="New feature or request"}
    @{name="feature"; color="0e8a16"; description="New functionality"}
    @{name="bug"; color="d73a4a"; description="Something isn't working"}
    @{name="technical-debt"; color="f9d0c4"; description="Code quality improvements"}
    @{name="frontend"; color="1d76db"; description="Blazor/UI work"}
    @{name="backend"; color="5319e7"; description="API/server work"}
    @{name="database"; color="fbca04"; description="Database related"}
    @{name="testing"; color="d4c5f9"; description="Test coverage"}
    @{name="documentation"; color="0075ca"; description="Documentation improvements"}
    @{name="performance"; color="ff6b6b"; description="Performance optimization"}
    @{name="ux"; color="c5def5"; description="User experience"}
    @{name="a11y"; color="7057ff"; description="Accessibility"}
    @{name="mobile"; color="bfd4f2"; description="Mobile specific"}
    @{name="security"; color="ee0701"; description="Security improvements"}
    @{name="priority: high"; color="b60205"; description="High priority"}
    @{name="priority: medium"; color="fbca04"; description="Medium priority"}
    @{name="priority: low"; color="0e8a16"; description="Low priority"}
    @{name="good first issue"; color="7057ff"; description="Good for newcomers"}
    @{name="help wanted"; color="008672"; description="Extra attention needed"}
)

foreach ($label in $labels) {
    $result = gh label create $label.name --color $label.color --description $label.description --repo $repo 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  Created label: $($label.name)" -ForegroundColor Green
    } else {
        Write-Host "  Label exists: $($label.name)" -ForegroundColor Gray
    }
}

Write-Host ""

# Create Milestones
Write-Host "Creating milestones..." -ForegroundColor Yellow

$milestones = @(
    @{title="v0.2.0 - Enhanced Recipe Management"; due="2026-03-31"; description="Recipe details, categories, search, and import/export"}
    @{title="v0.3.0 - Advanced Meal Planning"; due="2026-06-30"; description="Weekly planner, templates, shopping lists, and nutrition"}
    @{title="v0.4.0 - Multi-User Support"; due="2026-09-30"; description="Authentication, user profiles, and sharing"}
    @{title="v0.5.0 - AI & Smart Features"; due="2026-12-31"; description="AI recommendations and smart features"}
    @{title="v1.0.0 - Production Ready"; due="2027-12-31"; description="Mobile apps, social features, and production deployment"}
)

foreach ($milestone in $milestones) {
    $dueDate = "$($milestone.due)T23:59:59Z"
    $result = gh api repos/$repo/milestones -f title="$($milestone.title)" -f due_on="$dueDate" -f description="$($milestone.description)" 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  Created milestone: $($milestone.title)" -ForegroundColor Green
    } else {
        Write-Host "  Milestone exists: $($milestone.title)" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "Creating issues..." -ForegroundColor Yellow
Write-Host ""

# Helper function to create issues
function New-ProjectIssue {
    param(
        [string]$Title,
        [string]$Body,
        [string]$Labels,
        [string]$Milestone,
        [string]$DisplayName
    )

    $result = gh issue create --repo $repo --title $Title --label $Labels --milestone $Milestone --body $Body 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  Created: $DisplayName" -ForegroundColor Green
    } else {
        Write-Host "  Error: $DisplayName - $result" -ForegroundColor Red
    }
}

# Issue 1: Recipe Details Page
$body1 = @"
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

New-ProjectIssue -Title "Create detailed recipe view page" -Body $body1 -Labels "enhancement,feature,frontend,backend,priority: high" -Milestone "v0.2.0 - Enhanced Recipe Management" -DisplayName "Issue #1: Recipe Details Page"

# Issue 2: Recipe Categories
$body2 = @"
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

New-ProjectIssue -Title "Implement recipe categorization system" -Body $body2 -Labels "enhancement,feature,database,frontend,backend,priority: high" -Milestone "v0.2.0 - Enhanced Recipe Management" -DisplayName "Issue #2: Recipe Categories"

# Issue 3: Recipe Search
$body3 = @"
Implement search functionality to find recipes by name and ingredients with fuzzy search support.

## Acceptance Criteria
- [ ] Add search bar to recipes page
- [ ] Search by recipe name
- [ ] Search by ingredient names
- [ ] Implement fuzzy/partial matching
- [ ] Highlight matching terms in results
- [ ] Real-time search as user types
- [ ] Show 'no results' message when appropriate
- [ ] Maintain good performance with large datasets

## Technical Notes
- Add search input component in ``Pages/Recipes.razor``
- Create API endpoint: ``GET /api/recipes/search?q={query}``
- Consider using LINQ Contains or Entity Framework LIKE
- Add debouncing to reduce API calls
"@

New-ProjectIssue -Title "Add search capability for recipes" -Body $body3 -Labels "enhancement,feature,frontend,backend,priority: medium" -Milestone "v0.2.0 - Enhanced Recipe Management" -DisplayName "Issue #3: Recipe Search"

# Issue 4: Recipe Import/Export
$body4 = @"
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

New-ProjectIssue -Title "Add recipe import and export functionality" -Body $body4 -Labels "enhancement,feature,backend,frontend,priority: low" -Milestone "v0.2.0 - Enhanced Recipe Management" -DisplayName "Issue #4: Recipe Import/Export"

# Issue 5: Unit Tests
$body5 = @"
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

New-ProjectIssue -Title "Implement unit test suite with xUnit" -Body $body5 -Labels "testing,technical-debt,backend,priority: high" -Milestone "v0.2.0 - Enhanced Recipe Management" -DisplayName "Issue #5: Unit Tests"

# Issue 6: API Versioning
$body6 = @"
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

New-ProjectIssue -Title "Implement API versioning strategy" -Body $body6 -Labels "enhancement,technical-debt,backend,priority: medium" -Milestone "v0.2.0 - Enhanced Recipe Management" -DisplayName "Issue #6: API Versioning"

# Issue 7: Response Caching
$body7 = @"
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

New-ProjectIssue -Title "Add response caching to improve performance" -Body $body7 -Labels "enhancement,performance,backend,priority: low" -Milestone "v0.2.0 - Enhanced Recipe Management" -DisplayName "Issue #7: Response Caching"

# Issue 8: Request Validation
$body8 = @"
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

New-ProjectIssue -Title "Implement comprehensive request validation" -Body $body8 -Labels "enhancement,technical-debt,backend,frontend,priority: medium" -Milestone "v0.2.0 - Enhanced Recipe Management" -DisplayName "Issue #8: Request Validation"

Write-Host ""
Write-Host "All done! Created labels, milestones, and 8 issues for v0.2.0" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next: Go to https://github.com/$repo/issues to see your issues" -ForegroundColor Yellow
Write-Host "Then create a GitHub Project board and add these issues to it" -ForegroundColor Yellow
