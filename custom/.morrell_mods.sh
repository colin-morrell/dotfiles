#!/bin/bash

export PATH=$PATH:~/custom

alias ls="ls -G"
alias pdw="pwd"
alias json="jq '.'"
alias tac='tail -r'
alias updatedb="sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist"
alias whattime='python ~/custom/whattime.py'
alias honeycomb='python ~/custom/honeycomb.py'

# workaround for tmux
alias vi='TERM=screen-256color vi'
alias vim='TERM=screen-256color vim'


function ipgrab()
{
read line; echo $line | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}';
while read line; do echo $line | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'; done
echo $line | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}';
}


shrug(){ echo -n "¯\_(ツ)_/¯" | (pbcopy);echo "¯\_(ツ)_/¯ copied to your clipboard"; }


# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=500000
HISTCONTROL=ignoreboth
HISTIGNORE='ls:history'
PROMPT_COMMAND='history -a'


if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
