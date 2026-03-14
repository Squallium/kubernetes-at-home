#!/bin/bash

set -e

BASE_PATH="secret"
BACKUP_DIR="backup"

echo "Restaurando secretos desde $BACKUP_DIR ..."
echo

find "$BACKUP_DIR" -type f -name "*.json" | while read file; do

  key=${file#"$BACKUP_DIR/"}
  key=${key%.json}

  echo "Importando secreto: $BASE_PATH/$key"

  data=$(jq -r 'to_entries|map("\(.key)=\(.value|tostring)")|.[]' "$file")

  if [ -z "$data" ]; then
    echo "  ⚠️  Secreto vacío, saltando"
    continue
  fi

  vault kv put "$BASE_PATH/$key" $data || echo "  ❌ Error importando $key"

done

echo
echo "✅ Importación completada"