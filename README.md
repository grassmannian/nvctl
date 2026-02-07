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
and allows user to run commands with syntax `build/nv git adog` where `git/adog` is a bash script located in the directory mentioned above

# Building

Follow instructions in *Nix* section, or 

Requires user has `janet` and `jpm` installed.
Simply run `jpm build`

# Nix

Currently supports manual building within a nix shell. `nix develop` followed by 

```
jpm deps
jpm build
```

Creates an executable

```
./build/nv
```

# Features:

 - main.janet calls nvctl.janet
 - Support arbitrarily nested directories, e.g. the command `build/nv git commit empty` should run the script in `git/commit/empty` or provide some failure message if no such script is found
 - Scripts read from any of the following directories (ordered decreasing precedence)

  1. `NVCTL_DIR`
  2. the single directory specified in ~/.config/nvctl/.nvctl
  3. ~/scripts

If none of these are specified, behavior undefined

 - pass a `--help` flag to your program (e.g `nv git adog --help`) to print a help dialog if one has been provided. Help dialog is the first line in the file which begins "##"

# TODO

 - Nixify it
 - handle help more cleanly

# Acknowledgements

Heavily inspired by Ian Henry's `sd`
