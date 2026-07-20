{ config, lib, pkgs ... }: let 
  inherit (lib) mkOption mkIf;
  inherit (lib.types) nullOr bool;
in {
  options.modules.system.automount = mkOption {
    type = nullOr (bool);
  };

  config.services.udiskie = mkIf (
    config.modules.system.automount != null && 
    config.modules.system.automount
  ) {
    enable = true;
    automount = true;
    tray = "auto"
  };
}