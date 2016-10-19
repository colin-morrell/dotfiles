PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PS1="$ "
export PATH=$PATH:/usr/local/opt/go/libexec/bin

source ~/custom/.morrell_mods.sh
