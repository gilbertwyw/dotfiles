## Config Files

- Git
- Homebrew
- Ruby
- vim & MacVim
- zsh (oh-my-zsh)

## Set Up

Install:

  - Xcode (for MacVim)
  - [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

iTerm:

  - [tomorrow-theme](https://github.com/chriskempson/tomorrow-theme)

```
$ git clone https://github.com/gilbertwyw/dotfiles.git ~
$ cd dotfiles
$ git submodule update --init --recursive
$ brew bundle Brewfile

# backup existing rc files before proceeding

$ ln -s ~/dotfiles/vim/vimrc ~/.vimrc
$ ln -s ~/dotfiles/vim/gvimrc ~/.gvimrc

$ ln -s ~/dotfiles/zsh/zshrc ~/.zshrc

$ ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
$ ln -s ~/dotfiles/git/gitignore_global ~/.gitignore_global

$ ln -s ~/dotfiles/agignore ~/.agignore
$ ln -s ~/dotfiles/editorconfig ~/.editorconfig

$ ln -s ~/dotfiles/ruby/gemrc ~/.gemrc

$ mkdir ~/.ssh
$ ln -s  ~/dotfiles/ssh/config ~/.ssh/config

# not necessary if "oh-my-zsh" is intalled already
$ chsh -s /bin/zsh

$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
$ vim +BundleInstall +qall

# the following 2 steps are required for YouCompleteMe
$ cd ~/.vim/bundle/YouCompleteMe
$ ./install.sh --clang-completer
```

### Notes
"pvm_ls:26: no matches found: default" will be gone after `pvm install <version>`
