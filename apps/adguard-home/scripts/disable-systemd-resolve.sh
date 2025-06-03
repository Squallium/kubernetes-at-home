#!/bin/bash

set -e

echo "🚧 Parando y desactivando systemd-resolved..."

sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved

echo "✅ systemd-resolved detenido y desactivado."

echo "🔁 Reconfigurando /etc/resolv.conf para usar 1.1.1.1..."

# Borrar el symlink si existe
if [ -L /etc/resolv.conf ]; then
  sudo rm /etc/resolv.conf
fi

# Crear un resolv.conf plano
echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf > /dev/null

echo "✅ /etc/resolv.conf actualizado:"
cat /etc/resolv.conf

echo "📢 ATENCIÓN: asegúrate de tener conectividad a DNS externa antes de ejecutar esto."
