#!/bin/bash

set -e

sudo apt-get update && sudo apt-get install -y curl

bash <(curl https://nixos.org/nix/install)

nix-env -i git-minimal
