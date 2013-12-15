HOMEBREW_PATH=/usr/local/bin:/usr/local/sbin
NPM_PREFIX="$(npm config get prefix)"
export PATH=$HOMEBREW_PATH:$NPM_PREFIX/bin:$PATH

# for Homebrew installed rbenv; https://github.com/ryanb/dotfiles/blob/master/zshrc
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
