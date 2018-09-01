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

## asdf

Follow the step for Zsh here: https://github.com/asdf-vm/asdf#setup

## Node.js

Recommend: [Using a dedicated OpenPGP keyring](https://github.com/asdf-vm/asdf-nodejs#using-a-dedicated-openpgp-keyring)

```sh
ln -s ~/dotfiles/nodejs/default-npm-packages ~/.default-npm-packages

# https://github.com/asdf-vm/asdf-nodejs
asdf plugin-add nodejs
asdf install nodejs <version>
asdf global nodejs <version>
```

## Python

```sh
mkdir -p ~/.pip
ln -s ~/dotfiles/python/pip.conf ~/.pip/pip.conf
```

```sh
# https://github.com/tuvistavie/asdf-python
asdf plugin-add python
asdf install python <version>
asdf global python <version>

# for vim "tagbar" plugin
pip install markdown2ctags

# optional; recreate shims for installed packages
asdf reshim python <version>
```

## Ruby

```sh
ln -s ~/dotfiles/ruby/default-gems ~/.default-gems
ln -s ~/dotfiles/ruby/gemrc ~/.gemrc

# https://github.com/asdf-vm/asdf-ruby
asdf plugin-add ruby
asdf install ruby <version>
asdf global ruby <version>
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
