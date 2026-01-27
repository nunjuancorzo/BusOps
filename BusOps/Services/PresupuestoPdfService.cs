using QuestPDF.Fluent;
using QuestPDF.Helpers;
using QuestPDF.Infrastructure;
using BusOps.Models;
using BusOps.Helpers;
using Microsoft.AspNetCore.Hosting;

namespace BusOps.Services;

public class PresupuestoPdfService
{
    private readonly IWebHostEnvironment _webHostEnvironment;

    public PresupuestoPdfService(IWebHostEnvironment webHostEnvironment)
    {
        _webHostEnvironment = webHostEnvironment;
    }

    public byte[] GenerarPresupuestoPdf(Presupuesto presupuesto, Cliente cliente, ConfiguracionEmpresa? config)
    {
        QuestPDF.Settings.License = LicenseType.Community;

        var documento = Document.Create(container =>
        {
            container.Page(page =>
            {
                page.Size(PageSizes.A4);
                page.Margin(10);
                page.DefaultTextStyle(x => x.FontSize(5));

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
                                    col.Item().MaxWidth(40).MaxHeight(20).Image(logoPath);
                                    col.Item().PaddingTop(1);
                                }
                            }
                            
                            col.Item().Text(config?.NombreEmpresa ?? "BusOps Transportes S.L.")
                                .FontSize(6).Bold().FontColor("#003366");
                            col.Item().Text(config?.Direccion ?? "Calle Principal 123").FontSize(4);
                            col.Item().Text($"{config?.CodigoPostal ?? "28001"} {config?.Ciudad ?? "Madrid"}").FontSize(4);
                            col.Item().Text($"NIF: {config?.NIF ?? "B12345678"}").FontSize(4);
                            col.Item().Text($"Tel: {config?.Telefono ?? "910123456"}").FontSize(4);
                            if (!string.IsNullOrEmpty(config?.Email))
                            {
                                col.Item().Text($"Email: {config.Email}").FontSize(4);
                            }
                            if (!string.IsNullOrEmpty(config?.Web))
                            {
                                col.Item().Text($"Web: {config.Web}").FontSize(4);
                            }
                        });

                        // Datos del cliente y presupuesto (derecha)
                        row.RelativeItem().Column(col =>
                        {
                            // Encabezado PRESUPUESTO
                            col.Item().Background("#4CAF50").Padding(2).Column(c =>
                            {
                                c.Item().AlignCenter().Text("PRESUPUESTO").FontSize(7).Bold().FontColor(Colors.White);
                                c.Item().AlignCenter().Text(presupuesto.NumeroPresupuesto).FontSize(5).FontColor(Colors.White);
                            });
                            
                            col.Item().PaddingTop(1);
                            
                            // Cuadro de datos del cliente
                            col.Item().Background(Colors.Grey.Lighten3).Padding(2).Column(c =>
                            {
                                c.Item().Text("CLIENTE").Bold().FontSize(5).FontColor("#4CAF50");
                                
                                if (cliente.Tipo == TipoCliente.Particular)
                                {
                                    c.Item().Text($"{cliente.Nombre} {cliente.Apellidos}").FontSize(5).Bold();
                                }
                                else
                                {
                                    c.Item().Text(cliente.NombreEmpresa ?? "").FontSize(5).Bold();
                                    if (!string.IsNullOrEmpty(cliente.Nombre))
                                    {
                                        c.Item().Text($"Att: {cliente.Nombre}").FontSize(4);
                                    }
                                }
                                
                                c.Item().Text($"NIF/CIF: {cliente.NIF}").FontSize(4);
                                if (!string.IsNullOrEmpty(cliente.Direccion))
                                {
                                    c.Item().Text(cliente.Direccion).FontSize(4);
                                }
                                if (!string.IsNullOrEmpty(cliente.CodigoPostal) || !string.IsNullOrEmpty(cliente.Ciudad))
                                {
                                    c.Item().Text($"{cliente.CodigoPostal} {cliente.Ciudad}").FontSize(4);
                                }
                                if (!string.IsNullOrEmpty(cliente.Telefono))
                                {
                                    c.Item().Text($"Tel: {cliente.Telefono}").FontSize(4);
                                }
                                if (!string.IsNullOrEmpty(cliente.Email))
                                {
                                    c.Item().Text($"Email: {cliente.Email}").FontSize(4);
                                }
                            });
                        });
                    });

                    column.Item().PaddingTop(2);
                    
                    // Información del presupuesto
                    column.Item().Background(Colors.Grey.Lighten4).Padding(1).Row(row =>
                    {
                        row.AutoItem().Text($"Fecha Emisión: {presupuesto.FechaEmision:dd/MM/yyyy}").FontSize(4);
                        row.AutoItem().PaddingLeft(5).Text($"Válido hasta: {presupuesto.FechaValidez?.ToString("dd/MM/yyyy") ?? "N/A"}").FontSize(4);
                    });

                    column.Item().PaddingVertical(2).LineHorizontal(1).LineColor(Colors.Grey.Medium);
                });

                page.Content().Column(column =>
                {
                    // Concepto si existe
                    if (!string.IsNullOrEmpty(presupuesto.Concepto))
                    {
                        column.Item().Background("#fffbf0").BorderLeft(2).BorderColor("#FFC107")
                            .Padding(2).Text($"Concepto: {presupuesto.Concepto}").FontSize(5).Italic();
                        column.Item().PaddingVertical(1);
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
                            header.Cell().Background("#4CAF50").Padding(1)
                                .Text("Descripción").Bold().FontColor(Colors.White).FontSize(5);
                            header.Cell().Background("#4CAF50").Padding(1)
                                .AlignCenter().Text("Cant.").Bold().FontColor(Colors.White).FontSize(5);
                            header.Cell().Background("#4CAF50").Padding(1)
                                .AlignRight().Text("Precio Unit.").Bold().FontColor(Colors.White).FontSize(5);
                            header.Cell().Background("#4CAF50").Padding(1)
                                .AlignRight().Text("Subtotal").Bold().FontColor(Colors.White).FontSize(5);
                        });

                        foreach (var linea in presupuesto.Lineas)
                        {
                            table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(1)
                                .Column(col =>
                                {
                                    col.Item().Text(linea.Descripcion).Bold().FontSize(5);
                                    if (linea.Tipo == TipoLineaPresupuesto.CargoAdicional)
                                    {
                                        col.Item().Text("(Cargo Adicional)").FontSize(4).Italic().FontColor(Colors.Orange.Medium);
                                    }
                                });
                            table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(1)
                                .AlignCenter().Text(linea.Cantidad.ToString()).FontSize(5);
                            table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(1)
                                .AlignRight().Text(linea.PrecioUnitario.ToString("C2")).FontSize(5);
                            table.Cell().BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(1)
                                .AlignRight().Text(linea.Subtotal.ToString("C2")).Bold().FontSize(5);
                        }
                        
                        // ImporteConcepto si existe
                        if (presupuesto.ImporteConcepto > 0 && !string.IsNullOrEmpty(presupuesto.ConceptoCargos))
                        {
                            table.Cell().Background("#f1f8e9").BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(1)
                                .Column(col =>
                                {
                                    col.Item().Text(presupuesto.ConceptoCargos).Bold().FontSize(5);
                                    col.Item().Text("(Concepto Especial)").FontSize(4).Italic().FontColor(Colors.Green.Medium);
                                });
                            table.Cell().Background("#f1f8e9").BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(1).Text("");
                            table.Cell().Background("#f1f8e9").BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(1).Text("");
                            table.Cell().Background("#f1f8e9").BorderBottom(1).BorderColor(Colors.Grey.Lighten2).Padding(1)
                                .AlignRight().Text(presupuesto.ImporteConcepto.ToString("C2")).Bold().FontSize(5);
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

                        table.Cell().Padding(1).Text("Base Imponible:").Bold().FontSize(5);
                        table.Cell().Padding(1).AlignRight().Text(presupuesto.BaseImponible.ToString("C2")).FontSize(5);

                        table.Cell().Padding(1).Text($"IVA ({presupuesto.PorcentajeIVA}%):").Bold().FontSize(5);
                        table.Cell().Padding(1).AlignRight().Text(presupuesto.ImporteIVA.ToString("C2")).FontSize(5);

                        // Retención (si existe)
                        if (presupuesto.PorcentajeRetencion > 0)
                        {
                            table.Cell().Padding(1).Text($"Retención IRPF ({presupuesto.PorcentajeRetencion}%):").Bold().FontColor(Colors.Red.Medium).FontSize(5);
                            table.Cell().Padding(1).AlignRight().Text($"-{presupuesto.ImporteRetencion.ToString("C2")}").FontSize(5).FontColor(Colors.Red.Medium);
                        }

                        table.Cell().Background("#4CAF50").Padding(1).Text("TOTAL:").Bold().FontSize(6).FontColor(Colors.White);
                        table.Cell().Background("#4CAF50").Padding(1).AlignRight()
                            .Text(presupuesto.Total.ToString("C2")).Bold().FontSize(6).FontColor(Colors.White);
                    });

                    // Observaciones si existen
                    if (!string.IsNullOrEmpty(presupuesto.Observaciones))
                    {
                        column.Item().PaddingTop(2);
                        column.Item().Background(Colors.Grey.Lighten4).Padding(2).Column(col =>
                        {
                            col.Item().Text("Observaciones:").Bold().FontSize(5).FontColor("#4CAF50");
                            col.Item().Text(presupuesto.Observaciones).FontSize(4);
                        });
                    }
                    
                    // Nota de validez
                    column.Item().PaddingTop(2);
                    column.Item().Background("#e3f2fd").Padding(2).Column(col =>
                    {
                        col.Item().Text("Condiciones del Presupuesto").Bold().FontSize(5).FontColor("#4CAF50");
                        col.Item().Text("Este presupuesto es válido hasta la fecha indicada. Los precios incluyen IVA. Condiciones de pago según acuerdo.")
                            .FontSize(4).FontColor(Colors.Grey.Darken1);
                    });
                    
                    // Pie de página
                    column.Item().PaddingTop(2).BorderTop(1).BorderColor(Colors.Grey.Medium)
                        .PaddingTop(1).AlignCenter().Column(col =>
                        {
                            col.Item().Text($"Gracias por confiar en {config?.NombreEmpresa ?? "BusOps Transportes S.L."}")
                                .FontSize(4).Italic().FontColor(Colors.Grey.Darken1);
                            if (!string.IsNullOrEmpty(config?.IBAN))
                            {
                                col.Item().Text($"Datos bancarios: IBAN {config.IBAN}")
                                    .FontSize(4).FontColor(Colors.Grey.Darken1);
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
