{ config, pkgs, ... }:

{

  users = {
    mutableUsers = false;
    users.ksanteen = {
      isNormalUser = true;
      shell = pkgs.zsh;
      # mkpasswd -m sha-512 password
      hashedPassword = "$6$R8MlLIgkG9IChGaU$X5p6upyubBF86sdtNzROxbm5ZrU6Bx3xdQBgSuv99WrhYrRFew5u.xto7Mo2VyxpJA7jD5FOtEFSPIyXflts4.";
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK//F4D06X/qtiPFHb7Cbkkou2PBJBA1Fcd6NcrTQTzr borealis" ];

      extraGroups = [ "wheel" "docker" "plugdev" "audio" ];
    };
  };
}
