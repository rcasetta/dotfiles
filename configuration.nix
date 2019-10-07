# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
    config = { allowUnfree = true; };
    unstablePkgs = import <nixpkgs> { inherit config; };
    
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
            {
                name = "agda";
                publisher = "j-mueller";
                version = "0.1.6";
                sha256 = "f855e3ea5678be15a268ad0b2379874743d84b78f74758a4f1b74b8707bf0a05";
            }
            {
                name = "vscoq";
                publisher = "siegebell";
                version = "0.2.6";
                sha256 = "18c8b83273654a593adb895def7ea23973f442a9e2d4f435181378a1bc538a1c";
            }
            {
                name = "idris";
                publisher = "zjhmale";
                version = "0.9.8";
                sha256 = "b769e72d670ad683f148184a2b0eeddfdb185432b03f1e732bcec2e55f0ed0b5";
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
      ];
  };
in
{
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  
  environment.systemPackages = with pkgs; [
    wget
    vim 
    git 
    zsh-prezto 
    zsh-powerlevel9k 
    docker 
    docker_compose 
    google-chrome 
    nixops 
    cachix
    discord
    unstablePkgs.steam
    texlive.combined.scheme-basic
    appimage-run
    wine

    coq
    idris   
    ghc
    vscode
    nodejs-10_x
  ];

  fonts.fonts = with pkgs; [
    powerline-fonts
    fira-code
    noto-fonts-emoji
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.enableIPv6 = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  services.xserver = {
    enable = true;
    layout = "fr";

    displayManager.gdm.enable = true;
    desktopManager.gnome3 = {
      enable = true;
      extraGSettingsOverrides = ''
        [org.gnome.desktop.peripherals.touchpad]
        click-method='default'
      '';
    };
    windowManager = {
      default = "i3";
      i3.enable = true;
    }; 

    # Enable touchpad support
    libinput.enable = true;
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.richard = {
    isNormalUser = true;
    home = "/home/richard";
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    hashedPassword = "$6$EQ5JCzhC$Z70T2bqN/2DEDItCAkN4TGq/rLJpt/6RMRDd83bTOFqXzzNQGlVJ8YCCV54IaQcOjPX7NAgdwny2JEvJaT2oW1";
    shell = pkgs.zsh;
  };

  users.groups.docker = {};
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    promptInit = "source ${pkgs.zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k.zsh-theme";
    interactiveShellInit = ''
      export ZDOTDIR=${pkgs.zsh-prezto}/

      source "$ZDOTDIR/init.zsh"
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://hie-nix.cachix.org"
    ];
    binaryCachePublicKeys = [
      "hie-nix.cachix.org-1:EjBSHzF6VmDnzqlldGXbi0RM3HdjfTU3yDRi9Pd0jTY="
    ];
    trustedUsers = [ "root" "richard" ];
  };


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
