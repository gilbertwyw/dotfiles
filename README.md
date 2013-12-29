## Config Files
- Vim / MacVim
- Homebrew
- oh-my-zsh

## Set Up

```
$ git clonehttps://github.com/gilbertwyw/dotfiles.git ~
$ cd dotfiles
$ git submodule update --init —-recursive
$ ln -s pure/pure.zsh ~/dotfiles/oh-my-zsh/custom/pure.zsh-theme

# backup exsiting rc files before proceeding
$ ln -s ~/dotfiles/vim/vimrc ~/.vimrc
$ ln -s ~/dotfiles/vim/gvimrc ~/.gvimrc
$ ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
$ ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
$ ln -s ~/dotfiles/git/gitignore_global ~/.gitignore_global
$ ln -s ~/dotfiles/agignore ~/.agignore

# require password
$ chsh -s /bin/zsh

# require `brew install macvim --override-system-vim`
$ vim +BundleInstall +qall

# the following 2 steps required for YouCompleteMe
$ cd ~/.vim/bundle/YouCompleteMe
$ ./install.sh --clang-completer
```
