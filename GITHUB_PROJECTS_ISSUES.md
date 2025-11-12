# GitHub Projects Issues Template

This document contains all the issues to create for the Meal Planner GitHub Projects board. Each issue includes title, description, labels, and milestone information.

## How to Use This Document

1. Create a new GitHub Project board for your repository
2. Set up columns: Backlog, To Do, In Progress, In Review, Done
3. Create each issue below in your GitHub repository
4. Add appropriate labels to each issue
5. Assign issues to the correct milestone
6. Link issues to your project board

---

## Milestone: v0.2.0 - Enhanced Recipe Management (Q1 2026)

### Issue 1: Recipe Details Page

**Title:** Create detailed recipe view page

**Description:**
Implement a dedicated page to view full recipe details including ingredients, instructions, cooking time, and servings.

**Acceptance Criteria:**
- [ ] New page accessible from recipe list
- [ ] Display recipe name prominently
- [ ] Show complete ingredients list with quantities
- [ ] Display step-by-step cooking instructions
- [ ] Show cooking time and number of servings
- [ ] Support recipe image/photo display
- [ ] Include edit and delete buttons
- [ ] Responsive design for mobile

**Technical Notes:**
- Create new Razor component in `Pages/RecipeDetails.razor`
- Add new API endpoint: `GET /api/recipes/{id}`
- Update navigation routing

**Labels:** `enhancement`, `feature`, `frontend`, `backend`
**Milestone:** v0.2.0
**Priority:** High

---

### Issue 2: Add Recipe Categories

**Title:** Implement recipe categorization system

**Description:**
Add category support to organize recipes by meal type (Breakfast, Lunch, Dinner, Snacks, Desserts).

**Acceptance Criteria:**
- [ ] Add Category field to Recipe model
- [ ] Update database schema with Categories table
- [ ] Create migration for category support
- [ ] Add category dropdown to recipe creation form
- [ ] Display category badges on recipe cards
- [ ] Implement category filter in UI
- [ ] API endpoint to get recipes by category

**Technical Notes:**
- Update `Recipe.cs` model in MealPlannerShared
- Create `Category.cs` model
- Add migration: `dotnet ef migrations add AddRecipeCategories`
- Update API endpoints to support filtering

**Labels:** `enhancement`, `feature`, `database`, `frontend`, `backend`
**Milestone:** v0.2.0
**Priority:** High

---

### Issue 3: Recipe Search Functionality

**Title:** Add search capability for recipes

**Description:**
Implement search functionality to find recipes by name and ingredients with fuzzy search support.

**Acceptance Criteria:**
- [ ] Add search bar to recipes page
- [ ] Search by recipe name
- [ ] Search by ingredient names
- [ ] Implement fuzzy/partial matching
- [ ] Highlight matching terms in results
- [ ] Real-time search as user types
- [ ] Show "no results" message when appropriate
- [ ] Maintain good performance with large datasets

**Technical Notes:**
- Add search input component in `Pages/Recipes.razor`
- Create API endpoint: `GET /api/recipes/search?q={query}`
- Consider using LINQ Contains or Entity Framework LIKE
- Add debouncing to reduce API calls

**Labels:** `enhancement`, `feature`, `frontend`, `backend`
**Milestone:** v0.2.0
**Priority:** Medium

---

### Issue 4: Recipe Import/Export

**Title:** Add recipe import and export functionality

**Description:**
Allow users to export recipes as JSON files and import recipes from JSON files.

**Acceptance Criteria:**
- [ ] Export single recipe as JSON
- [ ] Export all recipes as JSON
- [ ] Import recipe from JSON file
- [ ] Validate imported recipe data
- [ ] Handle import errors gracefully
- [ ] Show success/error messages
- [ ] Download exports with meaningful filename
- [ ] Support batch import

**Technical Notes:**
- Create export endpoint: `GET /api/recipes/{id}/export`
- Create import endpoint: `POST /api/recipes/import`
- Use `System.Text.Json` for serialization
- Add file upload component in Blazor
- Implement JSON schema validation

**Labels:** `enhancement`, `feature`, `backend`, `frontend`
**Milestone:** v0.2.0
**Priority:** Low

---

### Issue 5: Add Unit Tests

**Title:** Implement unit test suite with xUnit

**Description:**
Create comprehensive unit tests for API endpoints, models, and business logic.

**Acceptance Criteria:**
- [ ] Set up xUnit test project
- [ ] Test all API endpoints (recipes, ingredients, meal plans)
- [ ] Test model validation
- [ ] Test database context operations
- [ ] Achieve at least 70% code coverage
- [ ] Add tests to CI/CD pipeline
- [ ] Mock database for isolated testing

**Technical Notes:**
- Create `MealPlannerApi.Tests` project
- Use `Microsoft.EntityFrameworkCore.InMemory` for testing
- Install packages: xUnit, Moq, FluentAssertions
- Update `.github/workflows` to run tests

**Labels:** `testing`, `technical-debt`, `backend`
**Milestone:** v0.2.0
**Priority:** High

---

### Issue 6: API Versioning

**Title:** Implement API versioning strategy

**Description:**
Add version support to the API to manage breaking changes and support multiple API versions.

**Acceptance Criteria:**
- [ ] Install API versioning package
- [ ] Configure version routes (e.g., `/api/v1/recipes`)
- [ ] Update existing endpoints to v1
- [ ] Add versioning documentation
- [ ] Update OpenAPI/Swagger configuration
- [ ] Set up default version handling

**Technical Notes:**
- Install `Asp.Versioning.Mvc.ApiExplorer`
- Configure in `Program.cs`
- Use URL path versioning or header versioning
- Update all API calls in Blazor app

**Labels:** `enhancement`, `technical-debt`, `backend`
**Milestone:** v0.2.0
**Priority:** Medium

---

### Issue 7: Response Caching

**Title:** Add response caching to improve performance

**Description:**
Implement response caching for frequently accessed, read-only endpoints.

**Acceptance Criteria:**
- [ ] Add response caching middleware
- [ ] Cache GET endpoints for recipes
- [ ] Cache GET endpoints for ingredients
- [ ] Set appropriate cache durations
- [ ] Invalidate cache on updates
- [ ] Add cache headers
- [ ] Test cache behavior

**Technical Notes:**
- Use `[ResponseCache]` attribute
- Configure cache profiles in `Program.cs`
- Consider memory cache for small datasets
- Add cache-control headers

**Labels:** `enhancement`, `performance`, `backend`
**Milestone:** v0.2.0
**Priority:** Low

---

### Issue 8: Request Validation Middleware

**Title:** Implement comprehensive request validation

**Description:**
Add validation middleware to ensure data integrity and provide meaningful error messages.

**Acceptance Criteria:**
- [ ] Install FluentValidation package
- [ ] Create validators for Recipe model
- [ ] Create validators for Ingredient model
- [ ] Create validators for MealPlan model
- [ ] Return structured validation errors
- [ ] Add validation to POST/PUT endpoints
- [ ] Display validation errors in UI

**Technical Notes:**
- Install `FluentValidation.AspNetCore`
- Create validator classes in `Validators/` folder
- Register validators in DI container
- Update Blazor forms to show validation messages

**Labels:** `enhancement`, `technical-debt`, `backend`, `frontend`
**Milestone:** v0.2.0
**Priority:** Medium

---

## Milestone: v0.3.0 - Advanced Meal Planning (Q2 2026)

### Issue 9: Weekly Meal Planner View

**Title:** Create calendar-style weekly meal planner

**Description:**
Build an interactive weekly calendar view where users can plan meals with drag-and-drop functionality.

**Acceptance Criteria:**
- [ ] Calendar grid showing 7 days
- [ ] Three meal slots per day (breakfast, lunch, dinner)
- [ ] Drag recipes from list to calendar
- [ ] Drop recipes onto meal slots
- [ ] Navigate between weeks
- [ ] Show current week by default
- [ ] Save meal assignments to database
- [ ] Mobile-friendly touch support

**Technical Notes:**
- Create `Pages/WeeklyPlanner.razor`
- Consider using a Blazor drag-drop library
- Add meal type field to MealPlan model
- Create API endpoint: `GET /api/mealplans/week?startDate={date}`

**Labels:** `enhancement`, `feature`, `frontend`, `backend`
**Milestone:** v0.3.0
**Priority:** High

---

### Issue 10: Meal Plan Templates

**Title:** Implement reusable meal plan templates

**Description:**
Allow users to save favorite weekly meal plans as templates and reuse them.

**Acceptance Criteria:**
- [ ] Save current week as template
- [ ] Name templates
- [ ] View list of saved templates
- [ ] Apply template to new week
- [ ] Edit templates
- [ ] Delete templates
- [ ] Duplicate templates

**Technical Notes:**
- Create `MealPlanTemplate` model
- Add templates table to database
- Create API endpoints for template CRUD
- Add template management UI

**Labels:** `enhancement`, `feature`, `frontend`, `backend`, `database`
**Milestone:** v0.3.0
**Priority:** Medium

---

### Issue 11: Shopping List Generation

**Title:** Auto-generate shopping lists from meal plans

**Description:**
Create shopping lists from selected meal plans with aggregated ingredient quantities.

**Acceptance Criteria:**
- [ ] Generate list from week's meal plans
- [ ] Aggregate duplicate ingredients
- [ ] Sum ingredient quantities
- [ ] Allow manual item additions
- [ ] Check off items as purchased
- [ ] Clear completed items
- [ ] Export list as text/PDF
- [ ] Save shopping lists

**Technical Notes:**
- Create `ShoppingList` and `ShoppingListItem` models
- Implement ingredient aggregation logic
- Create API endpoint: `POST /api/shoppinglists/generate`
- Add PDF export using library like QuestPDF

**Labels:** `enhancement`, `feature`, `frontend`, `backend`
**Milestone:** v0.3.0
**Priority:** High

---

### Issue 12: Nutritional Information Tracking

**Title:** Add basic nutritional information to recipes

**Description:**
Track and display macronutrients (calories, protein, carbs, fat) for recipes and meal plans.

**Acceptance Criteria:**
- [ ] Add nutrition fields to Recipe model
- [ ] Display nutrition info on recipe details
- [ ] Calculate total nutrition for meal plan
- [ ] Show daily nutrition summary
- [ ] Show weekly nutrition summary
- [ ] Optional: nutrition per serving
- [ ] Visual charts for nutrition data

**Technical Notes:**
- Update Recipe model with nutrition properties
- Create migration for nutrition fields
- Add nutrition input to recipe form
- Consider using Chart.js or similar for visualizations

**Labels:** `enhancement`, `feature`, `frontend`, `backend`, `database`
**Milestone:** v0.3.0
**Priority:** Medium

---

### Issue 13: Database Migrations Support

**Title:** Implement proper EF Core migrations workflow

**Description:**
Set up robust database migration system for schema changes and version management.

**Acceptance Criteria:**
- [ ] Document migration creation process
- [ ] Add migration scripts to repository
- [ ] Auto-apply migrations on startup (dev)
- [ ] Migration rollback capability
- [ ] Seed data for development
- [ ] Production migration strategy
- [ ] Migration testing

**Technical Notes:**
- Create `Migrations/` folder structure
- Add `EnsureCreated()` or `Migrate()` in startup
- Document `dotnet ef migrations` commands
- Create seed data script

**Labels:** `enhancement`, `technical-debt`, `database`, `backend`
**Milestone:** v0.3.0
**Priority:** High

---

### Issue 14: API Documentation with Swagger

**Title:** Add OpenAPI/Swagger documentation

**Description:**
Implement comprehensive API documentation using Swagger/OpenAPI.

**Acceptance Criteria:**
- [ ] Install Swashbuckle.AspNetCore
- [ ] Configure Swagger middleware
- [ ] Document all endpoints
- [ ] Add XML comments to API methods
- [ ] Include request/response examples
- [ ] Show authentication requirements
- [ ] Make available at `/swagger`

**Technical Notes:**
- Add package: `Swashbuckle.AspNetCore`
- Enable XML documentation in csproj
- Add Swagger configuration to `Program.cs`
- Write comprehensive XML comments

**Labels:** `enhancement`, `documentation`, `backend`
**Milestone:** v0.3.0
**Priority:** Medium

---

### Issue 15: Performance Optimizations

**Title:** Optimize API and database performance

**Description:**
Improve application performance through query optimization, indexing, and efficient data loading.

**Acceptance Criteria:**
- [ ] Add database indexes on frequently queried fields
- [ ] Implement pagination for list endpoints
- [ ] Use eager/lazy loading appropriately
- [ ] Profile and optimize slow queries
- [ ] Add query result caching where appropriate
- [ ] Reduce payload sizes
- [ ] Measure and document improvements

**Technical Notes:**
- Add indexes to Recipe.Name, Ingredient.Name, etc.
- Implement pagination helper
- Use `.Include()` for related data
- Profile with EF Core logging
- Consider using projection for DTOs

**Labels:** `enhancement`, `performance`, `backend`, `database`
**Milestone:** v0.3.0
**Priority:** Medium

---

### Issue 16: Blazor Component Tests

**Title:** Add component tests with bUnit

**Description:**
Implement component-level testing for Blazor UI using bUnit framework.

**Acceptance Criteria:**
- [ ] Set up bUnit test project
- [ ] Test recipe list component
- [ ] Test recipe form component
- [ ] Test meal plan component
- [ ] Test navigation component
- [ ] Mock HTTP calls
- [ ] Achieve 60% component coverage

**Technical Notes:**
- Create `MealPlannerApp.Tests` project
- Install bUnit and related packages
- Mock `HttpClient` for API calls
- Test component rendering and interactions

**Labels:** `testing`, `technical-debt`, `frontend`
**Milestone:** v0.3.0
**Priority:** Low

---

## Immediate Improvements (No Milestone)

### Issue 17: Add Loading Indicators

**Title:** Implement loading spinners for async operations

**Description:**
Add visual feedback when data is loading to improve user experience.

**Acceptance Criteria:**
- [ ] Loading spinner for recipes page
- [ ] Loading spinner for ingredients page
- [ ] Loading spinner for meal plans page
- [ ] Loading spinner for form submissions
- [ ] Disable buttons during operations
- [ ] Show loading text/skeleton screens

**Technical Notes:**
- Create reusable `LoadingSpinner.razor` component
- Use CSS animations
- Wrap async calls with loading state

**Labels:** `enhancement`, `ux`, `frontend`
**Priority:** High

---

### Issue 18: Error Handling and User Feedback

**Title:** Improve error handling and user notifications

**Description:**
Implement comprehensive error handling with clear user feedback for failures.

**Acceptance Criteria:**
- [ ] Try-catch blocks on API calls
- [ ] Display error messages to users
- [ ] Toast notifications for success/error
- [ ] Validation error display
- [ ] Network error handling
- [ ] 404 error page
- [ ] Graceful degradation

**Technical Notes:**
- Create notification service
- Add error boundary components
- Use try-catch with proper logging
- Show user-friendly error messages

**Labels:** `enhancement`, `ux`, `frontend`, `backend`
**Priority:** High

---

### Issue 19: Improve Mobile Responsiveness

**Title:** Enhance mobile experience and touch interactions

**Description:**
Optimize the UI for smaller screens and touch-based interactions.

**Acceptance Criteria:**
- [ ] Test on various mobile screen sizes
- [ ] Improve touch target sizes
- [ ] Optimize navigation for mobile
- [ ] Stack cards properly on small screens
- [ ] Test gestures (swipe, tap)
- [ ] Reduce font sizes for mobile
- [ ] Optimize images for mobile

**Technical Notes:**
- Review and update CSS media queries
- Test on actual devices or emulators
- Use responsive Bootstrap classes
- Consider mobile-first approach

**Labels:** `enhancement`, `ux`, `frontend`, `mobile`
**Priority:** Medium

---

### Issue 20: Add Confirmation Dialogs

**Title:** Implement confirmation dialogs for destructive actions

**Description:**
Add confirmation prompts before deleting recipes, ingredients, or meal plans.

**Acceptance Criteria:**
- [ ] Confirm before deleting recipe
- [ ] Confirm before deleting ingredient
- [ ] Confirm before deleting meal plan
- [ ] Show what will be deleted
- [ ] Allow cancel action
- [ ] Use modal dialogs
- [ ] Keyboard accessible (ESC to cancel)

**Technical Notes:**
- Create reusable `ConfirmDialog.razor` component
- Use Bootstrap modals or custom component
- Emit events for confirm/cancel actions

**Labels:** `enhancement`, `ux`, `frontend`
**Priority:** Medium

---

### Issue 21: Code Formatting and EditorConfig

**Title:** Add consistent code formatting standards

**Description:**
Implement `.editorconfig` and code formatting rules for consistent code style.

**Acceptance Criteria:**
- [ ] Create `.editorconfig` file
- [ ] Define C# formatting rules
- [ ] Configure indentation standards
- [ ] Set up line ending rules
- [ ] Add to documentation
- [ ] Run format check in CI

**Technical Notes:**
- Create `.editorconfig` in root
- Use `dotnet format` command
- Add format check to GitHub Actions
- Document in CONTRIBUTING.md

**Labels:** `technical-debt`, `documentation`
**Priority:** Low

---

### Issue 22: Environment Configuration

**Title:** Improve environment-specific configuration

**Description:**
Better manage configuration for development, staging, and production environments.

**Acceptance Criteria:**
- [ ] Separate appsettings files
- [ ] Environment-specific connection strings
- [ ] Manage API URLs per environment
- [ ] Use secrets for sensitive data
- [ ] Document configuration setup
- [ ] Use .NET configuration best practices

**Technical Notes:**
- Use `appsettings.{Environment}.json` pattern
- Implement `IConfiguration` properly
- Use user secrets for development
- Environment variables for production

**Labels:** `enhancement`, `technical-debt`, `backend`
**Priority:** Medium

---

### Issue 23: Accessibility Improvements

**Title:** Enhance application accessibility (a11y)

**Description:**
Improve keyboard navigation, screen reader support, and WCAG compliance.

**Acceptance Criteria:**
- [ ] All interactive elements keyboard accessible
- [ ] Proper ARIA labels
- [ ] Focus indicators visible
- [ ] Screen reader tested
- [ ] Color contrast compliance
- [ ] Skip navigation links
- [ ] Semantic HTML structure

**Technical Notes:**
- Use semantic HTML5 elements
- Add aria-label attributes
- Test with screen reader (NVDA/JAWS)
- Use accessibility checker tools
- Follow WCAG 2.1 AA standards

**Labels:** `enhancement`, `a11y`, `frontend`
**Priority:** Medium

---

### Issue 24: Add Comprehensive README Screenshots

**Title:** Update README with application screenshots

**Description:**
Add screenshots of key features to the README and documentation.

**Acceptance Criteria:**
- [ ] Screenshot of recipe list page
- [ ] Screenshot of meal planning interface
- [ ] Screenshot of recipe details page
- [ ] Screenshot of ingredient management
- [ ] Architecture diagram
- [ ] Mobile screenshots
- [ ] Update docs/ folder

**Technical Notes:**
- Create `docs/images/` folder
- Take high-quality screenshots
- Optimize image sizes
- Update README.md with images

**Labels:** `documentation`
**Priority:** Low

---

## Labels to Create in GitHub

Create these labels in your repository:
- `enhancement` - New feature or request
- `feature` - New functionality
- `bug` - Something isn't working
- `technical-debt` - Code quality improvements
- `frontend` - Blazor/UI work
- `backend` - API/server work
- `database` - Database related
- `testing` - Test coverage
- `documentation` - Documentation improvements
- `performance` - Performance optimization
- `ux` - User experience
- `a11y` - Accessibility
- `mobile` - Mobile specific
- `security` - Security improvements
- `priority: high` - High priority
- `priority: medium` - Medium priority
- `priority: low` - Low priority
- `good first issue` - Good for newcomers
- `help wanted` - Extra attention needed

## Milestones to Create

1. **v0.2.0 - Enhanced Recipe Management** (Q1 2026)
2. **v0.3.0 - Advanced Meal Planning** (Q2 2026)
3. **v0.4.0 - Multi-User Support** (Q3 2026)
4. **v0.5.0 - AI & Smart Features** (Q4 2026)
5. **v1.0.0 - Production Ready** (2027)

---

## Next Steps

1. **Create the labels** in your GitHub repository settings
2. **Create the milestones** with due dates
3. **Create each issue** using the templates above
4. **Set up GitHub Projects** board with appropriate columns
5. **Add issues to the project** and organize by priority
6. **Assign initial issues** to yourself or team members
7. **Start working** on high-priority items!

## GitHub Projects Board Suggested Structure

### Columns:
- 📋 **Backlog** - All issues not yet prioritized
- 📝 **To Do** - Ready to work on, prioritized
- 🏗️ **In Progress** - Currently being worked on
- 👀 **In Review** - PR submitted, awaiting review
- ✅ **Done** - Completed and merged

### Views to Create:
1. **Board View** - Kanban board with columns
2. **Table View** - Spreadsheet view with all fields
3. **Roadmap View** - Timeline view by milestone
4. **Priority View** - Grouped by priority labels

Good luck with your project! 🚀
