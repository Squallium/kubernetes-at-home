import json
import base64

# Leer JSON desde archivo
with open('secrets/config.json', 'r', encoding='utf-8') as f:
    config = json.load(f)

json_str = json.dumps(config, separators=(',', ':'))
b64_encoded = base64.b64encode(json_str.encode('utf-8')).decode('utf-8')

# Guardar en archivo
with open('secrets/config_base64.txt', 'w') as f:
    f.write(b64_encoded)

print("Base64 guardado en config_base64.txt")
