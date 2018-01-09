#!/usr/bin/env bash

if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
   test -d "${xpath}" && test -x "${xpath}" ; then
   echo "xcode-select is correctly installed"
else
   xcode-select --install
fi

if [ ! -d "$HOME/dotfiles" ]; then
  echo "Cloning dotfiles..."
  git clone https://github.com/wys1203/dotfiles.git
  ln -s "$HOME/dotfiles/prezto" "$HOME/.zprezto"
fi

if brew ls --versions zsh > /dev/null; then
  echo "The Homebrew package is installed"
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap drone/drone
  brew tap caskroom/fonts
  brew bundle --file=$HOME/dotfiles/Brewfile
  echo "Change the default shell to zsh!"
  chsh -s /bin/zsh
fi

for rcfile in $(ls "${HOME}"/.zprezto/runcoms); do
  if [ ! "$rcfile" == "*.md" ]; then
    ln -s "${HOME}/.zprezto/runcoms/$rcfile" "${HOME}/.${rcfile:t}"
  fi
done
