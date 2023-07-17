using Microsoft.AspNetCore.Mvc;
using ThunderWingsAPI.Models;
using ThunderWingsAPI.Services;

namespace ThunderWingsAPI.Controllers;

[ApiController]
[Route("baskets")]
public class BasketsController : Controller
{
    private readonly IBasketsService _basketsService;

    public BasketsController(IBasketsService basketsService)
    {
        _basketsService = basketsService;
    }

    [HttpPost("additemtobasket")]
    public async Task<IActionResult> AddItemToBasket([FromQuery] int itemID, Guid? basketUID)
    {
        return Ok(await _basketsService.AddItemToBasket(itemID, basketUID));
    }

    [HttpPost("removeitemfrombasket")]
    public async Task<IActionResult> RemoveItemFromBasket([FromQuery] int itemID, Guid basketUID)
    {
        var basket = await _basketsService.RemoveItemFromBasket(itemID, basketUID);

        if (basket == null)
        {
            return NotFound(new {Message = "Basket not found"});
        }

        return Ok(basket);
    }

    [HttpGet("getbasket")]
    public async Task<IActionResult> GetBasket([FromQuery] Guid basketUID)
    {
        var basket = await _basketsService.GetBasket(basketUID);

        if (basket == null)
        {
            return NotFound(new {Message = "Basket not found"});
        }

        return Ok(basket);
    }

    [HttpPost("confirmorder")]
    public async Task<IActionResult> ConfirmOrder([FromQuery] Guid basketUID, string customerName, string deliveryAddress)
    {
        var basket = await _basketsService.GetBasket(basketUID);

        if (basket == null)
        {
            return NotFound(new {Message = "Basket not found"});
        }

        if (string.IsNullOrEmpty(customerName) || string.IsNullOrEmpty(deliveryAddress) || customerName.Length > 255 || deliveryAddress.Length > 1000) 
        {
            return BadRequest(new {Message = "Invalid customer name or delivery address"});
        }

        var result = await _basketsService.ConfirmOrder(basketUID, customerName, deliveryAddress);
        
        if (result.Item1 == ResultCodes.Fail)
        {
            return BadRequest(new {Message = "An error occurred"});
        }

        return Ok(new { 
            Message = result.Item1 == ResultCodes.Preexisting ? "Order previously confirmed." : "Order confirmed.",
            OrderDetails = result.Item2
            }
        );
    }
}
