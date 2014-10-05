set -x PATH /usr/local/bin $PATH

# direnv, https://github.com/zimbatm/direnv
eval (direnv hook fish)

# autojump, https://github.com/joelthelion/autojump
# TODO dry this
if test -e (brew --prefix)/etc/autojump.fish 
  . (brew --prefix)/etc/autojump.fish
end

# rbenv
# require: brew install rbenv --HEAD
set -U fish_user_paths $fish_user_paths ~/.rbenv/bin
status --is-interactive; and . (rbenv init -|psub)

# TODO https://github.com/Alex7Kom/nvm-fish

# universal variables
set -U EDITOR vim
# Java 7
# alias
alias b=brew
alias d=direnv
alias g=git
alias m=mvim
alias nn=npm
alias o=open
alias r=ruby
alias s=sass
alias v=vim

if test (uname) == 'Darwin'
  set -U JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.7.0_17.jdk/Contents/Home
end
