# Introduction

A client for managing user scripts. Expects a directory like
```
├── flake.nix
├── git
│   └── adog
├── README.md
└── src
    └── nvctl.janet
```
and allows user to run commands with syntax `nv git adog` where `nv` is the build artifact of `src/` and `git/adog` is a bash script

# TODO List

 - Autocompletion
 - Support non-bash scripts (Janet? arbitrary code?)

# Acknowledgements

Heavily inspired by Ian Henry's `sd`
