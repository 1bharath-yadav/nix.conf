{ pkgs, inputs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    inputs.hyprland-qtutils.packages."${pkgs.system}".default
    # Desktop apps
    affine
    bookworm
    floorp
    gimp-with-plugins
    github-desktop
    imv
    kdePackages.kdeconnect-kde
    kdePackages.kdenlive
    mpv
    obs-studio
    obsidian
    pavucontrol
    teams-for-linux
    telegram-desktop
    thunderbird
    variety
    vesktop
    vscode


    # CLI utils
    alsa-utils
    autojump
    bat
    bemoji
    bottom
    btop
    cargo
    cliphist
    ffmpegthumbnailer
    fzf
    git-graph
    gnumake
    grimblast
    grub2
    htop
    hugo
    libverto
    luarocks
    mangohud
    mediainfo
    neofetch
    nil
    ninja
    nix-prefetch-scripts
    nix-search-cli
    nvd.out
    p7zip
    pay-respects
    piper-tts
    playerctl
    ripgrep
    scrcpy
    showmethekey
    silicon
    starship
    stdenv
    tesseract
    tldr
    trash-cli
    udisks
    ueberzugpp
    unzip
    vlc
    w3m
    wget
    wl-clipboard
    wtype
    xclip
    yt-dlp
    zip
    zoxide

    # Coding stuff
    nodejs

    # WM stuff
    libsForQt5.xwaylandvideobridge
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland      
     
  ];
}
