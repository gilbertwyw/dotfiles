# Setup

## Prerequisites

- [Homebrew](http://brew.sh/)

```sh
# brew install gh
# - prefer SSH over HTTPS
gh auth login

# store passphrase in keychain
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

gh repo clone gilbertwyw/dotfiles
```

> [!NOTE] 
> Read `HOMEBREW_GITHUB_API_TOKEN` in https://github.com/Homebrew/brew/blob/master/docs/Manpage.md#environment

```sh
cd dotfiles
brew bundle -v --no-lock

# use -n to see any filesystem changes
stow -v -R [-n] .
```

## Homebrew (via Just)

- [Just](https://just.systems/) 

```sh
# list available recipes
just -f ./Homebrew/Justfile 
# or 
cd ./Homebrew && just

# e.g., dump 
just -f Homebrew/justfile d
```

## Zsh

```sh
echo "$HOMEBREW_PREFIX/bin/zsh" | sudo tee -a /etc/shells
chsh -s $HOMEBREW_PREFIX/bin/zsh
```

## Tmux

> [!IMPORTANT]
> Make sure `<prefix>` does not clash with system shortcut.

```sh

## Neovim

```sh
# Run all healthchecks
:checkhealth
```

## Doom Emacs

- [install](https://github.com/doomemacs/doomemacs?tab=readme-ov-file#install) 

```sh
ln -s $HOMEBREW_PREFIX/opt/emacs-plus/Emacs.app /Applications/Emacs.app
```

## Espanso

- [Documentation](https://espanso.org/docs/get-started/) 

> [!TIP]
> Run `espanso path` to verify the setup

## Xcode

```sh
xcode-select --install

sudo xcodebuild -license accept
```

## Java

[jEnv](https://www.jenv.be/) 

```sh
jenv add "$(/usr/libexec/java_home)" 

# e.g., OpenJDK 21
brew install openjdk@21
jenv add /opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home/
```
