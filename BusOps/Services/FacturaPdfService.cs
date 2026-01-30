using QuestPDF.Fluent;
using QuestPDF.Helpers;
using QuestPDF.Infrastructure;
using BusOps.Models;
using BusOps.Helpers;
using Microsoft.AspNetCore.Hosting;

namespace BusOps.Services;

public class FacturaPdfService
{
    private readonly IWebHostEnvironment _webHostEnvironment;

    public FacturaPdfService(IWebHostEnvironment webHostEnvironment)
    {
        _webHostEnvironment = webHostEnvironment;
    }

    public byte[] GenerarFacturaPdf(Factura factura, Cliente cliente, ConfiguracionEmpresa? config, bool paraEmail = true)
    {
        QuestPDF.Settings.License = LicenseType.Community;

        // Tamaños según destino
        // Email: tamaño normal para buena visualización en pantalla con MUCHO espacio
        // Impresión: más compacto para que quepa en una página
        var margen = paraEmail ? 50 : 20;
        var fuenteBase = paraEmail ? 11 : 8;
        var fuenteGrande = paraEmail ? 16 : 10;
        var fuenteMedia = paraEmail ? 13 : 9;
        var fuentePequena = paraEmail ? 10 : 7;
        var fuenteMuyPequena = paraEmail ? 9 : 6;
        var logoAncho = paraEmail ? 120 : 60;
        var logoAlto = paraEmail ? 60 : 30;

        var documento = Document.Create(container =>
        {
            container.Page(page =>
            {
                page.Size(PageSizes.A4);
                page.Margin(margen);
                page.DefaultTextStyle(x => x.FontSize(fuenteBase));

                page.Header().Column(column =>
                {
                    column.Item().Row(row =>
                    {
                        // Datos de la empresa (izquierda)
                        row.RelativeItem().Column(col =>
                        {
                            // Logo de la empresa si existe
                            if (!string.IsNullOrEmpty(config?.LogoRuta))
                            {
                                string logoPath = config.LogoRuta;
                                if (logoPath.StartsWith("/") || logoPath.StartsWith("\\"))
                                {
                                    logoPath = Path.Combine(_webHostEnvironment.WebRootPath, logoPath.TrimStart('/', '\\'));
                                }
                                
                                if (File.Exists(logoPath))
                                {
                                    col.Item().MaxWidth(logoAncho).MaxHeight(logoAlto).Image(logoPath);
                                    col.Item().PaddingTop(1);
                                }
                            }
                            
                            col.Item().Text(config?.NombreEmpresa ?? "BusOps Transportes S.L.")
                                .FontSize(fuenteMedia).Bold().FontColor("#003366");
                            col.Item().Text(config?.Direccion ?? "Calle Principal 123").FontSize(fuentePequena);
                            col.Item().Text($"{config?.CodigoPostal ?? "28001"} {config?.Ciudad ?? "Madrid"}").FontSize(fuentePequena);
                            col.Item().Text($"NIF: {config?.NIF ?? "B12345678"}").FontSize(fuentePequena);
                            col.Item().Text($"Tel: {config?.Telefono ?? "910123456"}").FontSize(fuentePequena);
                            if (!string.IsNullOrEmpty(config?.Email))
                            {
                                col.Item().Text($"Email: {config.Email}").FontSize(fuentePequena);
                            }
                            if (!string.IsNullOrEmpty(config?.Web))
                            {
                                col.Item().Text($"Web: {config.Web}").FontSize(fuentePequena);
                            }
                        });

                        // Datos del cliente y factura (derecha)
                        row.RelativeItem().Column(col =>
                        {
                            // Encabezado FACTURA
                            col.Item().Background("#003366").Padding(2).Column(c =>
                            {
                                c.Item().AlignCenter().Text("FACTURA").FontSize(fuenteGrande).Bold().FontColor(Colors.White);
                                c.Item().AlignCenter().Text(factura.NumeroFactura).FontSize(fuenteBase).FontColor(Colors.White);
                            });
                            
                            col.Item().PaddingTop(1);
                            
                            // Cuadro de datos del cliente
                            col.Item().Background(Colors.Grey.Lighten3).Padding(2).Column(c =>
                            {
                                c.Item().Text("CLIENTE").Bold().FontSize(fuenteBase).FontColor("#003366");
                                
                                if (cliente.Tipo == TipoCliente.Particular)
                                {
                                    c.Item().Text($"{cliente.Nombre} {cliente.Apellidos}").FontSize(fuenteBase).Bold();
                                }
                                else
                                {
                                    c.Item().Text(cliente.NombreEmpresa ?? "").FontSize(fuenteBase).Bold();
                                    if (!string.IsNullOrEmpty(cliente.Nombre))
                                    {
                                        c.Item().Text($"Att: {cliente.Nombre}").FontSize(fuentePequena);
                                    }
                                }
                                
                                c.Item().Text($"NIF/CIF: {cliente.NIF}").FontSize(fuentePequena);
                                if (!string.IsNullOrEmpty(cliente.Direccion))
                                {
                                    c.Item().Text(cliente.Direccion).FontSize(fuentePequena);
                                }
                                if (!string.IsNullOrEmpty(cliente.CodigoPostal) || !string.IsNullOrEmpty(cliente.Ciudad))
                                {
                                    c.Item().Text($"{cliente.CodigoPostal} {cliente.Ciudad}").FontSize(fuentePequena);
                                }
                                if (!string.IsNullOrEmpty(cliente.Telefono))
                                {
                                    c.Item().Text($"Tel: {cliente.Telefono}").FontSize(fuentePequena);
                                }
                                if (!string.IsNullOrEmpty(cliente.Email))
                                {
                                    c.Item().Text($"Email: {cliente.Email}").FontSize(fuentePequena);
                                }
                            });
                        });
                    });

                    column.Item().PaddingTop(paraEmail ? 10 : 2);
                    
                    // Información de la factura
                    column.Item().Background(Colors.Grey.Lighten4).Padding(paraEmail ? 8 : 1).Row(row =>
                    {
                        row.AutoItem().Text($"Fecha Emisión: {factura.FechaEmision:dd/MM/yyyy}").FontSize(fuentePequena);
                        row.AutoItem().PaddingLeft(5).Text($"Vencimiento: {factura.FechaVencimiento?.ToString("dd/MM/yyyy") ?? "N/A"}").FontSize(fuentePequena);
                        if (factura.FormaPago.HasValue)
                        {
                            row.AutoItem().PaddingLeft(5).Text($"Forma de Pago: {factura.FormaPago.Value.GetDisplayName()}").FontSize(fuentePequena);
                        }
                    });

                    column.Item().PaddingVertical(paraEmail ? 5 : 2).LineHorizontal(1).LineColor(Colors.Grey.Medium);
                });

                page.Content().Column(column =>
                {
                    // Concepto si existe
                    if (!string.IsNullOrEmpty(factura.Concepto))
                    {
                        column.Item().Background("#fffbf0").BorderLeft(2).BorderColor("#FFC107")
                            .Padding(paraEmail ? 10 : 2).Text($"Concepto: {factura.Concepto}").FontSize(fuenteBase).Italic();
                        column.Item().PaddingVertical(paraEmail ? 8 : 1);
                    }

                    // Tabla de líneas
                    column.Item().Table(table =>
                    {
                        table.ColumnsDefinition(columns =>
                        {
                            columns.RelativeColumn(4);
                            columns.RelativeColumn(1);
                            columns.RelativeColumn(1.5f);
                            columns.RelativeColumn(1.5f);
                        });

                        table.Header(header =>
                        {
                            var headerPadding = paraEmail ? 6 : 1;
                            header.Cell().Background("#003366").Padding(headerPadding)
                                .Text("Descripción").Bold().FontColor(Colors.White).FontSize(fuenteBase);
                            header.Cell().Background("#003366").Padding(headerPadding)
                                .AlignCenter().Text("Cant.").Bold().FontColor(Colors.White).FontSize(fuenteBase);
                            header.Cell().Background("#003366").Padding(headerPadding)
                                .AlignRight().Text("Precio Unit.").Bold().FontColor(Colors.White).FontSize(fuenteBase);
                            header.Cell().Background("#003366").Padding(headerPadding)
                                .AlignRight().Text("Subtotal").Bold().FontColor(Colors.White).FontSize(fuenteBase);
                        });

                        var cellPadding = paraEmail ? 4 : 1;
                        foreach (var linea in factura.Lineas)
                        {
                            table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(cellPadding)
                                .Column(col =>
                                {
                                    col.Item().Text(linea.Descripcion).Bold().FontSize(fuenteBase);
                                    if (linea.Tipo == TipoLineaFactura.CargoAdicional)
                                    {
                                        col.Item().Text("(Cargo Adicional)").FontSize(fuentePequena).Italic().FontColor(Colors.Orange.Medium);
                                    }
                                });
                            table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(cellPadding)
                                .AlignCenter().Text(linea.Cantidad.ToString()).FontSize(fuenteBase);
                            table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(cellPadding)
                                .AlignRight().Text(linea.PrecioUnitario.ToString("C2")).FontSize(fuenteBase);
                            table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(cellPadding)
                                .AlignRight().Text(linea.Subtotal.ToString("C2")).Bold().FontSize(fuenteBase);
                        }
                        
                        // ImporteConcepto si existe
                        if (factura.ImporteConcepto > 0 && !string.IsNullOrEmpty(factura.ConceptoCargos))
                        {
                            table.Cell().Background("#fffbf0").BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(1)
                                .Column(col =>
                                {
                                    col.Item().Text(factura.ConceptoCargos).Bold().FontSize(fuenteBase);
                                    col.Item().Text("(Concepto Especial)").FontSize(fuentePequena).Italic().FontColor(Colors.Blue.Medium);
                                });
                            table.Cell().Background("#fffbf0").BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(1).Text("");
                            table.Cell().Background("#fffbf0").BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(1).Text("");
                            table.Cell().Background("#fffbf0").BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(1)
                                .AlignRight().Text(factura.ImporteConcepto.ToString("C2")).Bold().FontSize(fuenteBase);
                        }
                    });

                    column.Item().PaddingTop(2);

                    // Totales
                    column.Item().AlignRight().Width(130).Table(table =>
                    {
                        table.ColumnsDefinition(columns =>
                        {
                            columns.RelativeColumn(2);
                            columns.RelativeColumn(1);
                        });

                        table.Cell().Padding(1).Text("Base Imponible:").Bold().FontSize(fuenteBase);
                        table.Cell().Padding(1).AlignRight().Text(factura.BaseImponible.ToString("C2")).FontSize(fuenteBase);

                        table.Cell().Padding(1).Text($"IVA ({factura.PorcentajeIVA}%):").Bold().FontSize(fuenteBase);
                        table.Cell().Padding(1).AlignRight().Text(factura.ImporteIVA.ToString("C2")).FontSize(fuenteBase);

                        // Retención (si existe)
                        if (factura.PorcentajeRetencion > 0)
                        {
                            table.Cell().Padding(1).Text($"Retención IRPF ({factura.PorcentajeRetencion}%):").Bold().FontColor(Colors.Red.Medium).FontSize(fuenteBase);
                            table.Cell().Padding(1).AlignRight().Text($"-{factura.ImporteRetencion.ToString("C2")}").FontSize(fuenteBase).FontColor(Colors.Red.Medium);
                        }

                        table.Cell().Background("#003366").Padding(1).Text("TOTAL:").Bold().FontSize(fuenteMedia).FontColor(Colors.White);
                        table.Cell().Background("#003366").Padding(1).AlignRight()
                            .Text(factura.Total.ToString("C2")).Bold().FontSize(fuenteMedia).FontColor(Colors.White);
                    });

                    // Observaciones si existen
                    if (!string.IsNullOrEmpty(factura.Observaciones))
                    {
                        column.Item().PaddingTop(2);
                        column.Item().Background(Colors.Grey.Lighten4).Padding(2).Column(col =>
                        {
                            col.Item().Text("Observaciones:").Bold().FontSize(fuenteBase).FontColor("#003366");
                            col.Item().Text(factura.Observaciones).FontSize(fuentePequena);
                        });
                    }
                    
                    // Pie de página
                    column.Item().PaddingTop(2).BorderTop(1).BorderColor(Colors.Grey.Medium)
                        .PaddingTop(1).AlignCenter().Column(col =>
                        {
                            col.Item().Text($"Gracias por confiar en {config?.NombreEmpresa ?? "BusOps Transportes S.L."}")
                                .FontSize(fuenteMuyPequena).Italic().FontColor(Colors.Grey.Darken1);
                            if (!string.IsNullOrEmpty(config?.IBAN))
                            {
                                col.Item().Text($"Datos bancarios: IBAN {config.IBAN}")
                                    .FontSize(fuenteMuyPequena).FontColor(Colors.Grey.Darken1);
                            }
                        });
                });

                page.Footer().AlignCenter().Text(text =>
                {
                    text.Span("Página ");
                    text.CurrentPageNumber();
                    text.Span(" de ");
                    text.TotalPages();
                });
            });
        });

        return documento.GeneratePdf();
    }
}
