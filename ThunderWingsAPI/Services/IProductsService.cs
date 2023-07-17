using ThunderWingsAPI.Models;

namespace ThunderWingsAPI.Services
{
    public interface IProductsService
    {
        Task<IEnumerable<Airplane>> GetAllProducts();
        Task<IEnumerable<Airplane>> SearchProducts(string searchQuery);
    }
}