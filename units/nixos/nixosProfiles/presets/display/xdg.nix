# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  config,
  pkgs,
  lib,
  ...
}:
{
  xdg = {
    mime.enable = true;
    icons.enable = true;
    portal = {
      enable = true;
      wlr.enable = lib.mkIf config.hive.display.wayland true;
      extraPortals =
        with pkgs;
        [ xdg-desktop-portal-gtk ]
        ++ (lib.optionals config.hive.display.wayland) [ xdg-desktop-portal-wlr ];
    };
  };
  environment.systemPackages = with pkgs; [ xdg-utils ];
}
