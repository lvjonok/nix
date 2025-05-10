{ config, pkgs, ... }:
{
  services = {
    mako.enable = true;
    blueman-applet.enable = true;
  };
}
