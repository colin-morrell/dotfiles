#!/usr/bin/env bash
# symlink tracked dotfiles from this repo into $HOME (and copy the COPIES entries to Windows)
#
# each path below is relative to both this repo and $HOME, e.g. ".vimrc" links
# ~/.vimrc -> <repo>/.vimrc. existing files that aren't already the right link
# are moved to ~/.dotfiles-backup/<timestamp>/ before linking.
#
# usage: ./install.sh [-n]   (-n: dry run, print what would happen)

set -euo pipefail

FILES=(
    .vimrc
    .tmux.conf
    .zshrc
    .zshrc_aliases
    .p10k.zsh
    .gitconfig
    custom/.morrell_mods.sh
    .ipython/profile_default/ipython_config.py
    .ipython/profile_default/startup/10-logging-colors.py
    .ipython/profile_default/startup/20-rich-pretty.py
    .vim/after/syntax/python.vim
    .vim/after/syntax/json.vim
    .vim/after/syntax/yaml.vim
    .vim/config/airline.vim
    .vim/config/devicons.vim
    .vim/config/git.vim
    .vim/config/jedi.vim
    .vim/config/nerdtree.vim
    .vim/config/nerdtree-syntax-highlight.vim
    .vim/config/nerdtree-tabs.vim
    .vim/config/simpylfold.vim
    .vim/config/tmux-navigator.vim
    .vim/autoload/airline/extensions/default.vim
    .claude/CLAUDE.md
)

# copied, not linked: Windows apps can't read WSL symlinks on C:
# repo path -> Windows destination
declare -A COPIES=(
    [.glzr/glazewm/config.yaml]=/mnt/c/users/colin/.glzr/glazewm/config.yaml
)

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0
[[ "${1:-}" == "-n" ]] && DRY_RUN=1

run() {
    if (( DRY_RUN )); then
        echo "  would run: $*"
    else
        "$@"
    fi
}

for f in "${FILES[@]}"; do
    src="$REPO/$f"
    dest="$HOME/$f"

    if [[ ! -e "$src" ]]; then
        echo "skip     $f (not in repo)"
        continue
    fi

    if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
        echo "ok       $f"
        continue
    fi

    if [[ -e "$dest" || -L "$dest" ]]; then
        echo "backup   $f -> $BACKUP/$f"
        run mkdir -p "$(dirname "$BACKUP/$f")"
        run mv "$dest" "$BACKUP/$f"
    fi

    echo "link     $f"
    run mkdir -p "$(dirname "$dest")"
    run ln -s "$src" "$dest"
done

for f in "${!COPIES[@]}"; do
    src="$REPO/$f"
    dest="${COPIES[$f]}"

    if [[ -e "$dest" ]] && cmp -s "$src" "$dest"; then
        echo "ok       $f (copy)"
        continue
    fi

    if [[ -e "$dest" ]]; then
        echo "backup   $dest -> $BACKUP/$f"
        run mkdir -p "$(dirname "$BACKUP/$f")"
        run cp "$dest" "$BACKUP/$f"
    fi

    echo "copy     $f -> $dest"
    run mkdir -p "$(dirname "$dest")"
    run cp "$src" "$dest"
done
