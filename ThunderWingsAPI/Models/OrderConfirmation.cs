namespace ThunderWingsAPI.Models;

public class OrderConfirmation
{
    public int ID { get; set; }
    public string CustomerName { get; set; }
    public string DeliveryAddress { get; set; }
    public DateTime CreatedAt { get; set; }
    public decimal TotalCost { get; set; }
}
