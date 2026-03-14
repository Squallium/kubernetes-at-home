#!/bin/bash

mkdir -p backup

# Función recursiva
walk() {
  local path="$1"

  # Lista las claves y subcarpetas (KV v2 usa metadata para list)
  vault kv list -format=json "$path" 2>/dev/null | jq -r '.[]' | while read key; do
    key=$(echo "$key" | tr -d '\r')

    if [[ "$key" == */ ]]; then
      # Es una carpeta, recursión
      walk "$path$key"
    else
      # Es un secreto real
      echo "Exportando $path$key"

      # Ruta final del JSON
      outfile="backup/${path#secret/}$key.json"
      mkdir -p "$(dirname "$outfile")"

      # KV v2: la ruta real es data/secret/...
      vault kv get -format=json "$path$key" \
        | jq '.data.data' > "$outfile"
    fi
  done
}

# Comenzar desde el root de tu KV
walk secret/
