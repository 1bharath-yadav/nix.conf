{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];


  services.flatpak.enable = true;

   nix = {
    settings = {
      warn-dirty = false;
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      substituters = [ "https://nix-gaming.cachix.org" ];

    };
  };

  nixpkgs = {

    config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg: builtins.elem (builtins.parseDrvName pkg.name).name [ "steam" ];
      permittedInsecurePackages = [
        "openssl-1.1.1v"
        "python-2.7.18.8"
      ];
    };
  };

  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        device = "nodev";
        efiSupport = true;
        enable = true;
        useOSProber = true;
        timeoutStyle = "menu";
      };
      timeout = 300;
    };
    kernelModules = [ "v4l2loopback" ];  
    extraModulePackages = [
      pkgs.linuxKernel.packages.linux_6_6.v4l2loopback
    ];
  };

   networking = {
    hostName = "zero-book";
    networkmanager.enable = true;
    enableIPv6 = false;
    firewall.enable = false;
  };

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
   };
   console = {
    packages = [ pkgs.terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    useXkbConfig = true;
  };

  programs = {
	  hyprland = {
      enable = true;
      withUWSM  = true;  
      };
    nm-applet.indicator = true;
    nm-applet.enable = true;
    thunar.enable = true;
	  thunar.plugins = with pkgs.xfce; [
		  exo
		  mousepad
		  thunar-archive-plugin
		  thunar-volman
		  tumbler
  	  ];
	   xwayland.enable = true;
     dconf.enable = true;
     seahorse.enable = true;
     fuse.userAllowOther = true;
     mtr.enable = true;
     gnupg.agent = {
       enable = true;
       enableSSHSupport = true;
     };
     zsh.enable = true;
      nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/archer/nix.conf";
     };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };

  services = {
    tlp.enable = true;
    xserver.xkb = {
    layout = "us";
    variant = "";
    };
    xserver = {
      enable = true; 
      displayManager.gdm.enable = true;
    };
    gnome.gnome-keyring.enable = true;
    gvfs = {
      enable = true;
      package = lib.mkForce pkgs.gnome.gvfs;
    };
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  #services.displayManager.sddm.enable = true;
  #services.desktopManager.plasma6.enable = true;
  #virtualisation.docker.enable = true;
  
  hardware={
    pulseaudio.enable = false;
    bluetooth = {
    enable = false;
    powerOnBoot = true;
  };
  };

  security = {
    rtkit.enable = true;
    pam.services.swaylock.text = ''
      auth include login
    '';
  };

  stylix.image= ./alian.jpeg;
  
  users={
    mutableUsers=true;
    defaultUserShell = pkgs.zsh;
    users.archer = {
    isNormalUser = true;
    description = "archer";
    extraGroups = [
      "flatpak"
      "audio"
      "video"
      "quemu"
      "kvm"
      "libvirtd"
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      kdePackages.kate
      inputs.nixvim.packages.x86_64-linux.default
    ];
  };
  };
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "archer" = import ./home.nix;
    };
  };

   # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    base16-schemes
    bibata-cursors
    bluez
    bluez-tools
    docker
    efibootmgr
    fastfetch
    fwupd
    git-crypt
    httpie
    lazydocker
    libdrm
    libnotify
    libva
    linuxKernel.packages.linux_6_6.v4l2loopback
    neovim
    nix-output-monitor
    nmap
    openssh
    openssl
    os-prober
    portaudio
    vaapiIntel
    vaapiVdpau
    v4l-utils
    (ffmpeg-full.override { withSvtav1 = true; svt-av1=pkgs.svt-av1-psy; })
    (av1an.override { withSvtav1 = true; svt-av1=pkgs.svt-av1-psy; })
    
  # inputs.fileserver.packages.${pkgs.system}.default
   
 /*  HYPERLAND  */
    baobab
    blueman 
    brightnessctl
    compsize
    coreutils-full
    cpufrequtils
    duf  
    eww
    gnutar
    gsettings-qt
    gtk-engine-murrine 
    grim
    hyprpaper
    imagemagick
    jq
    kitty
    libappindicator
    lm_sensors
    mako
    maxfetch
    pamixer
    pciutils
    polkit_gnome
    power-profiles-daemon
    pyprland
    qt6.qtwayland
    qt6Packages.qtstyleplugin-kvantum # kvantum
    roboto
    slurp
    smartmontools
    speedtest-cli
    swappy
    swaynotificationcenter
    veracrypt
    waybar
    websocat
    wl-clipboard
    wlogout
    wlrctl
    wofi
    xdg-user-dirs
    xdg-utils
    yad

    ###  FONTS ****
    nerd-fonts.droid-sans-mono
    nerd-fonts.terminess-ttf
    nerd-fonts.fira-code
    /*  KDE    
        qt6ct
        kdePackages.bluedevil
        kdePackages.bluedevil
        kdePackages.bluez-qt
        libsForQt5.plasma-browser-integration
        kdePackages.plasma-browser-integration
        vimPlugins.nvim-web-devicons
        vimPlugins.gruvbox
        libsForQt5.qt5.qtgraphicaleffects
        libsForQt5.sddm
        vimPlugins.vscode-nvim  */
  ];
  

  system.stateVersion = "24.11";
  nix.settings.allowed-users = [
    "@wheel"
    "@builders"
    "archer"
  ];
   fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      nerd-fonts.meslo-lg
    ];
  };
}
