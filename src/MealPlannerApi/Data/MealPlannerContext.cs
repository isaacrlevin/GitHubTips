using MealPlannerShared.Models;
using Microsoft.EntityFrameworkCore;

namespace MealPlannerApi.Data;

public class MealPlannerContext : DbContext
{
    public MealPlannerContext(DbContextOptions<MealPlannerContext> options) : base(options) {}

    public DbSet<Recipe> Recipes => Set<Recipe>();
    public DbSet<Ingredient> Ingredients => Set<Ingredient>();
    public DbSet<RecipeIngredient> RecipeIngredients => Set<RecipeIngredient>();
    public DbSet<MealPlan> MealPlans => Set<MealPlan>();
    public DbSet<MealPlanRecipe> MealPlanRecipes => Set<MealPlanRecipe>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<RecipeIngredient>().HasKey(ri => new { ri.RecipeId, ri.IngredientId });
        modelBuilder.Entity<MealPlanRecipe>().HasKey(mpr => new { mpr.MealPlanId, mpr.RecipeId });
    }
}
