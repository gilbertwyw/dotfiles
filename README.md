# Setup

## Prerequisites

- [Homebrew](http://brew.sh/)
- [GNU Stow](https://www.gnu.org/software/stow/)

```sh
brew install bat ddgr direnv fd fzf go ripgrep starship stow trash universal-ctags zoxide

# For Github API Rate limit
# https://github.com/Homebrew/brew/blob/master/docs/Manpage.md#environment
echo "export HOMEBREW_GITHUB_API_TOKEN=<token>" > ~/.envrc
```

```sh
git clone --recursive https://github.com/gilbertwyw/dotfiles.git
cd dotfiles

# use -n to see any filesystem changes
stow -v -R [-n] .
```

## Zsh

- [zplug](https://github.com/zplug/zplug)

```sh
brew install zsh zplug

echo "$HOMEBREW_PREFIX/bin/zsh" | sudo tee -a /etc/shells
chsh -s $HOMEBREW_PREFIX/bin/zsh
```

## fzf

```sh
brew install fzf

# install keybindings
$HOMEBREW_PREFIX/opt/fzf/install
```

## Git

```sh
brew install git git-delta git-lfs gh
```

## Ruby

- [chruby](https://github.com/postmodern/chruby)
- [ruby-install](https://github.com/postmodern/ruby-install)

### RubyGems

```sh
brew install chruby ruby-install
ruby-install ruby && chruby ruby

# if 'auto-switching' feature is enabled
echo "ruby-<version>" > ~/.ruby-version
```

## tmux

NB: Make sure `<prefix>` is not used for other shortcut.

```sh
brew install tmux
```

## Neovim

```sh
brew install neovim

# Run all healthchecks in Neovim
:checkhealth
```

## Misc.

- [EditorConfig](https://editorconfig.org)
- [kitty](https://sw.kovidgoyal.net/kitty/index.html)
- [pgcli](https://www.pgcli.com/)
- [quick-look-plugins](https://github.com/sindresorhus/quick-look-plugins#install-all)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [youtube-dl](https://github.com/ytdl-org/youtube-dl)
- [Universal Ctags](https://github.com/universal-ctags/homebrew-universal-ctags#usage)

### Homebrew Bundle

- [homebrew-bundle](https://github.com/Homebrew/homebrew-bundle)

```sh
cd dotfiles/
brew brewdle [--dry-run]
```

### Xcode

```sh
xcode-select --install

sudo xcodebuild -license
```
