# Setup

## Prerequisites

- [Homebrew](http://brew.sh/)

To prevent incompatibility issue caused by Mac's own version of `sed`:

```sh
brew install gnu-sed
```

Regarding "Github API Rate limit exceeded":

```sh
brew install direnv
echo "export HOMEBREW_GITHUB_API_TOKEN=<token>" > ~/.envrc
```

The commands in the following sections are assumed to be run after:

```sh
cd
git clone --recursive https://github.com/gilbertwyw/dotfiles.git
```

NB: Backup existing rc files before proceeding

## Zsh

- [Antibody](https://getantibody.github.io/)

```sh
brew install zsh antibody

ln -s ~/dotfiles/zsh/zsh_plugins.txt ~/.zsh_plugins.txt
ln -s ~/dotfiles/zsh/zshenv ~/.zshenv
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/zsh ~/.zsh

# require admin rights
echo '/usr/local/bin/zsh' >> /etc/shells

chsh -s /usr/local/bin/zsh

# aliases
brew install bat ddgr googler hub trash

ln -s ~/dotfiles/aliases ~/.aliases
```

## fzf

Run `brew install fzf ` and follow the instruction from `brew info fzf`.

## Git

```sh
brew install git git-lfs

ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/template ~/.git_template
ln -s ~/dotfiles/git/gitignore_global ~/.gitignore_global
```
## Python

```sh
mkdir -p ~/.pip
ln -s ~/dotfiles/python/pip.conf ~/.pip/pip.conf
```

```sh
# for vim "tagbar" plugin
pip install markdown2ctags
```

## Ruby

- [chruby](https://github.com/postmodern/chruby)
- [ruby-install](https://github.com/postmodern/ruby-install)

### RubyGems

- [brigade/scss-lint · GitHub](https://github.com/brigade/scss-lint)
- [mivok/markdownlint · GitHub](https://github.com/mivok/markdownlint)
- [tmuxinator/tmuxinator · GitHub](https://github.com/tmuxinator/tmuxinator)

```sh
brew install chruby ruby-install
ruby-install ruby && chruby ruby

# if 'auto-switching' feature is enabled
echo "ruby-<version>" > ~/.ruby-version

ln -s ~/dotfiles/ruby/gemrc ~/.gemrc
gem install mdl scss_lint tmuxinator
```

## tmux

NB: Make sure `<prefix>` is not used for other shortcut.

```sh
brew install tmux

ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/tmux ~/.tmux

<prefix> + I # to install any tmux plugins

# provided that Tmuxinator has been installed
tmuxinator new [arbitrary name]
```

## Vim

- [vim-plug](https://github.com/junegunn/vim-plug#vim)

```sh
# for 'deoplete.nvim'
brew install vim

ln -s ~/dotfiles/vim ~/.vim

vim +PlugInstall +qall
```

### Neovim

- [vim-plug](https://github.com/junegunn/vim-plug#neovim)

To use the same configuration as Vim:

```sh
# '.vim/' may not exist (e.g., new machine), open Vim first
#'.config/' may not exist, `mkdir ~/.config`
ln -s ~/.vim ~/.config/nvim

ln -s ~/.vim/vimrc ~/.config/nvim/init.vim

nvim +PlugInstall +UpdateRemotePlugins +qa
```

```sh
pip[3] install [--user] pynvim
npm i -g neovim
gem install neovim
```

## Miscs.

- [kitty](https://sw.kovidgoyal.net/kitty/index.html)
- [pgcli](https://www.pgcli.com/)
- [quick-look-plugins](https://github.com/sindresorhus/quick-look-plugins#install-all)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [starship](https://starship.rs)
- [youtube-dl](https://github.com/ytdl-org/youtube-dl)

```sh
ln -s ~/dotfiles/config/ripgreprc ~/.config

ln -s ~/dotfiles/config/starship.toml ~/.config

ln -s ~/dotfiles/config/youtube-dl ~/.config

ln -s ~/dotfiles/ignore ~/.ignore

# Ctags
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

ln -s ~/dotfiles/ctags ~/.ctags

# EditorConfig, http://editorconfig.org/
brew install editorconfig
ln -s ~/dotfiles/editorconfig ~/.editorconfig

# Brew Bundle, https://github.com/Homebrew/homebrew-bundle
brew tap homebrew/brewdler
cd dotfiles/
brew brewdle [--dry-run]
```

### Xcode

```sh
xcode-select --install

sudo xcodebuild -license
```
