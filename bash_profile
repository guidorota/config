export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=/usr/local/bin:$PATH
export PS1="\[$(tput setaf 6)\]\u@\h:\W$ \[$(tput sgr0)\]"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home/

export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export DOCKER_TLS_VERIFY=1
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/sidewinder/.boot2docker/certs/boot2docker-vm

alias op='open'
alias ll='ls -lh'
alias lla='ls -lha'
