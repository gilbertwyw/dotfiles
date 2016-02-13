# Config Files

- [Git](http://git-scm.com/)
- [Homebrew](http://brew.sh/)
- [Ruby](https://www.ruby-lang.org)
- [Zsh](http://www.zsh.org/) + [Antigen](https://zsh-users/antigen)
- [vim](http://www.vim.org/) & [MacVim](https://code.google.com/p/macvim/)

## Set Up

### Pre-requisites

- [Xcode](https://developer.apple.com/xcode/)
- [Homebrew](http://brew.sh/)

### Terminal themes (optional)

- [chriskempson/tomorrow-theme · GitHub](https://github.com/chriskempson/tomorrow-theme)
- [zenorocha/dracula-theme · GitHub](https://github.com/zenorocha/dracula-theme)

### Pure, ZSH prompt (Optional)

- [sindresorhus/pure · GitHub](https://github.com/sindresorhus/pure)

Steps:

```
# Backup existing rc files before proceeding

cd
git clone --recursive https://github.com/gilbertwyw/dotfiles.git

# vim
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim/gvimrc ~/.gvimrc

# Zsh
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/zsh ~/.zsh

# aliases
ln -s ~/dotfiles/aliases ~/.aliases

# Git
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/template ~/.git_template
ln -s ~/dotfiles/git/gitignore_global ~/.gitignore_global

# Ctags
ln -s ~/dotfiles/ctags ~/.ctags


# Others
ln -s ~/dotfiles/agignore ~/.agignore
ln -s ~/dotfiles/editorconfig ~/.editorconfig

# Install all Homebrew formulae listed in Brewfile
brew tap homebrew/brewdler
cd dotfiles/
brew brewdle [--dry-run]

```

## Java

```
brew install jenv
brew cask install java

jenv add `/usr/libexec/java_home`
```

## Neovim

- [Homebrew version](https://github.com/neovim/homebrew-neovim/blob/master/README.md)
- [vim-plug setup](https://github.com/junegunn/vim-plug#neovim)

To use the same configuration as Vim:

```
# '.vim/' may not exist (e.g., new machine), open Vim first
#'.config/' may not exist, `mkdir ~/.config`
ln -s ~/.vim ~/.config/nvim

ln -s ~/.vimrc ~/.config/nvim/init.vim

pip install [--user] neovim
```

## Ruby

### RubyGems

- [brigade/scss-lint · GitHub](https://github.com/brigade/scss-lint)
- [mivok/markdownlint · GitHub](https://github.com/mivok/markdownlint)
- [tmuxinator/tmuxinator · GitHub](https://github.com/tmuxinator/tmuxinator)

```
brew install chruby ruby-installer
ruby-installer ruby && chruby ruby

# if 'auto-switching' feature is enabled
echo "ruby-<version>" > ~/.ruby-version

ln -s ~/dotfiles/ruby/gemrc ~/.gemrc
gem install mdl scss_lint tmuxinator

```

## tmux

```
brew install tmux

ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

# provided that Tmuxinator has been installed
mux new [arbitrary name] 
```

## New machine / Re-installation

```
xcode-select --install

sudo xcodebuild -license
```
