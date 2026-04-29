#!/usr/bin/env bash
# JS Data Transfer — avvio rapido
# Uso: ./start.sh [porta]
# Richiede solo Node.js installato sulla macchina.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUNDLE="$SCRIPT_DIR/js-data-transfer.js"
PORT="${1:-7373}"

if ! command -v node &>/dev/null; then
  echo "[!] Node.js non trovato. Installalo con:"
  echo "    sudo apt install nodejs  (Debian/Ubuntu)"
  echo "    sudo dnf install nodejs  (Fedora/RHEL)"
  echo "    brew install node        (macOS)"
  exit 1
fi

NODE_VER=$(node -e "process.stdout.write(process.version.slice(1).split('.')[0])")
if [ "$NODE_VER" -lt 16 ]; then
  echo "[!] Node.js $NODE_VER troppo vecchio. Serve v16 o superiore."
  exit 1
fi

exec node "$BUNDLE" "$PORT"
