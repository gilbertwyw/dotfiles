# Setup

## Prerequisites

- [Homebrew](http://brew.sh/)
- [Homebrew Cask](https://caskroom.github.io/)

To prevent incompatibility issue caused by Mac's own version of `sed`:

```sh
brew install gnu-sed --with-default-names
```

Regarding "Github API Rate limit exceeded":

```sh
brew install bat direnv hub trash

echo "export HOMEBREW_GITHUB_API_TOKEN=<token>" > ~/.envrc
```

The commands in the following sections are assumed to be run after:

```sh
cd
git clone --recursive https://github.com/gilbertwyw/dotfiles.git
```

NB: Backup existing rc files before proceeding

## Zsh

- [zplug](https://github.com/zplug/zplug)

```sh
ln -s ~/dotfiles/zsh/zshenv ~/.zshenv
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/zsh ~/.zsh

brew install zsh zplug

# require admin rights
echo '/usr/local/bin/zsh' >> /etc/shells

chsh -s /usr/local/bin/zsh

# aliases
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

## Node.js

- [n-install](https://github.com/mklement0/n-install)

```sh
# will prompt before continue
curl -L http://git.io/n-install | bash
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

```sh
# for 'deoplete.nvim'
brew install vim --with-lua --with-python3
pip3 install neovim

ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim/gvimrc ~/.gvimrc

ln -s ~/dotfiles/vim/git-commit-editor ~/.git-commit-editor
```

Then run `vim +PlugInstall +qall` in Vim

### Neovim 

- [Homebrew version](https://github.com/neovim/homebrew-neovim/blob/master/README.md)
- [vim-plug setup](https://github.com/junegunn/vim-plug#neovim)

To use the same configuration as Vim:

```sh
# '.vim/' may not exist (e.g., new machine), open Vim first
#'.config/' may not exist, `mkdir ~/.config`
ln -s ~/.vim ~/.config/nvim

ln -s ~/.vimrc ~/.config/nvim/init.vim

pip install [--user] neovim
```

## Miscs.

- [quick-look-plugins](https://github.com/sindresorhus/quick-look-plugins#install-all)

```sh
# Ag
brew install ag
ln -s ~/dotfiles/ignore ~/.ignore

# Ctags
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags

ln -s ~/dotfiles/ctags ~/.ctags

# EditorConfig, http://editorconfig.org/
brew install editorconfig
ln -s ~/dotfiles/editorconfig ~/.editorconfig

# Brew Bundle, https://github.com/Homebrew/homebrew-bundle
brew tap homebrew/brewdler
cd dotfiles/
brew brewdle [--dry-run]
```

### Terminal themes

- [chriskempson/tomorrow-theme · GitHub](https://github.com/chriskempson/tomorrow-theme)
- [zenorocha/dracula-theme · GitHub](https://github.com/zenorocha/dracula-theme)

### Typefaces

- [Hack](https://github.com/chrissimpkins/Hack#os-x)

### ZSH prompt

- [sindresorhus/pure · GitHub](https://github.com/sindresorhus/pure)

### Xcode

```sh
xcode-select --install

sudo xcodebuild -license
```
