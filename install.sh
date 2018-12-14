#!/bin/sh

set -e

# Change shell
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s "$(command -v zsh)" "${USER}"

# Get dotfiles
git clone git@github.com:rcasetta/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
cp .zshrc $HOME
cp .zpreztorc /etc/zpreztorc
cp .gitconfig $HOME

mkdir $HOME/.nixpkgs
cp config.nix $HOME/.nixpkgs
nix-env -if packages.nix

# Setup fonts
mkdir -p .local/share/fonts/nix
ln .nix-profile/share/fonts/**/*.* $HOME/.local/share/fonts/nix
fc-cache -f -v

# Setup terminal font
profile=$(sed -e "s/'//g" <<< $(gsettings get org.gnome.Terminal.ProfilesList default))
dconf write /org/gnome/terminal/legacy/profiles:/:$profile/font "'Source Code Pro for Powerline 10'"

cachix use hie-nix

# Setup docker
sudo ln -s $HOME/.nix-profile/etc/systemd/system/docker.service /etc/systemd/system
sudo ln -s ./docker.socket /etc/systemd/system
sudo ln -s $HOME/.nix-profile/bin/docker /usr/bin/docker
sudo ln -s $HOME/.nix-profile/bin/dockerd /usr/bin/dockerd
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
