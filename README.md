# Setup

## Prerequisites

- [Homebrew](http://brew.sh/)
- [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle)

```sh
# brew install gh
# - prefer SSH over HTTPS
gh auth login

# store passphrase in keychain
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

gh repo clone gilbertwyw/dotfiles
```

> [!TIP] 
> Read `HOMEBREW_GITHUB_API_TOKEN` in https://github.com/Homebrew/brew/blob/master/docs/Manpage.md#environment

```sh
cd dotfiles
brew brewdle [--dry-run] -v

# use -n to see any filesystem changes
stow -v -R [-n] .
```

## Zsh

```sh
echo "$HOMEBREW_PREFIX/bin/zsh" | sudo tee -a /etc/shells
chsh -s $HOMEBREW_PREFIX/bin/zsh
```

## Tmux

> [!NOTE]
> Make sure `<prefix>` does not clash with system shortcut.

```sh

## Neovim

```sh
# Run all healthchecks
:checkhealth
```

### Xcode

```sh
xcode-select --install

sudo xcodebuild -license
```
