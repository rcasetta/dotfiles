let
    pkgs = import <nixpkgs> {};
in {
    zsh = pkgs.zsh;
    zsh-prezto = pkgs.zsh-prezto;
    zsh-powerlevel9k = pkgs.zsh-powerlevel9k;
    powerline-fonts = pkgs.powerline-fonts;
    firefox = pkgs.firefox;
    git = pkgs.git;
    cachix = pkgs.cachix;
    docker = pkgs.docker;
    docker-compose = pkgs.docker-compose;

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
                version = "0.0.24";
                sha256 = "d9e7c46e4a9bc6ac5d8aa843a139c84ca5e90d701fa3a16b54f9612b4d37b519";
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
        ];
    };
}
