using ThunderWingsAPI.Models;

namespace ThunderWingsAPI.Services
{
    public interface IBasketsService
    {
        Task<Basket> AddItemToBasket(int id, Guid? basketUID);
        Task<Tuple<ResultCodes, OrderConfirmation>> ConfirmOrder(Guid basketUID, string customerName, string deliveryAddress);
        Task<Basket> GetBasket(Guid basketUID);
        Task<Basket> RemoveItemFromBasket(int id, Guid basketUID);
    }
}