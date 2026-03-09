# zsh_colors.sh — Matugen-generated shell color variables
# Auto-generated — do not edit manually. Source in ~/.zshrc

# Core palette (hex with #)
export MATUGEN_PRIMARY='#cec6ab'
export MATUGEN_ON_PRIMARY='#35301d'
export MATUGEN_SECONDARY='#cdc6b4'
export MATUGEN_TERTIARY='#d0c7a2'
export MATUGEN_BACKGROUND='#141311'
export MATUGEN_FOREGROUND='#e6e2dd'
export MATUGEN_ERROR='#ffb4ab'
export MATUGEN_OUTLINE='#93908c'
export MATUGEN_SURFACE='#211f1d'

# Zsh syntax highlighting (works if zsh-syntax-highlighting is installed)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#cec6ab'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#cdc6b4'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#d0c7a2'
ZSH_HIGHLIGHT_STYLES[function]='fg=#cec6ab:bold'
ZSH_HIGHLIGHT_STYLES[string]='fg=#ebe2c6'
ZSH_HIGHLIGHT_STYLES[path]='fg=#e6e2dd,underline'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#93908c'
ZSH_HIGHLIGHT_STYLES[error]='fg=#ffb4ab:bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ffb4ab'

# Zsh autosuggestions (works if zsh-autosuggestions is installed)
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#93908c'

# fzf (if installed) — pick up matugen colors
export FZF_DEFAULT_OPTS="
  --color=bg+:#2b2a27
  --color=bg:#141311
  --color=border:#93908c
  --color=fg:#e6e2dd
  --color=fg+:#e6e2dd
  --color=header:#d0c7a2
  --color=hl:#cec6ab
  --color=hl+:#cec6ab:bold
  --color=info:#cdc6b4
  --color=marker:#cec6ab
  --color=pointer:#cec6ab
  --color=prompt:#cec6ab
  --color=spinner:#d0c7a2"
