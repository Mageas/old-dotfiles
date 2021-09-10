# Colors
autoload -U colors && colors

# Terminal config
stty stop undef   # Disable ctrl-s to freeze terminal.

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Load aliases and binds if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/bindrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/bindrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/spaceshiprc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/spaceshiprc"

# PATH
export PATH=$PATH:$HOME/.local/bin

# Autocomplete
autoload -Uz compinit
compinit
_comp_options+=(globdots)   # Include hidden files.

# Spaceship
autoload -U promptinit; promptinit
prompt spaceship

# gitlab.com/dwt1/shell-color-scripts
# sh-colorscript random

# Spark
echo; echo; seq 1 $(tput cols) | sort -R | spark | lolcat; echo; echo;

# Plugins
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
