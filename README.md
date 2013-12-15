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
$ ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
$ ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc

# require password
$ chsh -s /bin/zsh

# require `brew install macvim --override-system-vim`
$ vim +BundleInstall +qall

# the following 2 steps required for YouCompleteMe
$ cd ~/.vim/bundle/YouCompleteMe
$ ./install.sh --clang-completer
```
