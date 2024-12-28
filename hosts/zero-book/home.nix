{ config, pkgs, inputs, ... }:

{

   fonts.fontconfig.enable = true;
  

   nixpkgs = {

    config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg: builtins.elem (builtins.parseDrvName pkg.name).name [ "steam" ];
      config.firefox.enablePlasmaBrowserIntegration = true;

      permittedInsecurePackages = [
        "openssl-1.1.1v"
        "python-2.7.18.8"

      ];
    };
  };
  programs.starship = {
    enable = true;
   
  };
  programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  historySubstringSearch.enable = true;
  

  shellAliases = {
    ll = "ls -l";

  };
  history.size = 10000;
  oh-my-zsh = {
    enable = true;
    plugins = [ "git" ];
  };
};
  

  home = {
    username = "archer";
    homeDirectory = "/home/archer";
    stateVersion = "24.11";
    packages = with pkgs; [
      telegram-desktop
      kdePackages.filelight
      htop
      btop
      bookworm
      neofetch
      tesseract
      libnotify
      scrcpy
      wl-clipboard
      zsh
      gcc
      git
      starship
      pay-respects
      autojump
      zsh-syntax-highlighting
      zsh-autosuggestions
      zsh-history-substring-search
      nil
      bat
      xlsfonts
      alsa-utils
      thunderbird
      libsForQt5.kconfig
      gimp-with-plugins
      kdePackages.kdenlive
      obs-studio
      vscode
      p7zip
      affine
      piper-tts
      bat
      wget
      zip
      bash
      unzip
      nix-search-cli
      nvd.out
      cargo
      flameshot
      floorp
      fontconfig
      github-desktop
      gnumake
      grub2
      hugo
      libverto
      luarocks
      mangohud
      ninja
      pavucontrol
      python3Full
      python.pkgs.pip
      ripgrep
      rofi
      sxhkd # hotkey daemon
      stdenv
      nerd-fonts.terminess-ttf
      tldr
      trash-cli
      variety
      xclip
      zoxide

    ];
  };


  # Systemd user-level timers
  systemd.user.services."20-20-20" = {
    Service = {
      Type = "oneshot";
      ExecStart = "/home/archer/bin/20-20-20.sh";
    };
  };

  systemd.user.timers."20-20-20" = {
    Timer = {
      OnBootSec = "1min";
      OnUnitActiveSec = "20min";
      AccuracySec = "1s";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  systemd.user.services."snapper" = {
    Service = {
      Type = "oneshot";
      ExecStart = "/home/archer/bin/timesnap.sh";
    };
  };

  systemd.user.timers."snapper" = {
    Timer = {
      OnBootSec = "1min";
      OnUnitActiveSec = "30min";
      AccuracySec = "1s";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  programs.autojump.enable = true;

  home.file = {
    ".local/share/zsh/zsh-autosuggestions".source =
      "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";

    ".local/share/zsh/zsh-syntax-highlighting".source =
      "${pkgs.zsh-syntax-highlighting}/share/zsh/site-functions";

    ".local/share/zsh/nix-zsh-completions".source = "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BAT_THEME = "gruvbox-dark";


  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  programs.gh = {
    enable = true;
  };
  programs.git = {
    enable = true;
    userName = "1bharath-yadav";
    userEmail = "byadhav36@gmail.com";};
    

}
