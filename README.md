# Setup

## Prerequisites

- [Homebrew](http://brew.sh/)
- [Homebrew Cask](https://caskroom.github.io/)

Regarding "Github API Rate limit exceeded":

```
brew install direnv hub trash

echo "export HOMEBREW_GITHUB_API_TOKEN=<token>" > ~/.envrc
```

## Zsh

- [Antigen](https://zsh-users/antigen)

```
# Backup existing rc files before proceeding

cd
git clone https://github.com/gilbertwyw/dotfiles.git

ln -s ~/dotfiles/zsh/zshenv ~/.zshenv
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/zsh ~/.zsh

brew install zsh antigen

# require admin rights
echo '/usr/local/bin/zsh' >> /etc/shells

chsh -s /usr/local/bin/zsh

# aliases
ln -s ~/dotfiles/aliases ~/.aliases
```

## Git

```
brew install git

ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/template ~/.git_template
ln -s ~/dotfiles/git/gitignore_global ~/.gitignore_global
```

## Java

- [jenv](https://github.com/gcuisinier/jenv)

```
brew install jenv
brew cask install java

jenv add `/usr/libexec/java_home`
```

## Ruby

- [chruby](https://github.com/postmodern/chruby)
- [ruby-install](https://github.com/postmodern/ruby-install)

### RubyGems

- [brigade/scss-lint · GitHub](https://github.com/brigade/scss-lint)
- [mivok/markdownlint · GitHub](https://github.com/mivok/markdownlint)
- [tmuxinator/tmuxinator · GitHub](https://github.com/tmuxinator/tmuxinator)

```
brew install chruby ruby-install
ruby-install ruby && chruby ruby

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

## Vim

```
brew install vim --overrides-system-vi --with-lua --with-luajit

ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/vim/gvimrc ~/.gvimrc
```

### Neovim 

- [Homebrew version](https://github.com/neovim/homebrew-neovim/blob/master/README.md)
- [vim-plug setup](https://github.com/junegunn/vim-plug#neovim)

To use the same configuration as Vim:

```
# '.vim/' may not exist (e.g., new machine), open Vim first
#'.config/' may not exist, `mkdir ~/.config`
ln -s ~/.vim ~/.config/nvim

ln -s ~/.vimrc ~/.config/nvim/init.vim

brew install python
pip install [--user] neovim
```

## Miscs.

- [quick-look-plugins](https://github.com/sindresorhus/quick-look-plugins#install-all)

```
# Ag
brew install ag
ln -s ~/dotfiles/agignore ~/.agignore

# Ctags
brew install ctags
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

```
xcode-select --install

sudo xcodebuild -license
```
