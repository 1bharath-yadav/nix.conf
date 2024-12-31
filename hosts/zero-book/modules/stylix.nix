{ pkgs, inputs, config, ... }: {
#   imports = [ inputs.stylix.homeManagerModules.stylix ];

  home.packages = with pkgs; [
    dejavu_fonts
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    font-awesome
    powerline-fonts
    powerline-symbols
  
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = {
  base00 = "232629"; # Background
  base01 = "2a2e32"; # Lighter Background
  base02 = "3e4b59"; # Selection Background
  base03 = "606672"; # Comments / Secondary Text
  base04 = "788188"; # Darker Foreground
  base05 = "bfc7d5"; # Default Foreground
  base06 = "d3d9e0"; # Lighter Foreground
  base07 = "eff1f5"; # Highlighted Text
  base08 = "bf616a"; # Red (Errors)
  base09 = "d08770"; # Orange (Warnings)
  base0A = "ebcb8b"; # Yellow (Attention)
  base0B = "a3be8c"; # Green (Success)
  base0C = "88c0d0"; # Cyan (Information)
  base0D = "5e81ac"; # Blue (Links / Functions)
  base0E = "b48ead"; # Purple (Keywords)
  base0F = "ab7967"; # Brown (Deprecated)
};

    # = "${config.scheme}";


    targets = {
      neovim.enable = false;
      waybar.enable = false;
      wofi.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      
    };

    cursor = {
      name = "DMZ-Black";
      size = 24;
      package = pkgs.vanilla-dmz;
    };

    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      monospace = {
        name = "JetBrains Mono";
        package = pkgs.jetbrains-mono;
      };
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };

      sizes = {
        terminal = 13;
        applications = 11;
      };
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };


  };
}
