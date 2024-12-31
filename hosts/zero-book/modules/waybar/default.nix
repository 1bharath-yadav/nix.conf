{
  pkgs,
  lib,
  host,
  config,
  ...
}:

let
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit (import ./variables.nix) clock24h;
in
with lib;
{
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        layer = "top";
        position = "top";
        size = 10;
         modules-center = [
        "hyprland/workspaces" "mpris"
      ];

      modules-left = [
        "cpu"
        "memory"
        "disk"
        "backlight#2"
        # "temperature#vertical"
        #"network"
        "network#speed"
        "idle_inhibitor"
        "keyboard-state"
      ];

      modules-right = [
        "pulseaudio"
        "pulseaudio#microphone"
        #"bluetooth"
        "battery"
        "power-profiles-daemon"
        "tray"
        "clock"
      ];

        "temperature#vertical" = {
        interval = 10;
        tooltip = true;
        hwmon-path = [
          "/sys/class/hwmon/hwmon1/temp1_input"
          "/sys/class/thermal/thermal_zone0/temp"
        ];
        critical-threshold = 80;
        format-critical = "{icon}\n{temperatureC}°C";
        format = " {icon}";
        format-icons = [ "󰈸" ];
        on-click-right = "kitty --title nvtop sh -c 'nvtop'";
      };

      "backlight#2" = {
        device = "intel_backlight";
        format = "{icon} {percent}%";
        format-icons = [ "" "" ];
      };

      battery = {
        align = 0;
        rotate = 0;
        full-at = 100;
        design-capacity = false;
        states = {
          good = 95;
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = "󱘖 {capacity}%";
        format-alt-click = "click";
        format-full = "{icon} Full";
        format-alt = "{icon} {time}";
        format-icons = [
          "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"
        ];
        format-time = "{H}h {M}min";
        tooltip = true;
        tooltip-format = "{timeTo} {power}w";
        on-click-middle = "$HOME/.config/hypr/scripts/ChangeBlur.sh";
        on-click-right = "$HOME/.config/hypr/scripts/Wlogout.sh";
      };

      bluetooth = {
        format = " ";
        format-disabled = "󰂳";
        format-connected = "󰂱 {num_connections}";
        tooltip-format = " {device_alias}";
        tooltip-format-connected = "{device_enumerate}";
        tooltip-format-enumerate-connected = " {device_alias} 󰂄{device_battery_percentage}%";
        tooltip = true;
        on-click = "blueman-manager";
      };

      clock = {
        interval = 1;
        format = " {:%H:%M:%S}";
        format-alt = " {:%H:%M   %Y, %d %B, %A}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          format = {
            months = "<span color='#ffead3'><b>{}</b></span>";
            days = "<span color='#ecc6d9'><b>{}</b></span>";
            weeks = "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
      };

      actions = {
        on-click-right = "mode";
        on-click-forward = "tz_up";
        on-click-backward = "tz_down";
        on-scroll-up = "shift_up";
        on-scroll-down = "shift_down";
      };

      cpu = {
        format = "{usage}% 󰍛";
        interval = 1;
        min-length = 5;
        format-alt-click = "click";
        format-alt = "{icon0}{icon1}{icon2}{icon3} {usage:>2}% 󰍛";
        format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        on-click-right = "gnome-system-monitor";
      };

      disk = {
        interval = 30;
        path = "/";
        format = "{percentage_used}% 󰋊";
        tooltip-format = "{used} used out of {total} on {path} ({percentage_used}%)";
      };

      idle_inhibitor = {
        tooltip = true;
        tooltip-format-activated = "Idle_inhibitor active";
        tooltip-format-deactivated = "Idle_inhibitor not active";
        format = "{icon}";
        format-icons = {
          activated = " ";
          deactivated = " ";
        };
      };

      "keyboard-state" = {
        capslock = true;
        format = {
          numlock = "N {icon}";
          capslock = "󰪛 {icon}";
        };
        format-icons = {
          locked = "";
          unlocked = "";
        };
      };

      memory = {
        interval = 10;
        format = "{used:0.1f}G 󰾆";
        format-alt = "{percentage}% 󰾆";
        format-alt-click = "click";
        tooltip = true;
        tooltip-format = "{used:0.1f}GB/{total:0.1f}G";
        on-click-right = "kitty --title btop sh -c 'btop'";
      };

      mpris = {
        interval = 10;
        format = "{player_icon} ";
        format-paused = "{status_icon} <i>{dynamic}</i>";
        on-click-middle = "playerctl play-pause";
        on-click = "playerctl previous";
        on-click-right = "playerctl next";
        scroll-step = 5.0;
        on-scroll-up = "$HOME/.config/hypr/scripts/Volume.sh --inc";
        on-scroll-down = "$HOME/.config/hypr/scripts/Volume.sh --dec";
        smooth-scrolling-threshold = 1;
        player-icons = {
          chromium = "";
          default = "";
          firefox = "";
          kdeconnect = "";
          mopidy = "";
          mpv = "󰐹";
          spotify = "";
          vlc = "󰕼";
        };
        status-icons = {
          paused = "󰐎";
          playing = "";
          stopped = "";
        };
        max-length = 30;
      };

      network = {
        format = "{ifname}";
        format-wifi = "{icon}";
        format-ethernet = "󰌘";
        format-disconnected = "󰌙";
        tooltip-format = "{ipaddr}  {bandwidthUpBits}  {bandwidthDownBits}";
        format-linked = "󰈁 {ifname} (No IP)";
        tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
        tooltip-format-ethernet = "{ifname} 󰌘";
        tooltip-format-disconnected = "󰌙 Disconnected";
        max-length = 30;
        format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        on-click-right = "kitty nmtui";
      };

      "network#speed" = {
        interval = 1;
        format = "{ifname}";
        format-wifi = "{bandwidthUpBytes} {bandwidthDownBytes}";
        format-ethernet = "󰌘  {bandwidthUpBytes}  {bandwidthDownBytes}";
        format-disconnected = "󰌙";
        tooltip-format = "{ipaddr}";
        format-linked = "󰈁 {ifname} (No IP)";
        tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
        tooltip-format-ethernet = "{ifname} 󰌘";
        tooltip-format-disconnected = "󰌙 Disconnected";
        #min-length = 24;
        #max-length = 24;
        format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
      };

      "power-profiles-daemon" = {
        format = "{icon} ";
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          default = "";
          performance = "";
          balanced = "";
          power-saver = "";
        };
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-bluetooth = "{icon} 󰂰 {volume}%";
        format-muted = "󰖁";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" "󰕾" "" ];
          ignored-sinks = [ "Easy Effects Sink" ];
        };
        scroll-step = 5.0;
        on-click = "$HOME/.config/hypr/scripts/Volume.sh --toggle";
        on-click-right = "pavucontrol -t 3";
        on-scroll-up = "$HOME/.config/hypr/scripts/Volume.sh --inc";
        on-scroll-down = "$HOME/.config/hypr/scripts/Volume.sh --dec";
        tooltip-format = "{icon} {desc} | {volume}%";
        smooth-scrolling-threshold = 1;
      };

      "pulseaudio#microphone" = {
        format = "{format_source}";
        format-source = " {volume}%";
        format-source-muted = "";
        on-click = "$HOME/.config/hypr/scripts/Volume.sh --toggle-mic";
        on-click-right = "pavucontrol -t 4";
        on-scroll-up = "$HOME/.config/hypr/scripts/Volume.sh --mic-inc";
        on-scroll-down = "$HOME/.config/hypr/scripts/Volume.sh --mic-dec";
        tooltip-format = "{source_desc} | {source_volume}%";
        scroll-step = 5;
      };

      tray = {
        icon-size = 20;
        spacing = 4;
      };

      wireplumber = {
        format = "{icon} {volume} %";
        format-muted = " Mute";
        on-click = "$HOME/.config/hypr/scripts/Volume.sh --toggle";
        on-click-right = "pavucontrol -t 3";
        on-scroll-up = "$HOME/.config/hypr/scripts/Volume.sh --inc";
        on-scroll-down = "$HOME/.config/hypr/scripts/Volume.sh --dec";
        format-icons = [ "" "" "󰕾" "" ];
      };

      "wlr/taskbar" = {
        format = "{icon} {name}";
        icon-size = 16;
        all-outputs = false;
        tooltip-format = "{title}";
        on-click = "activate";
        on-click-middle = "close";
        ignore-list = [ "wofi" "rofi" "kitty" "kitty-dropterm" ];
      };
      }
    ];



    style = concatStrings [
  ''

* {
    font-family: "MesloLGS Nerd Font Mono Bold";
    font-size: 12px;
    min-height: 0;
    font-weight: bold;
}

window#waybar {
    background: #232629; /* Pure dark */
    color: #ffffff; /* White text for readability */
    transition-property: background-color;
    transition-duration: 0.1s;
    border-bottom: 1px solid #3c4043; /* Darker border */
}

#window {
    margin: 8px;
    padding-left: 8px;
    padding-right: 8px;
}

button {
    box-shadow: inset 0 -3px transparent;
    border: none;
    border-radius: 0;
}

button:hover {
    background: inherit;
    color: #81a1c1; /* Breeze light blue text on hover */
    border-bottom: 2px solid #81a1c1; /* Breeze blue bottom border */
}

#workspaces button {
    padding: 0 4px;
}

#workspaces button.focused {
    background-color: #232629; /* Pure dark background */
    color: #ffffff; /* White text */
    border-bottom: 2px solid #5e81ac; /* Breeze blue bottom border */
}

#workspaces button.active {
    background-color: #232629; /* Pure dark background */
    color: #ffffff; /* White text */
    border-bottom: 2px solid #81a1c1; /* Light blue bottom border */
}

#workspaces button.urgent {
    background-color: #232629; /* Pure dark background */
    color: #ffffff; /* White text */
    border-bottom: 2px solid #3c4043; /* Darker border for urgent */
}

#pulseaudio,
#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#wireplumber,
#tray,
#network,
#mode,
#scratchpad {
    margin-top: 2px;
    margin-bottom: 2px;
    margin-left: 4px;
    margin-right: 4px;
    padding-left: 4px;
    padding-right: 4px;
}

#clock {
    color: #ffffff; /* White text */
    border-bottom: 2px solid #5e81ac; /* Breeze blue bottom border */
}

#clock.date {
    color: #ffffff; /* White text */
    border-bottom: 2px solid #81a1c1; /* Light blue bottom border */
}

#pulseaudio {
    color: #ffffff; /* White text */
    border-bottom: 2px solid #5e81ac; /* Breeze blue bottom border */
    padding-left: 8px; /* Increased padding to avoid overlap */
    padding-right: 8px; /* Increased padding to avoid overlap */
}


#network {
    color: #ffffff; /* White text */
    border-bottom: 2px solid #81a1c1; /* Light blue bottom border */
}

#idle_inhibitor {
    margin-right: 12px;
    color: #ffffff; /* White text */
    border-bottom: 2px solid #5e81ac; /* Breeze blue bottom border */
}

#idle_inhibitor.activated {
    color: #ffffff; /* White text */
    border-bottom: 2px solid #81a1c1; /* Light blue bottom border */
}

#battery {
    color: #ffffff; /* White text */
    border-bottom: 2px solid #5e81ac; /* Breeze blue bottom border */
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#custom-vpn {
    color: #ffffff; /* White text */
    border-radius: 15px;
    padding-left: 6px;
    padding-right: 6px;
    border-bottom: 2px solid #5e81ac; /* Breeze blue bottom border */
}


    ''
  

    ];
  };


}
