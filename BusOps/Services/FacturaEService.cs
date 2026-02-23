using System.Globalization;
using System.Text;
using System.Xml;
using BusOps.Data;
using BusOps.Models;
using Microsoft.EntityFrameworkCore;

namespace BusOps.Services;

// StringWriter que fuerza encoding UTF-8 para el XML
public class Utf8StringWriter : StringWriter
{
    public override Encoding Encoding => Encoding.UTF8;
}

public class FacturaEService
{
    private readonly IDbContextFactory<BusOpsDbContext> _dbFactory;
    private readonly ITenantService _tenantService;

    public FacturaEService(IDbContextFactory<BusOpsDbContext> dbFactory, ITenantService tenantService)
    {
        _dbFactory = dbFactory;
        _tenantService = tenantService;
    }

    public async Task<string> GenerarFacturaEXmlAsync(int facturaId)
    {
        using var context = await _dbFactory.CreateDbContextAsync();
        
        // Configurar multi-tenant
        var empresaId = await _tenantService.GetEmpresaIdAsync();
        var isSuperAdmin = await _tenantService.IsSuperAdminAsync();
        
        Console.WriteLine($"🔍 FACTURAE - Generando XML para facturaId: {facturaId}");
        Console.WriteLine($"   EmpresaId del usuario: {empresaId?.ToString() ?? "NULL"}");
        Console.WriteLine($"   IsSuperAdmin: {isSuperAdmin}");
        
        if (empresaId.HasValue)
        {
            context.CurrentEmpresaId = empresaId;
        }
        context.IsSuperAdmin = isSuperAdmin;
        
        var factura = await context.Facturas
            .Include(f => f.Cliente)
                .ThenInclude(c => c.CentrosAdministrativos)
            .Include(f => f.Lineas)
            .Include(f => f.Empresa)
            .FirstOrDefaultAsync(f => f.Id == facturaId);

        if (factura == null)
        {
            Console.WriteLine($"❌ FACTURAE - Factura {facturaId} no encontrada");
            throw new Exception("Factura no encontrada");
        }

        Console.WriteLine($"✅ FACTURAE - Factura encontrada: {factura.NumeroFactura}");
        Console.WriteLine($"   Cliente: {factura.Cliente?.Nombre ?? "NULL"}");
        Console.WriteLine($"   Líneas: {factura.Lineas?.Count ?? 0}");
        Console.WriteLine($"   Concepto: '{factura.Concepto}'");
        Console.WriteLine($"   ImporteConcepto: {factura.ImporteConcepto}");
        Console.WriteLine($"   BaseImponible: {factura.BaseImponible}");
        
        // Validaciones para clientes FacturaE
        if (factura.Cliente?.ClienteFacturaE == true)
        {
            var errores = new List<string>();
            
            if (string.IsNullOrWhiteSpace(factura.Cliente.CodigoINE))
                errores.Add("El cliente FacturaE requiere Código INE");
                
            if (factura.Cliente.CentrosAdministrativos == null || !factura.Cliente.CentrosAdministrativos.Any())
                errores.Add("El cliente FacturaE requiere al menos un Centro Administrativo");
                
            if (string.IsNullOrWhiteSpace(factura.Cliente.Direccion))
                errores.Add("El cliente FacturaE requiere Dirección completa");
                
            if (string.IsNullOrWhiteSpace(factura.Cliente.CodigoPostal))
                errores.Add("El cliente FacturaE requiere Código Postal");
                
            if (string.IsNullOrWhiteSpace(factura.Cliente.Ciudad))
                errores.Add("El cliente FacturaE requiere Ciudad");
                
            if (string.IsNullOrWhiteSpace(factura.Cliente.Provincia))
                errores.Add("El cliente FacturaE requiere Provincia");
            
            if (errores.Any())
            {
                Console.WriteLine($"❌ FACTURAE - Validación fallida para cliente FacturaE:");
                foreach (var error in errores)
                {
                    Console.WriteLine($"   - {error}");
                }
                throw new Exception($"Datos incompletos para cliente FacturaE:\\n{string.Join("\\n", errores)}");
            }
            
            Console.WriteLine($"✅ FACTURAE - Cliente FacturaE validado correctamente");
        }

        var configuracion = await context.ConfiguracionEmpresa
            .FirstOrDefaultAsync(c => c.EmpresaId == factura.EmpresaId);

        if (configuracion == null)
        {
            Console.WriteLine($"❌ FACTURAE - Configuración de empresa no encontrada para EmpresaId: {factura.EmpresaId}");
            throw new Exception("Configuración de empresa no encontrada");
        }

        Console.WriteLine($"✅ FACTURAE - Configuración encontrada: {configuracion.NombreEmpresa}");
        Console.WriteLine($"   NIF Emisor: '{configuracion.NIF}'");
        Console.WriteLine($"   TipoPersona: {configuracion.TipoPersona}");
        Console.WriteLine($"   TipoResidencia: {configuracion.TipoResidencia}");

        var settings = new XmlWriterSettings
        {
            Encoding = Encoding.UTF8,
            Indent = false, // Sin indentación - XML en una línea como FacturaE estándar
            OmitXmlDeclaration = false
        };

        using var stringWriter = new Utf8StringWriter(); // Fuerza encoding UTF-8
        
        using (var writer = XmlWriter.Create(stringWriter, settings))
        {
            writer.WriteStartDocument();

            // Elemento raíz con namespaces (versión 3.2.1 - compatible con FacturaE)
            writer.WriteStartElement("fe", "Facturae", "http://www.facturae.es/Facturae/2014/v3.2.1/Facturae");
            writer.WriteAttributeString("xmlns", "ds", null, "http://www.w3.org/2000/09/xmldsig#");

            // FileHeader
            EscribirFileHeader(writer, factura);

            // Parties (SellerParty y BuyerParty)
            EscribirParties(writer, factura, configuracion);

            // Invoices
            EscribirInvoice(writer, factura, configuracion);

            writer.WriteEndElement(); // Facturae
            writer.WriteEndDocument();
            writer.Flush(); // Asegurar que todo se escribe al StringWriter
        } // Aquí se cierra el writer

        var xmlResult = stringWriter.ToString();
        Console.WriteLine($"📄 FACTURAE - XML generado, longitud: {xmlResult.Length} caracteres");
        Console.WriteLine($"   Primeros 200 caracteres: {xmlResult.Substring(0, Math.Min(200, xmlResult.Length))}");
        
        return xmlResult;
    }

    private void EscribirFileHeader(XmlWriter writer, Factura factura)
    {
        writer.WriteStartElement("FileHeader");

        writer.WriteElementString("SchemaVersion", "3.2.1");
        writer.WriteElementString("Modality", "I"); // I = Individual
        writer.WriteElementString("InvoiceIssuerType", "EM"); // EM = Emisor

        writer.WriteStartElement("Batch");
        writer.WriteElementString("BatchIdentifier", $"{factura.NumeroFactura}-");
        writer.WriteElementString("InvoicesCount", "1");

        writer.WriteStartElement("TotalInvoicesAmount");
        writer.WriteElementString("TotalAmount", FormatDecimal(factura.Total));
        writer.WriteEndElement(); // TotalInvoicesAmount

        writer.WriteStartElement("TotalOutstandingAmount");
        writer.WriteElementString("TotalAmount", FormatDecimal(factura.Total));
        writer.WriteEndElement(); // TotalOutstandingAmount

        writer.WriteStartElement("TotalExecutableAmount");
        writer.WriteElementString("TotalAmount", FormatDecimal(factura.Total));
        writer.WriteEndElement(); // TotalExecutableAmount

        writer.WriteElementString("InvoiceCurrencyCode", "EUR");

        writer.WriteEndElement(); // Batch
        writer.WriteEndElement(); // FileHeader
    }

    private void EscribirParties(XmlWriter writer, Factura factura, ConfiguracionEmpresa config)
    {
        writer.WriteStartElement("Parties");

        // SellerParty (Empresa emisora)
        writer.WriteStartElement("SellerParty");

        writer.WriteStartElement("TaxIdentification");
        writer.WriteElementString("PersonTypeCode", config.TipoPersona == TipoPersona.Fisica ? "F" : "J");
        writer.WriteElementString("ResidenceTypeCode", config.TipoResidencia == TipoResidencia.Residente ? "R" : 
                                                       config.TipoResidencia == TipoResidencia.UnionEuropea ? "U" : "E");
        writer.WriteElementString("TaxIdentificationNumber", config.NIF);
        writer.WriteEndElement(); // TaxIdentification

        writer.WriteStartElement("LegalEntity");
        writer.WriteElementString("CorporateName", config.NombreEmpresa);
        
        if (!string.IsNullOrEmpty(config.NombreComercial))
            writer.WriteElementString("TradeName", config.NombreComercial);

        // RegistrationData (opcional)
        if (!string.IsNullOrEmpty(config.LibroRegistro))
        {
            writer.WriteStartElement("RegistrationData");
            if (!string.IsNullOrEmpty(config.LibroRegistro))
                writer.WriteElementString("Book", config.LibroRegistro);
            if (!string.IsNullOrEmpty(config.RegistroMercantil))
                writer.WriteElementString("RegisterOfCompaniesLocation", config.RegistroMercantil);
            if (!string.IsNullOrEmpty(config.HojaRegistro))
                writer.WriteElementString("Sheet", config.HojaRegistro);
            if (!string.IsNullOrEmpty(config.FolioRegistro))
                writer.WriteElementString("Folio", config.FolioRegistro);
            if (!string.IsNullOrEmpty(config.SeccionRegistro))
                writer.WriteElementString("Section", config.SeccionRegistro);
            if (!string.IsNullOrEmpty(config.TomoRegistro))
                writer.WriteElementString("Volume", config.TomoRegistro);
            if (!string.IsNullOrEmpty(config.DatosRegistroAdicionales))
                writer.WriteElementString("AdditionalRegistrationData", config.DatosRegistroAdicionales);
            writer.WriteEndElement(); // RegistrationData
        }

        // AddressInSpain
        writer.WriteStartElement("AddressInSpain");
        writer.WriteElementString("Address", config.Direccion);
        writer.WriteElementString("PostCode", config.CodigoPostal);
        writer.WriteElementString("Town", config.Ciudad);
        writer.WriteElementString("Province", config.Provincia);
        writer.WriteElementString("CountryCode", config.Pais);
        writer.WriteEndElement(); // AddressInSpain

        // ContactDetails
        writer.WriteStartElement("ContactDetails");
        writer.WriteElementString("Telephone", config.Telefono);
        if (!string.IsNullOrEmpty(config.Fax))
            writer.WriteElementString("TeleFax", config.Fax);
        if (!string.IsNullOrEmpty(config.Web))
            writer.WriteElementString("WebAddress", config.Web);
        writer.WriteElementString("ElectronicMail", config.Email);
        if (!string.IsNullOrEmpty(config.PersonaContacto))
            writer.WriteElementString("ContactPersons", config.PersonaContacto);
        if (!string.IsNullOrEmpty(config.CNAE))
            writer.WriteElementString("CnoCnae", config.CNAE);
        if (!string.IsNullOrEmpty(config.CodigoINE))
            writer.WriteElementString("INETownCode", config.CodigoINE);
        writer.WriteEndElement(); // ContactDetails

        writer.WriteEndElement(); // LegalEntity
        writer.WriteEndElement(); // SellerParty

        // BuyerParty (Cliente)
        if (factura.Cliente != null)
        {
            writer.WriteStartElement("BuyerParty");

            writer.WriteStartElement("TaxIdentification");
            writer.WriteElementString("PersonTypeCode", factura.Cliente.TipoPersona == TipoPersona.Fisica ? "F" : "J");
            writer.WriteElementString("ResidenceTypeCode", 
                factura.Cliente.TipoResidencia == TipoResidencia.Residente ? "R" :
                factura.Cliente.TipoResidencia == TipoResidencia.UnionEuropea ? "U" : "E");
            writer.WriteElementString("TaxIdentificationNumber", factura.Cliente.NIF);
            writer.WriteEndElement(); // TaxIdentification

            // AdministrativeCentres (Centros Administrativos)
            if (factura.Cliente.CentrosAdministrativos != null && factura.Cliente.CentrosAdministrativos.Any())
            {
                writer.WriteStartElement("AdministrativeCentres");
                
                foreach (var centro in factura.Cliente.CentrosAdministrativos)
                {
                    writer.WriteStartElement("AdministrativeCentre");
                    writer.WriteElementString("CentreCode", centro.CodigoCentro);
                    writer.WriteElementString("RoleTypeCode", centro.CodigoRol);
                    writer.WriteElementString("Name", centro.Nombre);
                    
                    writer.WriteStartElement("AddressInSpain");
                    writer.WriteElementString("Address", centro.Direccion ?? "");
                    writer.WriteElementString("PostCode", centro.CodigoPostal ?? "");
                    writer.WriteElementString("Town", centro.Ciudad ?? "");
                    writer.WriteElementString("Province", centro.Provincia ?? "");
                    writer.WriteElementString("CountryCode", centro.Pais);
                    writer.WriteEndElement(); // AddressInSpain
                    
                    writer.WriteEndElement(); // AdministrativeCentre
                }
                
                writer.WriteEndElement(); // AdministrativeCentres
            }

            if (factura.Cliente.TipoPersona == TipoPersona.Juridica)
            {
                writer.WriteStartElement("LegalEntity");
                writer.WriteElementString("CorporateName", factura.Cliente.NombreEmpresa ?? factura.Cliente.Nombre);
            }
            else
            {
                writer.WriteStartElement("Individual");
                writer.WriteElementString("Name", factura.Cliente.Nombre ?? "");
                writer.WriteElementString("FirstSurname", factura.Cliente.Apellidos ?? "");
                writer.WriteElementString("SecondSurname", "");
            }

            // AddressInSpain
            writer.WriteStartElement("AddressInSpain");
            writer.WriteElementString("Address", factura.Cliente.Direccion ?? "");
            writer.WriteElementString("PostCode", factura.Cliente.CodigoPostal ?? "");
            writer.WriteElementString("Town", factura.Cliente.Ciudad ?? "");
            writer.WriteElementString("Province", factura.Cliente.Provincia ?? "");
            writer.WriteElementString("CountryCode", factura.Cliente.Pais);
            writer.WriteEndElement(); // AddressInSpain

            // ContactDetails
            writer.WriteStartElement("ContactDetails");
            writer.WriteElementString("Telephone", factura.Cliente.Telefono);
            if (!string.IsNullOrEmpty(factura.Cliente.Fax))
                writer.WriteElementString("TeleFax", factura.Cliente.Fax);
            if (!string.IsNullOrEmpty(factura.Cliente.PersonaContacto))
                writer.WriteElementString("ContactPersons", factura.Cliente.PersonaContacto);
            if (!string.IsNullOrEmpty(factura.Cliente.CodigoINE))
                writer.WriteElementString("INETownCode", factura.Cliente.CodigoINE);
            writer.WriteEndElement(); // ContactDetails

            writer.WriteEndElement(); // LegalEntity o Individual
            writer.WriteEndElement(); // BuyerParty
        }

        writer.WriteEndElement(); // Parties
    }

    private void EscribirInvoice(XmlWriter writer, Factura factura, ConfiguracionEmpresa config)
    {
        writer.WriteStartElement("Invoices");
        writer.WriteStartElement("Invoice");

        // InvoiceHeader
        writer.WriteStartElement("InvoiceHeader");
        
        var partesNumero = ExtraerNumeroYSerie(factura.NumeroFactura);
        writer.WriteElementString("InvoiceNumber", partesNumero.numero);
        writer.WriteElementString("InvoiceSeriesCode", partesNumero.serie);
        writer.WriteElementString("InvoiceDocumentType", 
            factura.TipoFactura == TipoFactura.Completa ? "FC" :
            factura.TipoFactura == TipoFactura.Abreviada ? "FA" : "AF");
        writer.WriteElementString("InvoiceClass", 
            factura.ClaseFactura == ClaseFactura.Original ? "OO" :
            factura.ClaseFactura == ClaseFactura.Rectificativa ? "OR" : "OC");
        
        writer.WriteEndElement(); // InvoiceHeader

        // InvoiceIssueData
        writer.WriteStartElement("InvoiceIssueData");
        writer.WriteElementString("IssueDate", factura.FechaEmision.ToString("yyyy-MM-dd"));
        
        if (factura.FechaOperacion.HasValue)
            writer.WriteElementString("OperationDate", factura.FechaOperacion.Value.ToString("yyyy-MM-dd"));

        if (!string.IsNullOrEmpty(factura.CodigoPostalExpedicion) || !string.IsNullOrEmpty(factura.LugarExpedicion))
        {
            writer.WriteStartElement("PlaceOfIssue");
            writer.WriteElementString("PostCode", factura.CodigoPostalExpedicion ?? config.CodigoPostal);
            writer.WriteElementString("PlaceOfIssueDescription", factura.LugarExpedicion ?? config.Ciudad);
            writer.WriteEndElement(); // PlaceOfIssue
        }

        if (factura.FechaPeriodoInicio.HasValue && factura.FechaPeriodoFin.HasValue)
        {
            writer.WriteStartElement("InvoicingPeriod");
            writer.WriteElementString("StartDate", factura.FechaPeriodoInicio.Value.ToString("yyyy-MM-dd"));
            writer.WriteElementString("EndDate", factura.FechaPeriodoFin.Value.ToString("yyyy-MM-dd"));
            writer.WriteEndElement(); // InvoicingPeriod
        }

        writer.WriteElementString("InvoiceCurrencyCode", "EUR");
        writer.WriteElementString("TaxCurrencyCode", "EUR");
        writer.WriteElementString("LanguageName", "es");
        
        writer.WriteEndElement(); // InvoiceIssueData

        // TaxesOutputs (IVA)
        writer.WriteStartElement("TaxesOutputs");
        writer.WriteStartElement("Tax");
        writer.WriteElementString("TaxTypeCode", "01"); // 01 = IVA
        writer.WriteElementString("TaxRate", FormatTaxRate(factura.PorcentajeIVA));
        writer.WriteStartElement("TaxableBase");
        writer.WriteElementString("TotalAmount", FormatDecimal(factura.BaseImponible));
        writer.WriteEndElement();
        writer.WriteStartElement("TaxAmount");
        writer.WriteElementString("TotalAmount", FormatDecimal(factura.ImporteIVA));
        writer.WriteEndElement();
        writer.WriteEndElement(); // Tax
        writer.WriteEndElement(); // TaxesOutputs

        // TaxesWithheld (Retención si existe)
        if (factura.PorcentajeRetencion > 0)
        {
            writer.WriteStartElement("TaxesWithheld");
            writer.WriteStartElement("Tax");
            writer.WriteElementString("TaxTypeCode", "04"); // 04 = IRPF
            writer.WriteElementString("TaxRate", FormatTaxRate(factura.PorcentajeRetencion));
            writer.WriteStartElement("TaxableBase");
            writer.WriteElementString("TotalAmount", FormatDecimal(factura.BaseImponible));
            writer.WriteEndElement();
            writer.WriteStartElement("TaxAmount");
            writer.WriteElementString("TotalAmount", FormatDecimal(factura.ImporteRetencion));
            writer.WriteEndElement();
            writer.WriteEndElement(); // Tax
            writer.WriteEndElement(); // TaxesWithheld
        }

        // InvoiceTotals
        writer.WriteStartElement("InvoiceTotals");
        writer.WriteElementString("TotalGrossAmount", FormatDecimal(factura.BaseImponible));
        
        // TotalGeneralDiscounts (siempre presente, aunque sea 0)
        writer.WriteElementString("TotalGeneralDiscounts", FormatDecimal(factura.DescuentosGenerales));
        
        // TotalGeneralSurcharges (siempre presente, aunque sea 0)
        writer.WriteElementString("TotalGeneralSurcharges", FormatDecimal(factura.RecargosGenerales));
        
        var totalAntesImpuestos = factura.BaseImponible - factura.DescuentosGenerales + factura.RecargosGenerales;
        writer.WriteElementString("TotalGrossAmountBeforeTaxes", FormatDecimal(totalAntesImpuestos));
        writer.WriteElementString("TotalTaxOutputs", FormatDecimal(factura.ImporteIVA));
        
        // TotalTaxesWithheld (siempre presente, aunque sea 0)
        writer.WriteElementString("TotalTaxesWithheld", FormatDecimal(factura.ImporteRetencion));
        
        writer.WriteElementString("InvoiceTotal", FormatDecimal(factura.Total));
        writer.WriteElementString("TotalOutstandingAmount", FormatDecimal(factura.Total));
        writer.WriteElementString("TotalExecutableAmount", FormatDecimal(factura.Total));
        
        writer.WriteEndElement(); // InvoiceTotals

        // Items (Líneas de factura)
        writer.WriteStartElement("Items");
        
        if (factura.Lineas.Any())
        {
            // Si hay líneas detalladas, usarlas
            foreach (var linea in factura.Lineas)
            {
                writer.WriteStartElement("InvoiceLine");
                
                writer.WriteElementString("ItemDescription", linea.Descripcion);
                writer.WriteElementString("Quantity", linea.Cantidad.ToString(CultureInfo.InvariantCulture));
                writer.WriteElementString("UnitOfMeasure", "01"); // 01 = Unidades
                writer.WriteElementString("UnitPriceWithoutTax", FormatDecimal(linea.PrecioUnitario));
                writer.WriteElementString("TotalCost", FormatDecimal(linea.Subtotal));
                writer.WriteElementString("GrossAmount", FormatDecimal(linea.Subtotal));
                
                // TaxesOutputs por línea
                writer.WriteStartElement("TaxesOutputs");
                writer.WriteStartElement("Tax");
                writer.WriteElementString("TaxTypeCode", "01");
                writer.WriteElementString("TaxRate", FormatTaxRate(factura.PorcentajeIVA));
                writer.WriteStartElement("TaxableBase");
                writer.WriteElementString("TotalAmount", FormatDecimal(linea.Subtotal));
                writer.WriteEndElement();
                writer.WriteStartElement("TaxAmount");
                var ivaLinea = linea.Subtotal * (factura.PorcentajeIVA / 100);
                writer.WriteElementString("TotalAmount", FormatDecimal(ivaLinea));
                writer.WriteEndElement();
                writer.WriteEndElement(); // Tax
                writer.WriteEndElement(); // TaxesOutputs
                
                writer.WriteEndElement(); // InvoiceLine
            }
        }
        else if (!string.IsNullOrEmpty(factura.Concepto) && factura.ImporteConcepto > 0)
        {
            // Si no hay líneas pero hay concepto simple, crear una línea a partir del concepto
            writer.WriteStartElement("InvoiceLine");
            
            writer.WriteElementString("ItemDescription", factura.Concepto);
            writer.WriteElementString("Quantity", "1");
            writer.WriteElementString("UnitOfMeasure", "01"); // 01 = Unidades
            writer.WriteElementString("UnitPriceWithoutTax", FormatDecimal(factura.ImporteConcepto));
            writer.WriteElementString("TotalCost", FormatDecimal(factura.ImporteConcepto));
            writer.WriteElementString("GrossAmount", FormatDecimal(factura.ImporteConcepto));
            
            // TaxesOutputs por línea
            writer.WriteStartElement("TaxesOutputs");
            writer.WriteStartElement("Tax");
            writer.WriteElementString("TaxTypeCode", "01");
            writer.WriteElementString("TaxRate", FormatTaxRate(factura.PorcentajeIVA));
            writer.WriteStartElement("TaxableBase");
            writer.WriteElementString("TotalAmount", FormatDecimal(factura.ImporteConcepto));
            writer.WriteEndElement();
            writer.WriteStartElement("TaxAmount");
            var ivaLinea = factura.ImporteConcepto * (factura.PorcentajeIVA / 100);
            writer.WriteElementString("TotalAmount", FormatDecimal(ivaLinea));
            writer.WriteEndElement();
            writer.WriteEndElement(); // Tax
            writer.WriteEndElement(); // TaxesOutputs
            
            writer.WriteEndElement(); // InvoiceLine
        }
        else
        {
            // Si no hay ni líneas ni concepto, crear una línea genérica con la base imponible
            writer.WriteStartElement("InvoiceLine");
            
            writer.WriteElementString("ItemDescription", "Servicio de transporte");
            writer.WriteElementString("Quantity", "1");
            writer.WriteElementString("UnitOfMeasure", "01"); // 01 = Unidades
            writer.WriteElementString("UnitPriceWithoutTax", FormatDecimal(factura.BaseImponible));
            writer.WriteElementString("TotalCost", FormatDecimal(factura.BaseImponible));
            writer.WriteElementString("GrossAmount", FormatDecimal(factura.BaseImponible));
            
            // TaxesOutputs por línea
            writer.WriteStartElement("TaxesOutputs");
            writer.WriteStartElement("Tax");
            writer.WriteElementString("TaxTypeCode", "01");
            writer.WriteElementString("TaxRate", FormatTaxRate(factura.PorcentajeIVA));
            writer.WriteStartElement("TaxableBase");
            writer.WriteElementString("TotalAmount", FormatDecimal(factura.BaseImponible));
            writer.WriteEndElement();
            writer.WriteStartElement("TaxAmount");
            writer.WriteElementString("TotalAmount", FormatDecimal(factura.ImporteIVA));
            writer.WriteEndElement();
            writer.WriteEndElement(); // Tax
            writer.WriteEndElement(); // TaxesOutputs
            
            writer.WriteEndElement(); // InvoiceLine
        }
        
        writer.WriteEndElement(); // Items

        // PaymentDetails (opcional)
        if (factura.FormaPago.HasValue)
        {
            writer.WriteStartElement("PaymentDetails");
            writer.WriteStartElement("Installment");
            
            if (factura.FechaVencimiento.HasValue)
                writer.WriteElementString("InstallmentDueDate", factura.FechaVencimiento.Value.ToString("yyyy-MM-dd"));
            
            writer.WriteElementString("InstallmentAmount", FormatDecimal(factura.Total));
            writer.WriteElementString("PaymentMeans", ConvertirFormaPago(factura.FormaPago.Value));
            
            if (!string.IsNullOrEmpty(config.IBAN))
            {
                writer.WriteStartElement("AccountToBeCredited");
                writer.WriteElementString("IBAN", config.IBAN);
                writer.WriteEndElement();
            }
            
            writer.WriteEndElement(); // Installment
            writer.WriteEndElement(); // PaymentDetails
        }

        writer.WriteEndElement(); // Invoice
        writer.WriteEndElement(); // Invoices
    }

    private string FormatDecimal(decimal value)
    {
        // Formato: usa punto decimal, mínimo 1 decimal, máximo 2 decimales
        // Ejemplo: 10 -> "10.0", 10.5 -> "10.5", 10.50 -> "10.5", 10.55 -> "10.55"
        var formatted = value.ToString("0.0##", CultureInfo.InvariantCulture);
        return formatted;
    }

    private string FormatTaxRate(decimal value)
    {
        // TaxRate debe ser entero si no tiene decimales (ej: 10, 21), o con decimales si los tiene (ej: 10.5, 4.2)
        // Ejemplo: 10 -> "10", 10.5 -> "10.5", 21 -> "21"
        return value % 1 == 0 
            ? value.ToString("0", CultureInfo.InvariantCulture)
            : value.ToString("0.0##", CultureInfo.InvariantCulture);
    }

    private (string serie, string numero) ExtraerNumeroYSerie(string numeroFactura)
    {
        // Intenta extraer serie y número del formato: "FAC-2024-0001"
        var partes = numeroFactura.Split('-');
        if (partes.Length >= 2)
        {
            var serie = string.Join("-", partes.Take(partes.Length - 1));
            var numero = partes.Last();
            return (serie, numero);
        }
        return ("", numeroFactura);
    }

    private string ConvertirFormaPago(FormaPago formaPago)
    {
        return formaPago switch
        {
            FormaPago.Transferencia => "04", // Transferencia
            FormaPago.Domiciliacion => "02", // Domiciliación
            FormaPago.TarjetaCredito => "48", // Tarjeta crédito
            FormaPago.TarjetaDebito => "49", // Tarjeta débito
            _ => "01" // Contado (Efectivo, Bizum, etc.)
        };
    }
}
