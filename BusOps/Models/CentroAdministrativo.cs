namespace BusOps.Models;

public class CentroAdministrativo
{
    public int Id { get; set; }
    public int ClienteId { get; set; }
    public Cliente? Cliente { get; set; }
    
    /// <summary>
    /// Código del centro administrativo (ej: A11003800)
    /// </summary>
    public string CodigoCentro { get; set; } = string.Empty;
    
    /// <summary>
    /// Código de rol del centro:
    /// 01 = Oficina contable
    /// 02 = Órgano gestor
    /// 03 = Unidad tramitadora
    /// 04 = Órgano proponente
    /// </summary>
    public string CodigoRol { get; set; } = string.Empty;
    
    public string Nombre { get; set; } = string.Empty;
    public string? Direccion { get; set; }
    public string? CodigoPostal { get; set; }
    public string? Ciudad { get; set; }
    public string? Provincia { get; set; }
    public string Pais { get; set; } = "ESP";
}

public enum TipoRolCentro
{
    OficinaContable = 1,    // 01
    OrganoGestor = 2,       // 02
    UnidadTramitadora = 3,  // 03
    OrganoProponente = 4    // 04
}
