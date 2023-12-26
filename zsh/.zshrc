# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd beep extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' max-errors 5
zstyle :compinstall filename '/home/abby/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Configuration of the terminal prompt 
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:*' formats ' <%F{red}%b%f>' # git(main)

setopt prompt_subst

PS1='%F{green}%n@%m%f$vcs_info_msg_0_ %~ $ '
# End of configuration of the termonal prompt

# Start of aliases
alias free='free -htw --si'
alias la='ls -alFh --group-directories-first'
alias mkdir='mkdir -v'
alias mv='mv -v'
alias cp='cp -v'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# End of aliases

