# NixOS Config Chez Ma Mère

Configuration NixOS personnelle basée sur Nix flakes + Home Manager.

## Objectif

Reproduire l'environnement de bureau avec :

- MangoWC
- DankMaterialShell (DMS)
- Catppuccin Mocha
- Zsh
- Kitty
- Yazi
- Neovim
- Fastfetch
- Zen Browser
- VSCodium
- Spicetify
- FossaCursors

## Structure

```
.
├── install.sh
├── nixos/
│   ├── flake.nix
│   ├── configuration.nix
│   ├── home.nix
│   └── hardware-configuration.nix   # généré sur la machine
└── config/
    ├── DankMaterialShell/
    ├── fastfetch/
    ├── kitty/
    ├── yazi/
    ├── zen/
    └── zsh/
```

## Installation

Depuis une installation NixOS :

```bash
git clone https://github.com/Nielsniz-SVG/NixOS-Config-Chez-Ma-Mere.git
cd NixOS-Config-Chez-Ma-Mere
chmod +x install.sh
./install.sh
```

Le script prépare la configuration matérielle locale puis lance la configuration NixOS du dépôt.

> Les fichiers contenant des données privées ou propres à une machine (cookies, mots de passe, bases de données du profil Zen, etc.) ne sont pas versionnés.

## État

Le dépôt est construit progressivement à partir de la configuration actuelle. Les fichiers binaires et certaines configurations applicatives doivent encore être importés depuis la machine d'origine avant de considérer l'installation comme une copie complète.
