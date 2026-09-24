# NixOS Config Chez Ma Mère

Configuration NixOS personnelle basée sur Nix flakes + Home Manager.

## Installation dans une machine virtuelle

Depuis une installation NixOS fraîche :

### 1. Cloner le dépôt

```bash
git clone https://github.com/Nielsniz-SVG/NixOS-Config-Chez-Ma-Mere.git
cd NixOS-Config-Chez-Ma-Mere
```

### 2. Générer la configuration matérielle de la VM

```bash
sudo nixos-generate-config
sudo cp /etc/nixos/hardware-configuration.nix nixos/hardware-configuration.nix
```

Le fichier `hardware-configuration.nix` est spécifique à chaque machine et n'est pas versionné.

### 3. Vérifier le Flake

```bash
cd nixos
nix flake check
cd ..
```

### 4. Installer la configuration

```bash
chmod +x install.sh
./install.sh
```

Le script applique ensuite la configuration NixOS du dépôt.

> Le dépôt est encore en construction : certains fichiers binaires et certaines configurations applicatives doivent encore être importés avant de considérer l'installation comme une copie complète.

## Objectif

Reproduire l'environnement avec MangoWC, DankMaterialShell, Catppuccin Mocha, Zsh, Kitty, Yazi, Neovim, Fastfetch, Zen Browser, VSCodium, Spicetify et FossaCursors.

> Les données privées d'un profil (cookies, mots de passe, bases de données Zen, etc.) ne sont pas versionnées.
