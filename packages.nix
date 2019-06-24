let
    pkgs = import <nixos-18.09> {};
    unstablePkgs = import <nixpkgs> {};
in {
    inherit (pkgs)
        zsh
        zsh-prezto
        zsh-powerlevel9k
        powerline-fonts
        fira
        fira-code
        htop
        emacs
        libcanberra
        libcanberra-gtk3

        firefox
        discord
        slack
        gimp
        kazam
        simplescreenrecorder
        vlc
        redshift

        cachix

        git
        docker
        nixops
        idris
        yarn
        ghc;
    inherit (unstablePkgs)
        skype
        nodejs-11_x
        docker-compose;

    black = unstablePkgs.pythonPackages.black;
    #agda = unstablePkgs.haskellPackages.Agda;
    alex = pkgs.haskellPackages.alex;
    happy = pkgs.haskellPackages.happy;
    now-cli = unstablePkgs.now-cli.overrideAttrs (oldAttrs: rec {
        version = "15.0.3";
    });
    texlive = pkgs.texlive.combined.scheme-basic;
    rubber = pkgs.rubber;
    python = pkgs.python36.withPackages (packages: with packages; [ mypy ]);

    docker-completion = pkgs.stdenv.mkDerivation {
        name = "docker-completion";
        version = "18.09.0";

        src = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/docker/cli/v18.09.0/contrib/completion/zsh/_docker";
            sha256 = "0ce6c59184f2345f27d0c49c00d57c9e32f3e4f46c1e8be2c0ea017132d9fac3";
        };

        phases = "installPhase";

        installPhase = ''
            mkdir -p $out/modules/completion/external/src/
            cp $src $out/modules/completion/external/src/_docker
        '';
    };

    docker-compose-completion = pkgs.stdenv.mkDerivation {
        name = "docker-compose-completion";
        version = "1.23.1";

        src = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/docker/compose/1.23.1/contrib/completion/zsh/_docker-compose";
            sha256 = "14c47bf9162c0838134a061443abef172846d7a0e097476129231da6d90859f0";
        };

        phases = "installPhase";

        installPhase = ''
            mkdir -p $out/modules/completion/external/src/
            cp $src $out/modules/completion/external/src/_docker-compose
        '';
    };

    vscode = pkgs.vscode-with-extensions.override {
        vscodeExtensions = with pkgs.vscode-extensions; [
            bbenoist.Nix
        ]
        ++
        pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
                name = "vscode-hie-server";
                publisher = "alanz";
                version = "0.0.25";
                sha256 = "6c776b057fd741909fbdcec6ee3e08e6bc6c20d5254e5222a81d93b407e04154";
            }
            {
                name = "python";
                publisher = "ms-python";
                version = "2018.12.0";
                sha256 = "3bd84915e43c16e17a7c7c27e64eb95cb93ff4ce3976f275506d38056591cf4c";
            }
            {
                name = "language-haskell";
                publisher = "justusadam";
                version = "2.5.0";
                sha256 = "639987da2d55d524bc7e7e307e19593c2fd687ca4bc28f6852cdf4c231925882";
            }
            {
                name = "agda";
                publisher = "j-mueller";
                version = "0.1.6";
                sha256 = "f855e3ea5678be15a268ad0b2379874743d84b78f74758a4f1b74b8707bf0a05";
            }
            {
                name = "vsliveshare";
                publisher = "ms-vsliveshare";
                version = "0.3.1326";
                sha256 = "398a37666b70d80907cf9392b6eec8251fd5c2cf13e70895edfdf83bf08ca56d";
            }
            {
                name = "vscode-database";
                publisher = "bajdzis";
                version = "2.1.5";
                sha256 = "a798ab22fd26b852bef106adc7c0315888076c4a75c85bb765f89bfd8bcb1bee";
            }
            {
                name = "prettier-vscode";
                publisher = "esbenp";
                version = "1.7.0";
                sha256 = "bbb8b14215687bc771625cf22f0eb097ad4831022cfb0b9bef8c7d58e3e9fcdb";
            }
            {
                name = "markdown-pdf";
                publisher = "yzane";
                version = "1.2.0";
                sha256 = "faf5aa7d5ae471689c02a7014bd7ee443552798f5c6063c9e19557f644f493e3";
            }
            {
                name = "rainbow-csv";
                publisher = "mechatroner";
                version = "0.3.0";
                sha256 = "1e7cc29a5c579cf381a2cb9d90650d25a0a4224bbd0256bbe2b4ee3d41263777";
            }
            {
                name = "vscode-edit-csv";
                publisher = "janisdd";
                version = "0.0.11";
                sha256 = "023b3f5e9e58ad8c25bcd6dd9d79bd10ef8ead3261b3681ec7e58475fd3e40e4";
            }
        ];
    };
}
