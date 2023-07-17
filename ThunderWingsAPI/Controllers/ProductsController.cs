using Microsoft.AspNetCore.Mvc;
using ThunderWingsAPI.DAL;
using ThunderWingsAPI.Models;
using ThunderWingsAPI.Services;

namespace ThunderWingsAPI.Controllers;

[ApiController]
[Route("products")]
public class ProductsController : Controller
{
    private readonly IProductsService _productsService;

    public ProductsController(IProductsService productsService)
    {
        _productsService = productsService;
    }

    [HttpGet("getallproducts")]
    public async Task<IActionResult> GetAllProducts([FromQuery] int page, int perPage)
    {
        var products = await _productsService.GetAllProducts();

        return Ok(PaginateResults(page, perPage, products));
    }

    [HttpGet("productsearch")]
    public async Task<IActionResult> ProductSearch([FromQuery] int page, int perPage, string searchQuery)
    {
        var products = await _productsService.SearchProducts(searchQuery);

        return Ok(PaginateResults(page, perPage, products));
    }

    private ProductsWrapper PaginateResults(int page, int perPage, IEnumerable<Airplane> results)
    {
        if (page <= 0 ) page = 1;
        if (perPage <= 0) perPage = 10;

        int maxPage = (int)Math.Ceiling((decimal)results.Count()/ perPage);
        if (page > maxPage) page = maxPage;

        return new ProductsWrapper
        {
            Page = page,
            PerPage = perPage,
            MaxPage = (int)Math.Ceiling((decimal)results.Count()/ perPage),
            Data = results.Skip((page-1)*perPage).Take(perPage).ToList()
        };
    }

    public class ProductsWrapper
    {
        public int Page { get; set; }
        public int PerPage { get; set; }
        public int MaxPage { get; set; }
        public IEnumerable<Airplane> Data { get; set; }
    }
}
