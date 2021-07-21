# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/user/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PROMPT='
%F{green}[ %F{blue}%~ %F{green}]
%F{green}﬌ %F{white}'

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias ls="ls --color=auto"
alias o="./out"
alias oi="./out < input"
alias off="sleep 1 && xset dpms force off"

export PATH=$PATH:~/.cargo/bin:~/.scripts
