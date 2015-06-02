# Config Files

- [Git](http://git-scm.com/)
- [Homebrew](http://brew.sh/)
- [Ruby](https://www.ruby-lang.org)
- [Zsh](http://www.zsh.org/) & [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [fish](http://fishshell.com/)
- [vim](http://www.vim.org/) & [MacVim](https://code.google.com/p/macvim/)

## Set Up

Pre-requisites:

- [Xcode](https://developer.apple.com/xcode/)
- [Homebrew](http://brew.sh/)

Optional:

- RubyGems:
  - [mivok/markdownlint · GitHub](https://github.com/mivok/markdownlint)
  - [brigade/scss-lint · GitHub](https://github.com/brigade/scss-lint)
  - [tmuxinator/tmuxinator · GitHub](https://github.com/tmuxinator/tmuxinator)
- Terminal themes:
  - [dracula-theme](https://github.com/zenorocha/dracula-theme)
  - [tomorrow-theme](https://github.com/chriskempson/tomorrow-theme)

```
# Backup existing rc files before proceeding

$ cd
$ git clone --recursive https://github.com/gilbertwyw/dotfiles.git

# vim
$ ln -s ~/dotfiles/vim/vimrc ~/.vimrc
$ ln -s ~/dotfiles/vim/gvimrc ~/.gvimrc

# fish shell
$ brew install fish
# then follow the instruction in `brew info fish`
$ ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
$ ln -s ~/dotfiles/fish/functions ~/.config/fish/functions

# or, for Zsh
$ ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
$ ln -s ~/dotfiles/zsh ~/.zsh

# aliases
$ ln -s ~/dotfiles/aliases ~/.aliases

# Git
$ ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
$ ln -s ~/dotfiles/git/template ~/.git_template
$ ln -s ~/dotfiles/git/gitignore_global ~/.gitignore_global

# Ctags
$ ln -s ~/dotfiles/ctags ~/.ctags

# tmux
$ ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

# Ruby
$ ln -s ~/dotfiles/ruby/gemrc ~/.gemrc

# SSH
$ mkdir ~/.ssh
$ ln -s  ~/dotfiles/ssh/config ~/.ssh/config

# Others
$ ln -s ~/dotfiles/agignore ~/.agignore
$ ln -s ~/dotfiles/editorconfig ~/.editorconfig

# Install all Homebrew formulae listed in Brewfile
$ brew tap homebrew/brewdler
$ cd dotfiles/
$ brew brewdle [--dry-run]

```

## New machine / Re-installation

```
sudo xcodebuild -license
```

## Notes

"pvm_ls:26: no matches found: default" will be gone after `pvm install <version>`
