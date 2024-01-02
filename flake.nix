# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    flops.url = "github:gtrunsec/flops";
  };

  outputs =
    inputs:
    let
      srcPops = import ./src { inherit inputs; };
      src = srcPops.exports.default;
    in
    src.flakeOutputs
    // {
      pops = src.pops // {
        self = srcPops;
        nixosProfiles = src.pops.nixosProfiles.addLoadExtender {
          load.type = "nixosProfiles";
        };
        darwinProfiles = src.pops.darwinProfiles.addLoadExtender {
          load.type = "nixosProfiles";
        };
        homeProfiles = src.pops.nixosProfiles.addLoadExtender {
          load.type = "nixosProfiles";
        };
      };

      inherit src;
      inherit (src) lib ops errors;
      call-flake = inputs.flops.inputs.call-flake;

      templates = {
        nixos = {
          path = ./templates/nixos;
          description = "Omnibus & nixos";
          welcomeText = ''
            You have created an Omnibus.nixos template!
          '';
        };
        hivebus = {
          path = ./templates/hivebus;
          description = "Omnibus & hive";
          welcomeText = ''
            You have created a hivebus template!
          '';
        };
      };
    };
}
