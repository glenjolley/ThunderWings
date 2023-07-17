namespace ThunderWingsAPI.DAL
{
    public interface IDBAccess
    {
        Task<IEnumerable<T>> GetDataAsync<T, P>(string sp, P parameters);
        Task SendDataAsync<P>(string sp, P parameters);
    }
}