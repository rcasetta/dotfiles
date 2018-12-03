#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(kubecontext user virtualenv dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
POWERLEVEL9K_SHORTEN_STRATEGY=default
POWERLEVEL9K_VIRTUALENV_FOREGROUND='black'
POWERLEVEL9K_VIRTUALENV_BACKGROUND='green'
# POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true

# Load nix
if [ -e /home/richard/.nix-profile/etc/profile.d/nix.sh ]; then
  . /home/richard/.nix-profile/etc/profile.d/nix.sh;
fi # added by Nix installer

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.nix-profile/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.nix-profile/init.zsh"
fi

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
  true 
fi

if [ $commands[helm] ]; then
  source <(helm completion zsh)
  true
fi
