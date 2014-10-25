## Config Files

- Git
- Homebrew
- Ruby
- vim & MacVim
- [fish](http://fishshell.com/)
- [Zsh](http://www.zsh.org/) & [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

## Set Up

Pre-requisites:

  - Xcode (for MacVim)
  - [Homebrew](http://brew.sh/)
  - [Homebrew Cask](http://caskroom.io/)

Optional:

  - [dracula-theme](https://github.com/zenorocha/dracula-theme)
  - [tomorrow-theme](https://github.com/chriskempson/tomorrow-theme)

```
# backup existing rc files before proceeding

$ git clone --recursive https://github.com/gilbertwyw/dotfiles.git

# vim-specific
$ ln -s ~/vim/vimrc ~/.vimrc
$ ln -s ~/vim/gvimrc ~/.gvimrc

# fish shell
$ brew install fish # follow the instruction in (brew info fish)
$ ln -s ~/fish/config.fish ~/.config/fish/config.fish
$ ln -s ~/fish/functions ~/.config/fish/functions

# or, for Zsh
$ ln -s ~/zsh/zshrc ~/.zshrc

# Git
$ ln -s ~/git/gitconfig ~/.gitconfig
$ ln -s ~/git/gitignore_global ~/.gitignore_global

# Ruby
$ ln -s ~/ruby/gemrc ~/.gemrc

# SSH
$ mkdir ~/.ssh
$ ln -s  ~/ssh/config ~/.ssh/config

# Others
$ ln -s ~/agignore ~/.agignore
$ ln -s ~/editorconfig ~/.editorconfig

$ brew tap caskroom/fonts

```

## New machine / Re-installation
```
sudo xcodebuild -license
```

### Notes
"pvm_ls:26: no matches found: default" will be gone after `pvm install <version>`
