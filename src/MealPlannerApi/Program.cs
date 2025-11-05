using MealPlannerApi.Data;
using MealPlannerShared.Models;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<MealPlannerContext>(opts =>
    opts.UseSqlite("Data Source=mealplanner.db"));

builder.Services.AddCors(options =>
{
    options.AddPolicy("frontend", policy =>
        policy.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod());
});

builder.Services.AddEndpointsApiExplorer();
// Basic Swagger configuration - if version mismatch occurs, comment out temporarily

var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<MealPlannerContext>();
    db.Database.EnsureCreated();
}

// Swagger temporarily disabled due to preview version conflicts.

app.UseCors("frontend");
app.UseHttpsRedirection();

app.MapGet("/api/recipes", async (MealPlannerContext db) => await db.Recipes.Include(r=>r.Ingredients).ToListAsync());
app.MapGet("/api/recipes/{id:int}", async (int id, MealPlannerContext db) =>
    await db.Recipes.Include(r=>r.Ingredients).FirstOrDefaultAsync(r => r.Id == id)
        is Recipe recipe ? Results.Ok(recipe) : Results.NotFound());
app.MapPost("/api/recipes", async (Recipe recipe, MealPlannerContext db) =>
{
    db.Recipes.Add(recipe);
    await db.SaveChangesAsync();
    return Results.Created($"/api/recipes/{recipe.Id}", recipe);
});
app.MapPut("/api/recipes/{id:int}", async (int id, Recipe input, MealPlannerContext db) =>
{
    var recipe = await db.Recipes.FindAsync(id);
    if (recipe is null) return Results.NotFound();
    recipe.Name = input.Name;
    recipe.Description = input.Description;
    await db.SaveChangesAsync();
    return Results.Ok(recipe);
});
app.MapDelete("/api/recipes/{id:int}", async (int id, MealPlannerContext db) =>
{
    var recipe = await db.Recipes.FindAsync(id);
    if (recipe is null) return Results.NotFound();
    db.Remove(recipe);
    await db.SaveChangesAsync();
    return Results.NoContent();
});

app.MapGet("/api/ingredients", async (MealPlannerContext db) => await db.Ingredients.ToListAsync());
app.MapPost("/api/ingredients", async (Ingredient ingredient, MealPlannerContext db) =>
{
    db.Ingredients.Add(ingredient);
    await db.SaveChangesAsync();
    return Results.Created($"/api/ingredients/{ingredient.Id}", ingredient);
});

app.MapGet("/api/mealplans", async (MealPlannerContext db) => await db.MealPlans.Include(m=>m.MealPlanRecipes).ToListAsync());
app.MapPost("/api/mealplans", async (MealPlan plan, MealPlannerContext db) =>
{
    db.MealPlans.Add(plan);
    await db.SaveChangesAsync();
    return Results.Created($"/api/mealplans/{plan.Id}", plan);
});

app.Run();
