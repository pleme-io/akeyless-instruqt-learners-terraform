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

  outputs = inputs:
    (import "${inputs.substrate}/lib/repo-flake.nix" {
      inherit (inputs) nixpkgs flake-utils;
    }) {
      self = inputs.self;
      language = "terraform";
      builder = "check";
      pname = "akeyless-instruqt-learners-terraform";
      description = "Akeyless Instruqt learner provisioning — creates per-participant Universal Identity auth methods, scoped roles, and access bindings for training";
    };
}
