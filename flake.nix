# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
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
        nixosProfilesOmnibus = src.pops.nixosProfiles;
        darwinProfilesOmnibus = src.pops.darwinProfiles;
        homeProfilesOmnibus = src.pops.homeProfiles;

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

  nixConfig = {
    extra-substituters = [
      "https://tweag-topiary.cachix.org"
      "https://tweag-nickel.cachix.org"
      "https://organist.cachix.org"
      "https://cache.garnix.io"
    ];
    extra-trusted-public-keys = [
      "tweag-topiary.cachix.org-1:8TKqya43LAfj4qNHnljLpuBnxAY/YwEBfzo3kzXxNY0="
      "tweag-nickel.cachix.org-1:GIthuiK4LRgnW64ALYEoioVUQBWs0jexyoYVeLDBwRA="
      "organist.cachix.org-1:GB9gOx3rbGl7YEh6DwOscD1+E/Gc5ZCnzqwObNH2Faw="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };
}
