using ThunderWingsAPI.DAL;
using ThunderWingsAPI.Models;

namespace ThunderWingsAPI.Services;

public class ProductsService : IProductsService
{
    private readonly IDBAccess _db;

    public ProductsService(IDBAccess db)
    {
        _db = db;
    }

    public async Task<IEnumerable<Airplane>> GetAllProducts()
    {
        return await _db.GetDataAsync<Airplane, dynamic>("GetAllProducts", null);
    }

    public async Task<IEnumerable<Airplane>> SearchProducts(string searchQuery)
    {
        return await _db.GetDataAsync<Airplane, dynamic>("SearchProducts", new { SearchQuery = searchQuery });
    }
}