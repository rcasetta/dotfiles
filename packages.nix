let
  config = {
    allowUnfree = true;
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: {
          Agda = pkgs.haskell.packages.ghc844.Agda;
        };
      };
    };
  };
  pkgs = import <nixos-19.03> { inherit config; };
in rec {
  inherit (pkgs)
    zsh
    zsh-prezto
    zsh-powerlevel9k
    powerline-fonts
    fira
    fira-code
    htop
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
    virtualbox
    wine
    cachix
    skype

    git
    docker
    nixops
    idris
    yarn
    nodejs-11_x
    docker-compose
    ghc;

  black = pkgs.pythonPackages.black;
  agda = pkgs.haskellPackages.Agda;
  alex = pkgs.haskellPackages.alex;
  happy = pkgs.haskellPackages.happy;
  now-cli = pkgs.now-cli.overrideAttrs (oldAttrs: rec {
      version = "15.0.3";
  });
  texlive = pkgs.texlive.combined.scheme-basic;
  rubber = pkgs.rubber;
  python = pkgs.python36.withPackages (packages: with packages; [ mypy ]);
  emacs = pkgs.emacsWithPackages (packages: with packages; [ agda2-mode ]);

  docker-completion = pkgs.stdenv.mkDerivation (rec {
    name = "docker-completion";
    version = pkgs.docker.version;

    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/docker/cli/v${version}/contrib/completion/zsh/_docker";
      sha256 = "1hzsv4r720gaq3i8n7kcykjg6clygkah1764s0kmyd7jhj8wbrhc";
    };

    phases = "installPhase";

    installPhase = ''
      mkdir -p $out/modules/completion/external/src/
      cp $src $out/modules/completion/external/src/_docker
    '';
  });

  docker-compose-completion = pkgs.stdenv.mkDerivation (rec {
    name = "docker-compose-completion";
    version = pkgs.docker-compose.version;

    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/docker/compose/${version}/contrib/completion/zsh/_docker-compose";
      sha256 = "1wbdd9jpq0m5695a1gwclw698y189wdkwsihycxj9374zsqlbkr8";
    };

    phases = "installPhase";

    installPhase = ''
      mkdir -p $out/modules/completion/external/src/
      cp $src $out/modules/completion/external/src/_docker-compose
    '';
  });

  vscode = pkgs.vscode-with-extensions.override {
    vscodeExtensions = with pkgs.vscode-extensions; [
      bbenoist.Nix
      alanz.vscode-hie-server
      justusadam.language-haskell
      ms-python.python
    ]
    ++
    pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
      {
        name = "latex-input";
        publisher = "yellpika";
        version = "0.4.0";
        sha256 = "d051a914030f2f39c5578fbc5f2bcff8a83c11672ae03452f78bc078cd7cb174";
      }
      {
        name = "ide-purescript";
        publisher = "nwolverson";
        version = "0.20.7";
        sha256 = "8a180f4121d5513e65d1b845cbff776645112041f0711fb8f2256bab4dcd213f";
      }
      {
        name = "language-purescript";
        publisher = "nwolverson";
        version = "0.1.2";
        sha256 = "93ac559a0300cfca14a4ab5eb6f5b87a2aea4ba5843bc37f4cfc604c1639d4a8";
      }
      {
        name = "vscode-purty";
        publisher = "mvakula";
        version = "0.3.0";
        sha256 = "da9d6a0cfb5e4a4af987de16ef86c9b537ad6385e2d4a80cffd31bae0e1b5742";
      }
      {
        name = "dhall-lang";
        publisher = "panaeon";
        version = "0.0.4";
        sha256 = "6a92d00eec9e5badb978a92476ba55d13e934c972ef1e3fc2f746348a5569d61";
      }
    ];
  };
}
