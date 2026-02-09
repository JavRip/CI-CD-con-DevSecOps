# Usa una imagen base minimizada (Alpine)
FROM python:3.14.3-alpine3.23
# Crear un usuario no-root para mayor seguridad
RUN addgroup -g 1000 appuser && \
    adduser -u 1000 -G appuser -s /bin/sh -D appuser
# Crear el directorio de trabajo
WORKDIR /app
# Copiar e instalar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
# Cambiar al usuario no-root
USER appuser
# Copiar el código de la aplicación
COPY --chown=appuser:appuser . .
EXPOSE 5000
CMD ["python", "app.py"]