# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ yants, self }:
with yants;
{
  host = openStruct "omnibusHiveHost" { inherit (self) colmena; };
  colmena = struct "colmenaConfig" {
    nixpkgs = attrs any;
    deployment = attrs any;
    imports = list any;
  };
}
