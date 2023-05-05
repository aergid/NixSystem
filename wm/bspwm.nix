{ config, lib, pkgs, ... }:

{
  services = {
    gnome.gnome-keyring.enable = true;
    upower.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.gnome3.dconf ];
    };

    xserver = {
      enable = true;
      layout = "us,ru";

      libinput = {
        enable = true;
        touchpad.disableWhileTyping = false;
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
