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

Create soft links for each of the items in the repo to the home directory. Don't
forget to backup and remove the existing items first.

```
mkdir ~/work_env_backup
mv ~/.vimrc ~/work_env_backup
ln -s ~/repos/work_env/.vimrc ~/.vimrc
```

## Dependencies

Optional minimums:
- FZF (ideally latest to be in step with the vim plugin)
- clang-format for vim
- gcc for vim
- pdflatex for vim (enable the LLP plugin as well)

Tools:
- Vim 7.x or 8.x (both are handled, but with reduced support for 7.x)
- Bash 4.x (may work on older versions as well)
- Git 1.8.4
- Tmux 2.8 (may work on lower 2.x versions)


## Bash

Include `.bash_private` before the FZF bash-ery is included in the `.bashrc`.

```
if [ -f $HOME/.bash_private ]; then
    . $HOME/.bash_private
fi
```


## Git

Include `.gitconfig_private` in the .gitconfig file.

```
[include]
    path = path/to/.gitconfig_private
```
