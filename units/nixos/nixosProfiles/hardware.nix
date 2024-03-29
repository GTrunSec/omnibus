# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

# [[file:../../../docs/org/nixosProfiles.org::*hardware][hardware:1]]
{ root, self }:
let
  presets = root.presets;
in
with presets;
{
  default = [
    audio.bluetooth
    audio.pipewire
  ];
}
# hardware:1 ends here
