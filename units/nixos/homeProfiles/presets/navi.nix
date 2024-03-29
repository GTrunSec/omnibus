# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  config,
  lib,
  omnibus,
  inputs,
  pkgs,
}:
let
  inherit (pkgs.stdenv) isLinux isDarwin;
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.homeProfiles" [
      "nix-filter"
      "navi-tldr-pages"
    ])
    navi-tldr-pages
    nix-filter
    ;

  navi-tldr-pages-filtered =
    with nix-filter.lib;
    filter {
      root = navi-tldr-pages + "/pages";
      exclude =
        [
          "android"
          "windows"
          "sunos"
          (if isLinux then "osx" else "linux")
          (
            _root: path: _type:
            if
              (builtins.match "[^/]*(rpm|yum|apt).*.cheat" (builtins.baseNameOf path)) == null
            then
              false
            else
              true
          )
        ]
        ++ lib.optionals isDarwin [
          # (root: path: type: if (l.match "[^/]*brew.*\.cheat" (l.baseNameOf path)) == null then false else true)
        ];
    };
in
{
  imports = [ omnibus.homeModules.programs.navi ];
  programs.navi = {
    enable = true;
    enableZshIntegration = lib.mkIf config.programs.zsh.enable true;
    __profiles__ = {
      navi-tldr-pages = {
        enable = true;
        src = navi-tldr-pages-filtered;
      };
    };
  };
}
