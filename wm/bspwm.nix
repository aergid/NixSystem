{ config, lib, pkgs, ... }:

{
  services = {
    gnome3.gnome-keyring.enable = true;
    upower.enable = true;

    dbus = {
      enable = true;
      socketActivated = true;
      packages = [ pkgs.gnome3.dconf ];
    };

    xserver = {
      enable = true;
      startDbusSession = true;
      layout = "us,ru";

      libinput = {
        enable = true;
        disableWhileTyping = true;
      };

      displayManager.defaultSession = "none+bspwm";

      windowManager.bspwm = {
        enable = true;
      };

      xkbOptions = "grp:ctrls_toggle";
    };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  systemd.services.upower.enable = true;
}
