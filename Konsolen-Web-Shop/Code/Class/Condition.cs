namespace Konsolen_Web_Shop.Code.Class;

public class Condition
{
    public int ConditionID { get; set; }
    public string ConditionName { get; set; }

    // Navigation Property
    public List<Article> Articles { get; set; } = new List<Article>();
}