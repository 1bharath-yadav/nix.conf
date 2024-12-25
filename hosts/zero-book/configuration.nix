{ config, pkgs, inputs,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  services.flatpak.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader configuration
  boot.loader.systemd-boot.enable = false;  # Ensure systemd-boot is disabled
  boot.loader.grub.enable = true;          # Enable GRUB
  boot.loader.grub.device = "nodev";       # Required for UEFI systems
  boot.loader.grub.useOSProber = true;     # Enable OS Prober for detecting other OSes
  boot.loader.grub.efiSupport = true;      # Ensure UEFI support
  boot.loader.efi.canTouchEfiVariables = true; # Allow EFI variable access

  # Kernel settings
  boot.kernel.sysctl = { "vm.swappiness" = 10; };
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [
    pkgs.linuxKernel.packages.linux_6_6.v4l2loopback
  ];

  networking.hostName = "Archer"; # Define your hostname.
  networking.networkmanager.enable = true; # Enable networking.

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

  # Mount additional filesystems
  fileSystems."/mnt/Localdisk" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs3";
    options = [ "defaults" ];
  };

  # Enable X11 and KDE
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable Docker
  virtualisation.docker.enable = true;

  # Enable Bluetooth and Pipewire for audio
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
    description = "Archer";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
  home-manager = {
  # also pass inputs to home-manager modules
  extraSpecialArgs = {inherit inputs;};
  users = {
    "archer" = import ./home.nix;
  };
};
  # Install Firefox
  programs.firefox.enable = true;
  programs.zsh.enable=true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;
  # Install additional system packages
  environment.systemPackages = with pkgs; [
    neovim bat wget zip bash unzip openssl openssh portaudio nerd-fonts.droid-sans-mono httpie efibootmgr os-prober docker vscode nmap lazydocker p7zip fwupd affine piper-tts bookworm htop btop
    linuxKernel.packages.linux_6_6.v4l2loopback
    libva vaapiIntel vaapiVdpau libdrm v4l-utils bluez bluez-tools kdePackages.bluedevil kdePackages.bluez-qt
    libsForQt5.plasma-browser-integration kdePackages.plasma-browser-integration
  ];

  # System state and garbage collection
  system.stateVersion = "24.11";
  nix.settings.allowed-users = [
    "@wheel"
    "@builders"
    "archer"
  ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}