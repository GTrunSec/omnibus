# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  debug,
  lib,
  root,
  omnibus,
}:
let
  out = root.nixos.pops.exports.default;
in
{
  darwinFontProfile =
    (out.layouts.darwinConfiguration [
      omnibus.darwinProfiles.presets.homebrew
      omnibus.darwinProfiles.presets.nix.default
      { homebrew.__profiles__.enableFonts = true; }
    ]).config.homebrew.casks;

  darwinNixProfile =
    (out.layouts.darwinConfiguration [ omnibus.darwinProfiles.presets.nix.default ])
    .config.nix.extraOptions;
}

// lib.optionalAttrs debug { }
