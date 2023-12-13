export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=/usr/local/bin:$PATH

export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='no=00;37:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# General aliases
alias op='open'
alias ll='ls -lh'
alias lla='ls -lha'
alias ..='cd ..'
alias ../..='cd ../..'
alias dl='cd ~/Downloads'

bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history

ulimit -n 1048576
