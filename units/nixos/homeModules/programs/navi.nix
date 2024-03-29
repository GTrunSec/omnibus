# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  lib,
  inputs,
  cfg,
}:
{
  options = with lib; {
    __profiles__ = {
      navi-tldr-pages = {
        enable = mkEnableOption (mdDoc "navi-tldr-pages");
        src = mkOption {
          type = types.either types.path types.str;
          default = inputs.navi-tldr-pages;
          description = "The paths to use for navi-tldr-pages";
        };
        paths = mkOption {
          default =
            (src: (map (x: src + "/${x}") (lib.attrNames (builtins.readDir src))))
              cfg.__profiles__.navi-tldr-pages.src;
        };
      };
    };
  };
  config =
    with lib;
    mkMerge [
      (mkModulePath {
        settings = {
          cheats = {
            paths = config.programs.navi.__profiles__.navi-tldr-pages.paths;
          };
        };
      })
    ];
}
