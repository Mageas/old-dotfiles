# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
#PROMPT='%{$fg[green]%}%~%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%} '
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# vi mode
bindkey -v
export KEYTIMEOUT=1

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mageas/.zshrc'

# Autocomplete
autoload -Uz compinit
compinit

# Plugins
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null