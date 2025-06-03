#!/bin/bash

# Obtener el hostname actual del sistema
HOSTNAME=$(hostname)

# Verificar si el hostname ya está presente en /etc/hosts
if grep -q "$HOSTNAME" /etc/hosts; then
  echo "✅ El hostname '$HOSTNAME' ya está presente en /etc/hosts."
  exit 0
fi

# Añadir la línea 127.0.1.1 <hostname> justo después de 127.0.0.1 localhost
echo "🔧 Añadiendo '127.0.1.1 $HOSTNAME' a /etc/hosts..."

sudo sed -i "/^127.0.0.1\s\+localhost/a 127.0.1.1\t$HOSTNAME" /etc/hosts

echo "✅ Reparado. Contenido actual de /etc/hosts:"
grep -E '127.0.0.1|127.0.1.1' /etc/hosts
