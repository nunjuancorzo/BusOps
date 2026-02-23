-- Migración 23: Añadir campos para certificado digital en ConfiguracionEmpresa

ALTER TABLE ConfiguracionEmpresa 
ADD COLUMN CertificadoRuta VARCHAR(500) NULL COMMENT 'Ruta al archivo del certificado digital (.pfx)',
ADD COLUMN CertificadoPassword VARCHAR(500) NULL COMMENT 'Contraseña encriptada del certificado';

SELECT 'Migración 23 completada: campos de certificado digital añadidos' AS resultado;
