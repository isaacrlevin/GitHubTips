using System.ComponentModel.DataAnnotations;

namespace MealPlannerShared.Models;

public class Ingredient
{
    public int Id { get; set; }
    [Required, MaxLength(100)]
    public string Name { get; set; } = string.Empty;
    [MaxLength(50)]
    public string? Unit { get; set; }

    public ICollection<RecipeIngredient> RecipeIngredients { get; set; } = new List<RecipeIngredient>();
}
