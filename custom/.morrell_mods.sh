#!/bin/zsh

export PATH=$PATH:~/custom


###############################################################
# --> LS_COLORS
###############################################################

#  dir --> bold cyan
#  swp --> norm darkgrey
#   py --> bold purple
# json --> norm white
LS_COLORS='di=1;92:ow=1;92:ex=0;37;41:*.swp=0;90:*.py=0;95:*.json=0;96:*.csv=0;96:*.wav=0;34:*.mp3=0;34:*.pdf=0;30;100:*.docx=0;30;100:*.pptx=0;30;100:*.xlsx=0;30;100:*.jpg=0;33:*.jpeg=0;33:*.png=0;33:*.tif=0;33:*.DS_STORE=0;90:*.localized=0;90:*.dmg=0;31:*.zip=1;34:*.tar=1;34:*.gz=1;34:*.pem=0;31:*.pub=0;32:*.md=0;93'
#LS_COLORS='di=0;36:*.black.norm=0;30:*.black.bold=1;30:*.red.norm=0;31:*.red.bold=1;31:*.green.norm=0;32:*.green.bold=1;32:*.orange.norm=0;33:*.orange.bold=1;33:*.blue.norm=0;34:*.blue.bold=1;34:*.purp.norm=0;35:*.purp.bold=1;35:*.cyan.norm=0;36:*.cyan.bold=1;36:*.grey.norm=0;37:*.grey.bold=1;37:*.grey.dark.norm=0;90:*.grey.dark.bold=1;90:*.red.light.norm=0;91:*.red.light.bold=1;91:*.green.light.norm=0;92:*.green.light.bold=1;92:*.yellow.norm=0;93:*.yellow.bold=1;93:*.blue.light.norm=0;94:*.blue.light.bold=1;94:*.purp.light.norm=0;95:*.purp.light.bold=1;95:*.turq.norm=0;96:*.turq.bold=1;96:*.white.norm=0;97:*.white.bold=1;97'
export LS_COLORS


###############################################################
# --> ZSH STUFF
###############################################################

# use LS_COLORS for zsh tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&'

# reload zsh without breaking p10k
alias reload='clear && exec zsh'


###############################################################
# --> ALIASES
###############################################################

##### GENERAL #####
alias ls='ls -ah --color --group-directories-first'
alias ll='ls -lah --color --group-directories-first'
alias pbcopy='powershell.exe -Command "Set-Clipboard -Value \$input"'
alias pbpaste='powershell.exe -Command "Get-Clipboard"'

#alias colors='for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done'
alias count='sort | uniq -c | sort -n | tail -r'
alias honeycomb='python ~/custom/honeycomb.py'
alias jless='jq -C | less -R'
alias json="jq '.'"
alias pdw='pwd'
alias tac='tail -r'  # TODO --> 10.03.26 broken on WSL
alias whattime='python ~/custom/whattime.py'
# enable exact (24-bit) theme colors inside tmux
alias claude='COLORTERM=truecolor claude'  

##### CONFIGS #####
alias ahkcfg='vi /mnt/e/scripts/custom.ahk'
alias glazecfg='vi ~/dotfiles/.glzr/glazewm/config.yaml && cp ~/dotfiles/.glzr/glazewm/config.yaml /mnt/c/users/colin/.glzr/glazewm/config.yaml'
alias ipycfg='vi /home/colin/.ipython/profile_default/ipython_config.py'
alias mmod='vi /home/colin/custom/.morrell_mods.sh'
alias tmuxcfg='vi /home/colin/.tmux.conf'
alias vimcfg='vi /home/colin/.vimrc'

##### CD SHORTCUTS #####
alias cd3dp='cd /mnt/e/3dp/'
alias 3dpy='cd /home/colin/3dp/3dpy'
alias 3dipy='3dpy && poetry env activate && poetry run -v ipython'

##### PYTHON #####
alias flake8='flake8 --max-line-length 99 --extend-ignore=W605'
alias ipython="clear && ~/.local/bin/ipython"  # pipx install (pipx upgrade ipython)


###############################################################
# --> FUNCTIONS
###############################################################

function ipgrab()
{
read line; echo $line | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}';
while read line; do echo $line | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'; done
echo $line | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}';
}


# TODO --> 10.03.26 broken on WSL
shrug(){ echo -n "¯\_(ツ)_/¯" | (pbcopy);echo "¯\_(ツ)_/¯ copied to your clipboard"; }


# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=500000
HISTCONTROL=ignoreboth
HISTIGNORE='ls:history'
PROMPT_COMMAND='history -a'
