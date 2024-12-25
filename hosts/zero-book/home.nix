{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "archer";
  home.homeDirectory = "/home/archer";
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
    Install = { WantedBy = [ "timers.target" ]; };
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
    Install = { WantedBy = [ "timers.target" ]; };
  };

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    telegram-desktop
    kdePackages.filelight
    htop
    btop
    neofetch
    tesseract
    libnotify
    scrcpy
    wl-clipboard
    zsh
    gcc
    python3
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
  ];
programs.autojump.enable = true;

home.file = {
  ".local/share/zsh/zsh-autosuggestions".source =
    "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";

  ".local/share/zsh/zsh-syntax-highlighting".source =
    "${pkgs.zsh-syntax-highlighting}/share/zsh/site-functions";

  ".local/share/zsh/nix-zsh-completions".source =
    "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix";
};





  home.sessionVariables = {
     EDITOR = "nvim";
     BAT_THEME = "gruvbox-dark";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
