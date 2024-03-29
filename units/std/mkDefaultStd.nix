# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  inputs,
  lib,
}:
let
  inherit (inputs) std;
  inherit (std) incl;
  mkCellsFrom =
    src:
    std.incl src [
      "dev"
      "prod"
    ];
in
{
  pops ? { },
  ...
}@attrs:
super.mkStandardStd (
  lib.recursiveUpdate attrs {
    inputs = {
      # extraPops for extending the cell's pops
      _pops = pops;
      cellsFrom = mkCellsFrom attrs.cellsFrom;
      # without std.incl
      cellsFrom' = attrs.cellsFrom;
    };
    cellsFrom = mkCellsFrom ./defaultCellsFrom;
  }
)
