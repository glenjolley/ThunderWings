namespace ThunderWingsAPI.Models;

public class Basket
{
    public Guid UID { get; set; }
    public decimal CurrentTotal => BasketContents.Sum(a => a.Price);
    public int CurrentTotalItems => BasketContents.Count();
    public IEnumerable<Airplane> BasketContents { get; set; }
}
