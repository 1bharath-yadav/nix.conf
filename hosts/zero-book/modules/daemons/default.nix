{ config, pkgs, ... }:

{
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
}
