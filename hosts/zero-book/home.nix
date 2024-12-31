{ config, pkgs, inputs, ... }:

{
   imports = [
    ./modules
    ./home-packages.nix
  ];

  fonts.fontconfig.enable = true;
  
  programs.zsh.enable = true;
   nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "openssl-1.1.1v"
        "python-2.7.18.8"

      ];
    };
  };
  
#   programs.zsh = {
#   enable = true;
#   enableCompletion = true;
#   autosuggestion.enable = true;
#   syntaxHighlighting.enable = true;
#   historySubstringSearch.enable = true;
  

#   shellAliases = {
#     ll = "ls -l";

#   };
#   history.size = 10000;
#   oh-my-zsh = {
#     enable = true;
#     plugins = [ "git" ];
#   };
# };
  

  home = {
    username = "archer";
    homeDirectory = "/home/archer";
    stateVersion = "24.11";
    packages = with pkgs; [
     
    ];
  };

  programs.autojump.enable = true;
  home.file = {  
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BAT_THEME = "gruvbox-dark";
  };

  programs.home-manager.enable = true;
  programs.gh = {
    enable = true;
  };
  programs.git = {
    enable = true;
    userName = "1bharath-yadav";
    userEmail = "byadhav36@gmail.com";};    
}
