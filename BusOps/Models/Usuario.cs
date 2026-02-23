namespace BusOps.Models;

public class Usuario
{
    public int Id { get; set; }
    public string Username { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public string NombreCompleto { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string Rol { get; set; } = "Usuario"; // "SuperAdministrador", "Administrador" o "Usuario"
    public bool Activo { get; set; } = true;
    public DateTime FechaCreacion { get; set; } = DateTime.Now;
    
    // Multi-tenant: null para SuperAdministrador, requerido para otros roles
    public int? EmpresaId { get; set; }
    public Empresa? Empresa { get; set; }
}

public static class Roles
{
    public const string SuperAdministrador = "SuperAdministrador";
    public const string Administrador = "Administrador";
    public const string Usuario = "Usuario";
}
