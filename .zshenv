export ZDOTDIR=$HOME/.config/zsh

# To make all entries of `locale` use "en_US.UTF-8"
export LANG=en_US.UTF-8
export LC_ALL=$LANG

export EDITOR=nvim

# `brew install fd`, https://github.com/sharkdp/fd
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--height 50% --info inline --preview 'bat --style=numbers --color=always --line-range :30 {}'"

# `brew info coreutils`
export MANPATH="/usr/local/coreutils/libexec/gnuman:$MANPATH"

# brew install ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgreprc"
