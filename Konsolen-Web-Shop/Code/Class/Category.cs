namespace Konsolen_Web_Shop.Code.Class;

public class Category
{
    public int CategoryID { get; set; }
    public string CategoryName { get; set; }

    // Navigation Property
    public List<Article> Articles { get; set; } = new List<Article>();
}