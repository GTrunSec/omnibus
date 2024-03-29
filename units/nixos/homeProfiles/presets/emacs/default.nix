# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  config,
  pkgs,
  lib,
  inputs,
  omnibus,
}:
let
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.homeProfiles" [
      "emacs-overlay"
    ])
    emacs-overlay
    ;
  nixpkgs = pkgs.appendOverlays [ emacs-overlay.overlays.default ];
in
{
  imports = [ omnibus.homeModules.programs.emacs ];
  config =
    with lib;
    mkMerge [
      (mkIf pkgs.stdenv.isLinux {
        programs.emacs = {
          enable = true;
          package = nixpkgs.emacs29-pgtk;
        };
        services.emacs.client.enable = true;
      })
    ];
}
