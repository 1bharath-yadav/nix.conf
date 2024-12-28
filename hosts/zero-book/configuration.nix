{
  config,
  pkgs,
  inputs,
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
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };
  };

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

  boot = {
    #kernelParams = ["nohibernate"];
    # tmp.cleanOnBoot = true;
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
    kernel.sysctl = {
      #"net.ipv4.tcp_congestion_control" = "bbr";
      # "net.core.default_qdisc" = "fq";
    };

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
  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
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
  # Mount additional filesystems
  fileSystems."/mnt/Localdisk" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs3";
    options = [ "defaults" ];
  };
  programs.hyprland.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos/hosts/zerobook";
  };
  # Enable X11 and KDE
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

  # OR

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";

  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
  };
  #stylix.image = ./my-cool-wallpaper.png;

  virtualisation.docker.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable printing
  services.printing.enable = true;

  # User configuration
  users.users.archer = {
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
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    users = {
      "archer" = import ./home.nix;
    };
  };

  programs.firefox.enable = true;
  #programs.zsh.enable = true;
  #nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;
  # Install additional system packages
  environment.systemPackages = with pkgs; [
    neovim
    openssl
    openssh
    portaudio
    nerd-fonts.droid-sans-mono
    httpie
    efibootmgr
    os-prober
    docker
    nmap
    lazydocker
    fwupd
    linuxKernel.packages.linux_6_6.v4l2loopback
    libva
    vaapiIntel
    vaapiVdpau
    libdrm
    v4l-utils
    bluez
    bluez-tools
    kdePackages.bluedevil
    kdePackages.bluez-qt
    libsForQt5.plasma-browser-integration
    kdePackages.plasma-browser-integration
    nix-output-monitor
    base16-schemes
    bibata-cursors
    nerd-fonts.fira-code
    vimPlugins.nvim-web-devicons
    vimPlugins.gruvbox
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.sddm
    vimPlugins.vscode-nvim
     #####HYPERLAND###
      waybar
      eww
      mako
      wl-clipboard
      kitty
      alacritty
      rofi-wayland
  ];
  

  # System state and garbage collection
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
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
        serif = [
          "Noto Serif"
          "Source Han Serif"
        ];
        sansSerif = [
          "Noto Sans"
          "Source Han Sans"
        ];
      };
    };
  };

}
