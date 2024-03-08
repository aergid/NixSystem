{ config, lib, pkgs, ... }:

{
  services = {
    gnome.gnome-keyring.enable = true;
    upower.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };

    xserver = {
      enable = true;
      layout = "us,ru";

      libinput = {
        enable = true;
        touchpad.disableWhileTyping = false;
	touchpad.naturalScrolling = false;
	touchpad.middleEmulation = true;
	touchpad.tapping = true;

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
