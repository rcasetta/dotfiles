let
    pkgs = import <nixpkgs> {};
in {
    zsh = pkgs.zsh;
    zsh-prezto = pkgs.zsh-prezto;
    zsh-powerlevel9k = pkgs.zsh-powerlevel9k;
    powerline-fonts = pkgs.powerline-fonts;
    firefox = pkgs.firefox;
    git = pkgs.git;
    vscode = pkgs.vscode;
}
