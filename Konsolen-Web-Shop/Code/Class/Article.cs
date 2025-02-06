namespace Konsolen_Web_Shop.Code.Class;

public class Article
{
    // Auto-Implemented Properties mit Getter und Setter direkt bei der Deklaration
    public int Id { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }
    public Condition Condition { get; set; }
    public List<Category> Categories { get; set; } = new List<Category>(); // Standardwert ist eine leere Liste
    public List<Image> Images { get; set; } = new List<Image>(); // Standardwert ist eine leere Liste
    public DateTime Date { get; set; }
    public decimal Price { get; set; }
    public int Discount { get; set; }
}