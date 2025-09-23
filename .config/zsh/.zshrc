# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# zmodload zsh/zprof

# https://github.com/Homebrew/brew/blob/master/docs/Manpage.md#--prefix---unbrewed---installed-formula-
if [[  -d /home/linuxbrew/.linuxbrew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ "$(uname -m)" = "x86_64" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
else
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# brew info zplug
export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "lib/key-bindings", from:oh-my-zsh
zplug "plugins/brew", from:oh-my-zsh
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "desyncr/auto-ls"
zplug "djui/alias-tips"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

# Then, source plugins and add commands to $PATH
zplug load

setopt auto_cd
setopt correct
setopt no_beep
setopt nocaseglob

# Do not write a duplicate event to the history file.
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE

path=(
  $HOME/.local/bin
  /usr/local/bin
  /usr/local/sbin
  $path
)

# brew info coreutils
[[ -f $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin ]] && path=("$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" $path)

if type go &>/dev/null; then
  path=($(go env GOPATH)/bin $path)
fi

typeset -U path

# brew info z
[[ -f $HOMEBREW_PREFIX/etc/profile.d/z.sh ]] && source $HOMEBREW_PREFIX/etc/profile.d/z.sh

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# load custom executable functions
for function in $ZDOTDIR/functions/*; do
  source $function
done

# key bindings
bindkey "^E" end-of-line

zle -N jump_after_first_word
bindkey "^x1" jump_after_first_word

# brew info fzf
eval "$(fzf --zsh)"

# brew install direnv, https://github.com/zimbatm/direnv#zsh
if type direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

# brew install starship
eval "$(starship init zsh)"

# brew isntall zoxide
eval "$(zoxide init --cmd j zsh)"

# https://docs.atuin.sh/guide/installation/#installing-the-shell-plugin
eval "$(atuin init zsh)"

# zprof

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
