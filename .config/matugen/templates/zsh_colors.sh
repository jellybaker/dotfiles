# zsh_colors.sh — Matugen-generated shell color variables
# Auto-generated — do not edit manually. Source in ~/.zshrc

# Core palette (hex with #)
export MATUGEN_PRIMARY='{{colors.primary.default.hex}}'
export MATUGEN_ON_PRIMARY='{{colors.on_primary.default.hex}}'
export MATUGEN_SECONDARY='{{colors.secondary.default.hex}}'
export MATUGEN_TERTIARY='{{colors.tertiary.default.hex}}'
export MATUGEN_BACKGROUND='{{colors.surface.default.hex}}'
export MATUGEN_FOREGROUND='{{colors.on_surface.default.hex}}'
export MATUGEN_ERROR='{{colors.error.default.hex}}'
export MATUGEN_OUTLINE='{{colors.outline.default.hex}}'
export MATUGEN_SURFACE='{{colors.surface_container.default.hex}}'

# Zsh syntax highlighting (works if zsh-syntax-highlighting is installed)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg={{colors.primary.default.hex}}'
ZSH_HIGHLIGHT_STYLES[builtin]='fg={{colors.secondary.default.hex}}'
ZSH_HIGHLIGHT_STYLES[alias]='fg={{colors.tertiary.default.hex}}'
ZSH_HIGHLIGHT_STYLES[function]='fg={{colors.primary.default.hex}}:bold'
ZSH_HIGHLIGHT_STYLES[string]='fg={{colors.on_primary_container.default.hex}}'
ZSH_HIGHLIGHT_STYLES[path]='fg={{colors.on_surface.default.hex}},underline'
ZSH_HIGHLIGHT_STYLES[comment]='fg={{colors.outline.default.hex}}'
ZSH_HIGHLIGHT_STYLES[error]='fg={{colors.error.default.hex}}:bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg={{colors.error.default.hex}}'

# Zsh autosuggestions (works if zsh-autosuggestions is installed)
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg={{colors.outline.default.hex}}'

# fzf (if installed) — pick up matugen colors
export FZF_DEFAULT_OPTS="
  --color=bg+:{{colors.surface_container_high.default.hex}}
  --color=bg:{{colors.surface.default.hex}}
  --color=border:{{colors.outline.default.hex}}
  --color=fg:{{colors.on_surface.default.hex}}
  --color=fg+:{{colors.on_surface.default.hex}}
  --color=header:{{colors.tertiary.default.hex}}
  --color=hl:{{colors.primary.default.hex}}
  --color=hl+:{{colors.primary.default.hex}}:bold
  --color=info:{{colors.secondary.default.hex}}
  --color=marker:{{colors.primary.default.hex}}
  --color=pointer:{{colors.primary.default.hex}}
  --color=prompt:{{colors.primary.default.hex}}
  --color=spinner:{{colors.tertiary.default.hex}}"
