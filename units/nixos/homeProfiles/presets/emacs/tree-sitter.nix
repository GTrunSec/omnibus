{
  pkgs,
  lib,
  config,
  ...
}:
let
  treeSitterPlugins = with pkgs.tree-sitter-grammars; [
    tree-sitter-nickel
    tree-sitter-nix
    tree-sitter-markdown

    tree-sitter-bash
    tree-sitter-julia
    tree-sitter-c
    tree-sitter-elisp
    tree-sitter-c-sharp
    tree-sitter-cmake
    tree-sitter-cpp
    tree-sitter-css
    tree-sitter-dockerfile
    tree-sitter-go
    tree-sitter-gomod
    tree-sitter-html
    tree-sitter-json
    tree-sitter-python
    tree-sitter-rust
    tree-sitter-toml
    tree-sitter-typescript
    tree-sitter-lua
    tree-sitter-yaml
    tree-sitter-nu
  ];
in
{
  config =
    with lib;
    mkMerge [
      {
        programs.emacs = {
          __profiles__ = {
            inherit treeSitterPlugins;
          };
        };
      }
    ];
}
