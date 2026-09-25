#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
NIXOS_DIR="$ROOT/nixos"

if [[ ! -f /etc/NixOS-release && ! -f /etc/os-release ]]; then
  echo "Ce script doit être exécuté sur NixOS."
  exit 1
fi

if [[ "$(id -u)" -eq 0 ]]; then
  echo "Lance install.sh avec ton utilisateur normal, pas directement en root."
  exit 1
fi

command -v nix >/dev/null || { echo "Nix est introuvable."; exit 1; }
command -v sudo >/dev/null || { echo "sudo est requis."; exit 1; }

mkdir -p "$NIXOS_DIR"

if [[ ! -f "$NIXOS_DIR/hardware-configuration.nix" ]]; then
  echo "Génération de la configuration matérielle..."
  sudo nixos-generate-config --show-hardware-config > "$NIXOS_DIR/hardware-configuration.nix"
fi

echo "Application de la configuration NixOS..."
sudo nixos-rebuild switch --flake "$NIXOS_DIR#nixos"

echo
echo "Configuration appliquée."
echo "Les configurations applicatives seront synchronisées par les fichiers du dépôt."
echo "Redémarrage en cours"
sudo reboot
