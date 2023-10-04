(omnibus.loadHomeModules.addLoadExtender {
  inputs = {
    __misc__ = {
      inherit (super.inputs.outputs) catppuccin-bat;
    };
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports.customModules = self.outputs.__extenders [ {
          value = {
            enable = false;
            customList = with dmerge; append [ "1" ];
            imports = with dmerge; append [ ];
          };
          path = [
            "services"
            "openssh"
          ];
        } ];
      }
    ))
  ]