# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs,
  root,
  lib,
}:
inputs.self.pops.self.load.inputs
// {
  nix-filter = root.pops.flake.inputs.nix-filter.lib;
  omnibus = inputs.self;
}
