#!/bin/zsh

export PATH=$PATH:~/custom


###############################################################
# --> LS_COLORS
###############################################################

# one entry per line, joined with ':' into LS_COLORS below
ls_colors=(
    # dirs, other-writable dirs (everything on /mnt/*), executables
    'di=1;92'
    'ow=1;92'
    'ex=0;0;31'

    # config files
    '*.conf=0;34'
    '*.sh=0;34'
    '*.toml=0;34'
    '*.vim=0;34'
    '*.vimrc=0;34'
    '*.yaml=0;34'
    '*.zsh=0;34'
    '*.zshrc=0;34'

    # data
    '*.csv=0;33'
    '*.json=0;33'
    '*.md=0;33'

    # code
    '*.py=0;95'

    # media
    '*.wav=0;34'
    '*.mp3=0;34'
    '*.jpg=0;33'
    '*.jpeg=0;33'
    '*.png=0;33'
    '*.tif=0;33'

    # office docs
    '*.pdf=0;30;100'
    '*.docx=0;30;100'
    '*.pptx=0;30;100'
    '*.xlsx=0;30;100'

    # archives / installers
    '*.zip=1;34'
    '*.tar=1;34'
    '*.gz=1;34'
    '*.dmg=0;31'

    # keys
    '*.pem=0;31'
    '*.pub=0;32'

    # faded
    '*.bash_profile=0;90'
    '*.gitattributes=0;90'
    '*.gitconfig=0;90'
    '*.gitignore=0;90'
    '*.lock=0;90'
    '*.pyc=0;90'
    '*.stl=0;90'
    '*.swo=0;90'
    '*.swp=0;90'
    '*.zshrc_aliases=0;90'

    # faded (macOS)
    '*.DS_STORE=0;90'
    '*.localized=0;90'
)
LS_COLORS=${(j.:.)ls_colors}
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
##### SHORTIES #####
alias gc='git commit -m'
alias gs='git status --short'
alias ls='ls -ah --color --group-directories-first'
alias ll='ls -lah --color --group-directories-first'
alias t='tree -a -I ".git|.mypy_cache|__pycache__|.venv"'

##### GENERAL #####
alias pbcopy='powershell.exe -Command "Set-Clipboard -Value \$input"'
alias pbpaste='powershell.exe -Command "Get-Clipboard"'
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
alias 3dipy='3dpy && uv run ipython -i ipython_startup.py'

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

# 'example text' in every text color (normal + bold), then every background with black text
# skips 0;30 and 30;40 (black on black)
function colorshow()
{
    for s in 0 1; do for f in {30..37} {90..97}; do
        [[ "$s;$f" == '0;30' ]] && continue
        printf '\e[%sm example text \e[0m  %s\n' "$s;$f" "$s;$f"
    done; done
    for b in {41..47} {100..107}; do printf '\e[30;%sm example text \e[0m  30;%s\n' $b $b; done
}


# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=500000
HISTCONTROL=ignoreboth
HISTIGNORE='ls:history'
PROMPT_COMMAND='history -a'
