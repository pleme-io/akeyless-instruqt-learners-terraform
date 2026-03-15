{
  description = "Akeyless Instruqt learner provisioning — creates per-participant Universal Identity auth methods, scoped roles, and access bindings for training";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    substrate = {
      url = "github:pleme-io/substrate";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, substrate, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
      mkTerraformModuleCheck = (import "${substrate}/lib/terraform-module.nix").mkTerraformModuleCheck;
    in {
      checks.default = mkTerraformModuleCheck pkgs {
        pname = "akeyless-instruqt-learners-terraform";
        version = "0.0.0-dev";
        src = self;
        description = "Akeyless Instruqt learner provisioning — creates per-participant Universal Identity auth methods, scoped roles, and access bindings for training";
        homepage = "https://github.com/pleme-io/akeyless-instruqt-learners-terraform";
      };

      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          opentofu
          tflint
          terraform-docs
        ];
      };
    });
}
