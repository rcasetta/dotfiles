#!/bin/sh

set -e

# Change shell
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s "$(command -v zsh)" "${USER}"

# Get dotfiles
git clone git@github.com:rcasetta/dotfiles.git
cd dotfiles
cp .zshrc $HOME
cp .zpreztorc /etc/zpreztorc
cp .gitconfig $HOME

nix-env -if packages.nix

# Setup fonts
mkdir -p .local/share/fonts/nix
ln .nix-profile/share/fonts/**/*.* .local/share/fonts/nix
fc-cache -f -v

# Setup terminal font
profile=$(sed -e "s/'//g" <<< $(gsettings get org.gnome.Terminal.ProfilesList default))
dconf write /org/gnome/terminal/legacy/profiles:/:$profile/font "'Source Code Pro for Powerline 10'"
