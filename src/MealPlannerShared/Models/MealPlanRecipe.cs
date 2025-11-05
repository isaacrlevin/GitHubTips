namespace MealPlannerShared.Models;

public class MealPlanRecipe
{
    public int MealPlanId { get; set; }
    public MealPlan? MealPlan { get; set; }
    public int RecipeId { get; set; }
    public Recipe? Recipe { get; set; }
    public string? MealType { get; set; } // Breakfast, Lunch, Dinner
}
