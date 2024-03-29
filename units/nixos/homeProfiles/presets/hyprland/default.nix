# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  imports = [ omnibus.homeModules.wayland.windowManager.hyprland ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = lib.mkDefault true;
    # extraConfig = builtins.readFile "${src}/hyprland.conf";
    xwayland = {
      enable = true;
    };
    __profiles__ = {
      nvidia = lib.mkDefault false;
      autoLogin = {
        enable = lib.mkDefault true;
        shell = lib.mkDefault "zsh";
      };
      swww = {
        enable = lib.mkDefault true;
        runtimeEnv = { };
      };
    };
  };
}
