{ config, pkgs, ... }:


{
#  imports = [
#    ./services/nixos-auto-update.nix
#  ];

  # Supposedly better for the SSD.
  fileSystems."/" = { options = [ "noatime" "nodiratime" "discard" ]; };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        #efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        enableCryptodisk = true;
        device = "nodev";
      };
    };
    initrd = {
      luks.devices = {
        crypt = {
         device = "/dev/sda2";
         preLVM = true;
        };
      };
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = "borealis";
    #useDHCP = false;
    #interfaces.wlp4s0.useDHCP = true;
    #interfaces.enp1s0.useDHCP = true;

    #firewall = {
    #  enable = true;
    #  allowedTCPPorts = [ 80 443 2022 ];
    #  allowedUDPPorts = [ 53 ];
    #  allowPing = true;
    #};
  };

  time.timeZone = "Europe/Stockholm";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      powerline-fonts
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Iosevka" ]; })
    ];
  };

  services = {
    xserver = {
    	enable = true;
        displayManager.lightdm.enable = true;
        desktopManager.pantheon.enable = true;
    };

    #battery optimization subsystem
    tlp.enable = true;

    #nixos-auto-update.enable = true;
    logrotate = {
      enable = true;
      extraConfig = ''
        compress
        create
        daily
        dateext
        delaycompress
        missingok
        notifempty
        rotate 31
      '';
    };
    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      enableOnBoot = true;
    };
  };

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };

  hardware.rtl-sdr.enable = true;

  programs = {
    nm-applet.enable = true;
    ssh.startAgent = false;
    neovim.defaultEditor = true;
    zsh.enable = true;
    mosh.enable = true;
  };

  environment = {
    variables = {
      SUDO_EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      git
      gh
      inotify-tools
      binutils
      gnutls
      wget
      curl
      bind
      mkpasswd
      ranger
      ripgrep
      fzf
      htop
      atop
      bat
      tmux
      mosh
    ];
  };

  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnfree = true;
    };
  };

  nix = {
    package = pkgs.nixFlakes;
    useSandbox = true;
    autoOptimiseStore = true;
    readOnlyStore = false;
    allowedUsers = [ "@wheel" ];
    trustedUsers = [ "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d --max-freed $((64 * 1024**3))";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };
  system = {
    stateVersion = "21.11"; # Did you read the comment?
#    autoUpgrade = {
#      enable = true;
#      allowReboot = true;
#      flake = "github:aergid/NixSystem";
#      flags = [
#        "--recreate-lock-file"
#        "--no-write-lock-file"
#        "-L" # print build logs
#      ];
#      dates = "daily";
#    };
  };
}
