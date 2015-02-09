# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias ls='ls -FC --color'

export P4CONFIG=.p4config
export P4PORT=p4p-cbg.corp.roku:1999
export EDITOR=vim
test -f /etc/bash_completion.d && source /etc/bash_completion.d/git-prompt
test -f /usr/share/bash-completion && source /usr/share/bash-completion/completions/git

settitle() {
    test -f /usr/bin/xtitle && xtitle $(basename $PWD)
}

#export PS1="\[\e[00;35m\]\h\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[00;32m\]\W\[\e[0m\]$ "
export PS1
test -f /etc/fedora-release && dist=fedora:

PS1="\[\e[00;33m\]$dist\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[00;32m\]\h\[\e[0m\]\[\e[00;37m\]:[\[\e[0m\]\[\e[00;35m\]\W\[\e[0m\]\[\e[00;37m\]]\[\e[0m\]\[\e[00;36m\]:\[\e[0m\]\[\e[00;37m\] \[\e[0m\]"

cd () {
    builtin cd $* && test -f /usr/bin/xtitle && xtitle $(basename $PWD)
}
export PROMPT_COMMAND=

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
source /etc/profile.d/bash_completion.sh

tmux() {
    TERM=xterm-256color /usr/bin/tmux -2 $*

function telnet {
   xtitle "telnet $*"
   /usr/bin/telnet $*
   cd $PWD
}

function picocom {
    banner=$(echo $*|sed -e 's!.*/!/!')
    xtitle "picocom $banner"
    /usr/bin/picocom $*
    cd $PWD
}
