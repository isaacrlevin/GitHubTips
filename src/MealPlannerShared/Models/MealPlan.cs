using System.ComponentModel.DataAnnotations;

namespace MealPlannerShared.Models;

public class MealPlan
{
    public int Id { get; set; }
    [Required]
    public DateOnly Date { get; set; }
    public ICollection<MealPlanRecipe> MealPlanRecipes { get; set; } = new List<MealPlanRecipe>();
}
