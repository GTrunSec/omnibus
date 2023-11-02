{ inputs, omnibus }:
let
  inherit
    (omnibus.lib.errors.requiredInputs inputs "omnibus.pops.configs" [
      "nixpkgs"
      "topiary"
      "nixfmt"
      "dmerge"
    ])
    dmerge
    topiary
    nixpkgs
    nixfmt
  ;
in
with dmerge; {
  default = {
    packages = [
      nixfmt.packages.default
      nixpkgs.nodePackages.prettier
      nixpkgs.shfmt
      nixpkgs.nodePackages.prettier-plugin-toml
    ];
    data = {
      formatter = {
        nix = {
          includes = [ "*.nix" ];
          command = "nixfmt";
          excludes = [ ];
        };
        prettier = {
          command = "prettier";
          options = [
            "--plugin"
            "${nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules/prettier-plugin-toml/lib/api.js"
            "--write"
          ];
          includes = [
            "*.css"
            "*.html"
            "*.js"
            "*.json"
            "*.jsx"
            "*.md"
            "*.mdx"
            "*.scss"
            "*.ts"
            "*.yaml"
            "*.toml"
          ];
        };
        shell = {
          command = "shfmt";
          options = [
            "-i"
            "2"
            "-s"
            "-w"
          ];
          includes = [ "*.sh" ];
        };
      };
    };
  };
  julia = {
    data.formatter.prettier = {
      includes = prepend [ "" ];
      excludes = prepend [
        "Manifest.toml"
        "Project.toml"
        "julia2nix.toml"
      ];
    };
  };
  rust = {
    data.formatter.rust = {
      command = "rustfmt";
      includes = [ "*.rs" ];
      options = [
        "--edition"
        "2021"
      ];
    };
    data.formatter.prettier = {
      includes = prepend [ ".rustfmt.toml" ];
    };
  };
  nvfetcher = {
    data.formatter.prettier = {
      excludes = prepend [ "generated.json" ];
    };
    data.formatter.nix = {
      excludes = prepend [ "generated.nix" ];
    };
  };
  nix = {
    data.formatter.prettier = {
      excludes = prepend [ ".nix.toml" ];
    };
  };
  topiary = {
    data.formatter.topiary = {
      command = "topiary";
      options = [ "format" ];
      includes = [ "*.ncl" ];
    };
    packages = [ topiary.packages.default ];
  };
}
