# Setup

## Prerequisites

- [Homebrew](http://brew.sh/)
- [GNU Stow](https://www.gnu.org/software/stow/)

```sh
brew install bat ddgr googler hub trash direnv

# Regarding "Github API Rate limit exceeded"
echo "export HOMEBREW_GITHUB_API_TOKEN=<token>" > ~/.envrc
```

```sh
git clone --recursive https://github.com/gilbertwyw/dotfiles.git
cd dotfiles

# use -n to see any filesystem changes
stow -v [-n] .
```

## Zsh

- [Antibody](https://getantibody.github.io/)


```sh
brew install zsh antibody

echo '/usr/local/bin/zsh' >> /etc/shells
chsh -s /usr/local/bin/zsh
```

## fzf

Run `brew install fzf ` and follow the instruction from `brew info fzf`.

## Git

```sh
brew install git git-lfs
```
## Python

```sh
# https://github.com/preservim/tagbar/wiki#markdown
pip install --user markdown2ctags
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

- [vim-plug](https://github.com/junegunn/vim-plug#neovim)

```sh
brew install --HEAD neovim

nvim +PlugInstall +UpdateRemotePlugins +qa

# in nvim
:checkhealth
```

## Miscs.

- [EditorConfig](https://editorconfig.org)
- [kitty](https://sw.kovidgoyal.net/kitty/index.html)
- [pgcli](https://www.pgcli.com/)
- [quick-look-plugins](https://github.com/sindresorhus/quick-look-plugins#install-all)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [starship](https://starship.rs)
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
