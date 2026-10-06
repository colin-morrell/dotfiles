# Global preferences

## Dotfiles are symlinks — don't break them
Every path in the FILES array of ~/dotfiles/install.sh is a real file in ~/dotfiles (git repo git@github.com:colin-morrell/dotfiles.git, branch win10-wsl) and a symlink at the same path under ~ (e.g. ~/.vimrc, ~/.vim/after/syntax/python.vim). Check FILES for the current list; install.sh creates the links.

- Never use plain `sed -i`, `cp`/`mv` onto the ~ path, or write-to-temp-and-rename on these files: each replaces the symlink with a regular file. Use `sed -i --follow-symlinks`, or edit the copy under ~/dotfiles directly.
- Before and after editing any dotfile in ~, check it's still a symlink (`ls -l`). If one was broken, copy the newer content into ~/dotfiles and recreate the link with `ln -sfn`.
- To track a new file: move it into ~/dotfiles, add it to FILES in install.sh, run install.sh.
- Windows Terminal settings.json is copied, not symlinked.

## Reply formatting
- Be brief. Answer what was asked and stop: no tangents, unrequested background, or offers of follow-up work unless something is actually broken or risky.
- Filepaths: always the full path, abbreviated with `~` only under /home/colin (e.g. *~/.ipython/profile_default/startup/10-logging-colors.py*); paths outside home stay absolute (*/mnt/c/Users/...*). Never a bare filename. Filepaths go in italics, and italics are used for nothing else.
- Bold is for stressed words and labels. Code (snippets, commands, settings, function/variable names) goes in inline code or fenced blocks. My terminal renders italics as Embark green and bold as Embark purple, so the distinction is visible.
- When moving or changing lines in a file, give the resulting line number(s).
- Every code block gets line numbers on each line, e.g.
  ```vim
  337  hi Visual ctermbg=LightCyan ctermfg=Black
  ```
  - Excerpts or edits of a file: the real line numbers in that file (look them up with grep -n / sed -n after editing, don't guess).
  - Suggested code for me to add to a file: the line numbers it would occupy once inserted.
  - Standalone code not tied to a file: number from 1.
  - Only exception: copy-paste shell commands stay unnumbered, since numbers would break pasting.

## Abbreviations
- Write "Windows Terminal" (any case) as "winterm", in replies and in code comments.

## Code style
- Single-line comments go on their own line above the code they describe, not inline at the end of the line.
- Keep code comments short: what the code does plus the one fact needed to see why. No narrating mechanisms or history; aim for 1-2 lines, e.g.
  ```vim
  1  " apply hi changes above right away for startup messages e.g. E325 (swap file warning)
  2  " otherwise they're drawn with default colors (white on red ErrorMsg)
  3  set highlight&
  ```

## Vim
- Never remind me to reload vim buffers (`:e`, `:e!`), and never mention .swp files or that a file may be open in vim. Just edit the file.

## Git
- I only use git from WSL (zsh in Windows Terminal), including for repos on /mnt/*. /mnt/c/Program Files/Git is an old unused Git for Windows install; don't raise WSL-vs-Git-for-Windows interop issues. Repos on /mnt/* still see every file as 777 through DrvFs, so `core.fileMode false` is worth setting there.

## Memory
- When I ask you to remember something and don't say where, ask whether I mean globally (this file, ~/.claude/CLAUDE.md) or just for the current project (the project's memory dir under ~/.claude/projects/) before saving it.
