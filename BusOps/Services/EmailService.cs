using System.Net;
using System.Net.Mail;
using Microsoft.Extensions.Options;

namespace BusOps.Services;

public class EmailService
{
    private readonly EmailConfiguration _config;

    public EmailService(IOptions<EmailConfiguration> config)
    {
        _config = config.Value;
    }

    public async Task<bool> EnviarFacturaPorEmailAsync(string destinatario, string asunto, string cuerpoHtml, byte[]? pdfFactura = null, string nombreArchivoPdf = "factura.pdf")
    {
        try
        {
            using var smtpClient = new SmtpClient(_config.SmtpServer, _config.SmtpPort)
            {
                EnableSsl = _config.UseSsl,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(_config.Username, _config.Password)
            };

            using var mailMessage = new MailMessage
            {
                From = new MailAddress(_config.FromEmail, _config.FromName),
                Subject = asunto,
                Body = cuerpoHtml,
                IsBodyHtml = true
            };

            mailMessage.To.Add(destinatario);

            // Agregar el PDF como adjunto si existe
            if (pdfFactura != null && pdfFactura.Length > 0)
            {
                var attachment = new Attachment(new MemoryStream(pdfFactura), nombreArchivoPdf, "application/pdf");
                mailMessage.Attachments.Add(attachment);
            }

            await smtpClient.SendMailAsync(mailMessage);
            return true;
        }
        catch (Exception ex)
        {
            // Log the error (en producción usar ILogger)
            Console.WriteLine($"Error al enviar email: {ex.Message}");
            return false;
        }
    }

    public async Task<bool> EnviarPresupuestoPorEmailAsync(string destinatario, string asunto, string cuerpoHtml, byte[]? pdfPresupuesto = null, string nombreArchivoPdf = "presupuesto.pdf")
    {
        try
        {
            using var smtpClient = new SmtpClient(_config.SmtpServer, _config.SmtpPort)
            {
                EnableSsl = _config.UseSsl,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(_config.Username, _config.Password)
            };

            using var mailMessage = new MailMessage
            {
                From = new MailAddress(_config.FromEmail, _config.FromName),
                Subject = asunto,
                Body = cuerpoHtml,
                IsBodyHtml = true
            };

            mailMessage.To.Add(destinatario);

            // Agregar el PDF como adjunto si existe
            if (pdfPresupuesto != null && pdfPresupuesto.Length > 0)
            {
                var attachment = new Attachment(new MemoryStream(pdfPresupuesto), nombreArchivoPdf, "application/pdf");
                mailMessage.Attachments.Add(attachment);
            }

            await smtpClient.SendMailAsync(mailMessage);
            return true;
        }
        catch (Exception ex)
        {
            // Log the error (en producción usar ILogger)
            Console.WriteLine($"Error al enviar email de presupuesto: {ex.Message}");
            return false;
        }
    }
}

public class EmailConfiguration
{
    public string SmtpServer { get; set; } = string.Empty;
    public int SmtpPort { get; set; }
    public bool UseSsl { get; set; }
    public string Username { get; set; } = string.Empty;
    public string Password { get; set; } = string.Empty;
    public string FromEmail { get; set; } = string.Empty;
    public string FromName { get; set; } = string.Empty;
}
