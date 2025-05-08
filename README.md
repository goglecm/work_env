# Standard linux environment

Contains configuration and plugin files for the following:
- Git
- Bash
- Vim
- Tmux


# Installation

## General points

Don't forget to do a `git submodule init && git submodule update`.

## Setup

Don't forget to backup and remove the existing items first.

```
mkdir ~/work_env_backup
mv ~/.bash_private ~/work_env_backup
mv ~/.gitconfig_private ~/work_env_backup
```

Create soft links for each of the items in the repo to the home directory. 

```
ln -s ~/repos/work_env/.bash_private .bash_private
ln -s ~/repos/work_env/.gitconfig_private .gitconfig_private
ln -s ~/repos/work_env/.tmux .tmux
ln -s ~/repos/work_env/.tmux.conf .tmux.conf
ln -s ~/repos/work_env/.vim .vim
ln -s ~/repos/work_env/.vimrc .vimrc
```

Create your own git and shell profiles. Here are some minimal examples:

For `.bash_profile` do:

```
. ~/.bashrc
```

For `.bashrc` do:

```
export LC_ALL=C
export LANGUAGE=en_GB.UTF-8
export LANG=en_GB.UTF-8
export TZ=Europe/London

[ -f ~/.bash_private ] && source ~/.bash_private
```

For `.cshrc` do:

```
setenv EDITOR vim
setenv PAGER less
setenv LPDEST lp
setenv TERM xterm-256color
```

For `.gitconfig` do:

```
[user]
        name = My Name
        email = my_email@email.com
[core]
        preloadindex = true
        editor = vim
[pager]
        log = true
        diff = true
[push]
        default = simple
[include]
        path = ~/.gitconfig_private
```

Additionally, setup some git hooks. Create `.githooks/pre-commit` with the following:

```
#!/bin/sh

# Apply colours only if stdout is a terminal.
if [ -t 1 ]; then
    red="\033[1;31m"
    color_end="\033[0m"
else
    red=""
    color_end=""
fi

# Check unwanted trailing whitespace or space/tab indents.
if [[ `git diff --cached --check` ]]; then
    echo -e ${red}Commit failed because of a whitespace error${color_end}
    git diff --cached --check
    exit 1
fi
```

Any further Vim settings should go in `~/.vimrc_private`.

Optionally, install FZF at this point and allow it to update and generate the prepend for scripts:

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## Dependencies

Optional minimums:
- FZF (ideally latest to be in step with the vim plugin)
- `clang-format` for vim
- `gcc` for vim
- `pdflatex` for vim (enable the LLP plugin as well)

Tools:
- Vim 7.x or 8.x (both are handled, but with reduced support for 7.x)
- Bash 4.x (may work on older versions as well)
- Git 1.8.4
- Tmux 2.8 (may work on lower 2.x versions)

## Working directories

Vim will create the following directories:
- `~/.vim_undo` to store undo information.
- `~/.vim_swp` for the swap files it uses.
- `~/.vim_tags` to store the tags found by gutentags.
- `~/.vim/spell/en.utf-8.add` will be used for the new words in the dictionary.

Vim will also add `~/.fzf` to the runtime path (`rtp`), and source `~/.vimrc_private` for extra options to vim.
