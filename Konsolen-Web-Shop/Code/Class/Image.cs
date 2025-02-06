namespace Konsolen_Web_Shop.Code.Class;

public class Image
{
    public int ImageID { get; set; }
    public int ArticleID { get; set; }
    public byte[] ImageData { get; set; }  // BLOB für die Bilddaten
    public Article Article { get; set; }
}