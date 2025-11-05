# Roadmap

This document outlines the planned features and enhancements for Meal Planner.

## Version 0.1.0 (Current) ✅

**Released**: November 2025

Core functionality:
- ✅ Recipe management (create, list, delete)
- ✅ Ingredient tracking (create, list, delete)
- ✅ Basic meal planning by date
- ✅ Modern responsive UI with gradient design
- ✅ SQLite persistence
- ✅ RESTful API
- ✅ Dev container support

## Version 0.2.0 (Q1 2026) 🔄

**Focus**: Enhanced Recipe Management

### Features
- [ ] **Recipe Details Page**
  - Full recipe view with ingredients list
  - Step-by-step instructions
  - Cooking time and servings
  - Recipe images/photos

- [ ] **Recipe Categories**
  - Breakfast, Lunch, Dinner, Snacks, Desserts
  - Filter recipes by category
  - Category badges in UI

- [ ] **Recipe Search**
  - Search by name and ingredients
  - Fuzzy search support
  - Search results highlighting

- [ ] **Recipe Import/Export**
  - Export recipes as JSON
  - Import from JSON files
  - Basic recipe card format

### Technical Improvements
- [ ] Add unit tests (xUnit)
- [ ] API versioning
- [ ] Response caching
- [ ] Request validation middleware

## Version 0.3.0 (Q2 2026) 📅

**Focus**: Advanced Meal Planning

### Features
- [ ] **Weekly Meal Planner View**
  - Calendar-style interface
  - Drag-and-drop recipes to days
  - Meal types (breakfast, lunch, dinner)
  - Quick meal suggestions

- [ ] **Meal Plan Templates**
  - Save favorite weekly plans
  - Duplicate plans to new weeks
  - Template library

- [ ] **Shopping List Generation**
  - Auto-generate from meal plans
  - Aggregate ingredient quantities
  - Check off items in app
  - Export as text/PDF

- [ ] **Nutritional Information**
  - Basic macros (calories, protein, carbs, fat)
  - Per-recipe tracking
  - Daily/weekly summaries

### Technical Improvements
- [ ] Database migrations
- [ ] API documentation (OpenAPI/Swagger)
- [ ] Performance optimizations
- [ ] Blazor component tests (bUnit)

## Version 0.4.0 (Q3 2026) 🔐

**Focus**: Multi-User Support

### Features
- [ ] **User Authentication**
  - ASP.NET Core Identity
  - JWT tokens
  - Secure password storage
  - Email verification

- [ ] **User Profiles**
  - Personal recipe collections
  - Dietary preferences
  - Favorite recipes
  - Profile pictures

- [ ] **Data Privacy**
  - User-specific data isolation
  - Privacy settings
  - Data export (GDPR compliance)
  - Account deletion

- [ ] **Sharing Features**
  - Share recipes with other users
  - Public/private recipe visibility
  - Recipe ratings and comments

### Technical Improvements
- [ ] Authorization policies
- [ ] Refresh tokens
- [ ] Rate limiting
- [ ] Security hardening

## Version 0.5.0 (Q4 2026) 🤖

**Focus**: AI & Smart Features

### Features
- [ ] **AI Meal Recommendations**
  - Suggest meals based on available ingredients
  - Dietary restriction awareness
  - Seasonal suggestions
  - Learning user preferences

- [ ] **Recipe Scaling**
  - Adjust servings automatically
  - Convert measurement units
  - Fractional quantities

- [ ] **Leftover Management**
  - Track what's in fridge
  - Suggest recipes using leftovers
  - Expiration date tracking

- [ ] **Smart Shopping Lists**
  - Learn buying patterns
  - Suggest purchase quantities
  - Store locations/aisles

### Technical Improvements
- [ ] Azure OpenAI integration
- [ ] Background jobs (Hangfire)
- [ ] Caching layer (Redis)
- [ ] Advanced search (Elasticsearch)

## Version 1.0.0 (2027) 🚀

**Focus**: Production Ready

### Features
- [ ] **Mobile Apps**
  - iOS app (MAUI)
  - Android app (MAUI)
  - Offline support
  - Push notifications

- [ ] **Social Features**
  - Follow other users
  - Recipe feeds
  - Trending recipes
  - Community challenges

- [ ] **Advanced Analytics**
  - Cooking statistics
  - Cost tracking
  - Nutritional trends
  - Meal variety insights

- [ ] **Integrations**
  - Recipe import from websites
  - Grocery delivery services
  - Fitness app sync
  - Calendar integration

### Technical Improvements
- [ ] Microservices architecture
- [ ] GraphQL API
- [ ] Real-time updates (SignalR)
- [ ] CDN for images
- [ ] Multi-region deployment
- [ ] Comprehensive monitoring

## Future Considerations 💭

*Ideas under consideration for post-1.0:*

- Voice commands (Alexa/Google Home)
- Meal prep tracking
- Recipe video tutorials
- Meal delivery service integration
- Restaurant menu suggestions
- Allergen warnings
- Wine/beverage pairings
- Kitchen equipment management
- Barcode scanning for ingredients
- AI-generated recipe images
- Meal plan export to calendar apps
- Family/household meal planning
- Recipe translation (multiple languages)
- Cost optimization suggestions
- Carbon footprint tracking

## Contributing to the Roadmap

We welcome input on our roadmap! Here's how to participate:

1. **Vote on Features**: Add 👍 reactions to issues
2. **Suggest Features**: Use the Feature Request template
3. **Discuss Priorities**: Join discussions in GitHub Discussions
4. **Submit PRs**: Help implement planned features

## Roadmap Updates

This roadmap is reviewed and updated:
- Monthly for near-term items
- Quarterly for long-term items
- Based on community feedback
- As priorities shift

Last Updated: November 2025

---

*Note: Timelines are estimates and may change based on resources, community contributions, and priorities.*
