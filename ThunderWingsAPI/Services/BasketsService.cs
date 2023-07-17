using Dapper;
using Microsoft.AspNetCore.Mvc;
using ThunderWingsAPI.DAL;
using ThunderWingsAPI.Models;

namespace ThunderWingsAPI.Services;

public class BasketsService : IBasketsService
{
    private readonly IDBAccess _db;

    public BasketsService(IDBAccess db)
    {
        _db = db;
    }

    public async Task<Basket> AddItemToBasket(int airplaneID, Guid? basketUID)
    {
        var basket = (await _db.GetDataAsync<Basket, dynamic>("AddToBasket", new { ItemID = airplaneID, BasketUID = basketUID == null ? Guid.NewGuid() : basketUID })).FirstOrDefault();
        
        if (basket != null){
            basket.BasketContents = await GetBasketContents(basket.UID);
        }

        return basket;
    }

    public async Task<Basket> RemoveItemFromBasket(int airplaneID, Guid basketUID)
    {
        var basket = (await _db.GetDataAsync<Basket, dynamic>("RemoveFromBasket", new { ItemID = airplaneID, BasketUID = basketUID })).FirstOrDefault();
        
        if (basket != null){
            basket.BasketContents = await GetBasketContents(basket.UID);
        }

        return basket;
    }
    public async Task<Basket> GetBasket(Guid basketUID)
    {
        var basket = (await _db.GetDataAsync<Basket, dynamic>("GetBasket", new { BasketUID = basketUID })).FirstOrDefault();

        if (basket != null){
            basket.BasketContents = await GetBasketContents(basket.UID);
        }

        return basket;
    }
    
    public async Task<Tuple<ResultCodes,OrderConfirmation>> ConfirmOrder(Guid basketUID, string customerName, string deliveryAddress)
    {
        DynamicParameters p = new();

        p.Add("@basketUID", basketUID);
        p.Add("@customerName", customerName);
        p.Add("@deliveryAddress", deliveryAddress);
        p.Add("@result", dbType: System.Data.DbType.Int32, direction: System.Data.ParameterDirection.Output);

        var result = (await _db.GetDataAsync<OrderConfirmation, dynamic>("ConfirmOrder", p)).First();

        return Tuple.Create(p.Get<ResultCodes>("@result"),result);
    }

    private async Task<IEnumerable<Airplane>> GetBasketContents(Guid basketUID)
    {
        return await _db.GetDataAsync<Airplane, dynamic>("GetBasketContents", new { BasketUID = basketUID });
    }

}
