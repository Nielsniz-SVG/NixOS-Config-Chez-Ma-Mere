# ─────────────────────────────────────────────
# Zsh
# ─────────────────────────────────────────────

# ─────────────────────────────────────────────
# Catppuccin Mocha - couleurs Zsh
# ─────────────────────────────────────────────

typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[command]='fg=#89B4FA'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#89B4FA'
ZSH_HIGHLIGHT_STYLES[function]='fg=#89B4FA'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#89B4FA'

ZSH_HIGHLIGHT_STYLES[path]='fg=#CDD6F4'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#F9E2AF'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#CBA6F7'

ZSH_HIGHLIGHT_STYLES[comment]='fg=#6C7086'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#A6E3A1'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#A6E3A1'

ZSH_HIGHLIGHT_STYLES[redirection]='fg=#F5C2E7'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#F38BA8'


# ─────────────────────────────────────────────
# Catppuccin Mocha - palette
# ─────────────────────────────────────────────

CTP_BLUE='%F{#89B4FA}'
CTP_GREEN='%F{#A6E3A1}'
CTP_MAUVE='%F{#CBA6F7}'
CTP_YELLOW='%F{#F9E2AF}'
CTP_RED='%F{#F38BA8}'
CTP_TEAL='%F{#94E2D5}'
CTP_TEXT='%F{#CDD6F4}'
CTP_SUBTEXT='%F{#A6ADC8}'
CTP_OVERLAY='%F{#6C7086}'
CTP_RESET='%f'


# ─────────────────────────────────────────────
# Git
# ─────────────────────────────────────────────

autoload -Uz vcs_info

zstyle ':vcs_info:git:*' enable git

zstyle ':vcs_info:git:*' formats \
  '%F{#F9E2AF}%f %F{#1e1e2e} %b%f %F{#F9E2AF}%f'

zstyle ':vcs_info:git:*' actionformats \
  '%F{#F9E2AF}%f %F{#1e1e2e} %b (%a)%f %F{#F9E2AF}%f'

setopt PROMPT_SUBST


# ─────────────────────────────────────────────
# Prompt
# ─────────────────────────────────────────────

precmd() {
  vcs_info

  # Titre de la fenêtre Kitty
  print -Pn "\e]0;%~\a"
}

PROMPT='
%F{#89B4FA}╭─%f %F{#CDD6F4}  %~%f ''${vcs_info_msg_0_}
%F{#CBA6F7}╰─❯%f '


# ─────────────────────────────────────────────
# Zsh options
# ─────────────────────────────────────────────

setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY


# ─────────────────────────────────────────────
# History
# ─────────────────────────────────────────────

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000


# ─────────────────────────────────────────────
# Aliases
# ─────────────────────────────────────────────
fastfetch

alias editconf='nvim /etc/nixos/configuration.nix'
alias rebuild='sudo nixos-rebuild switch'
alias update='cd /etc/nixos && nix flake update'
alias upflake='sudo nixos-rebuild switch --flake /etc/nixos#nixos'

alias editerm='nvim ~/.config/kitty/kitty.conf'
alias editzsh='nvim ~/.zshrc'
alias soz='source ~/.zshrc'

alias delc='nix-collect-garbage'
alias updel="sudo nixos-rebuild switch --flake /etc/nixos#nixos >> nix-collect-garbage  "

alias alist='echo -e "Liste des alias\n================\neditconf : éditer la configuration\nrebuild   : reconstruire le système\nupdate   : mettre à jour les Flakes\nupflake  : reconstruire les Flakes\nediterm  : éditer la configuration de Kitty\neditzsh  : éditer la configuration de ZSH"'
alias y="yazi"
alias reball="sudo nixos-rebuild switch --flake /etc/nixos#nixos && reboot"


# ─────────────────────────────────────────────
# Éditeur par défaut
# ─────────────────────────────────────────────

export EDITOR="nvim"
export VISUAL="nvim"
