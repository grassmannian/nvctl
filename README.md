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

Requires user has `janet` and `jpm` installed.

Simply run `jpm build`

# Features:

 - main.janet calls nvctl.janet
 - Support arbitrarily nested directories, e.g. the command `build/nv git commit empty` should run the script in `git/commit/empty` or provide some failure message if no such script is found
 - Scripts read from any of the following directories (ordered decreasing precedence)

  1. `NVCTL_DIR`
  2. the single directory specified in ~/.config/nvctl/.nvctl
  3. ~/scripts

If none of these are specified, behavior undefined

# TODO

 - Support the --help flag at the base level, and for all subcommands. At the base level, this should print "usage: nvctl <subcommands>". For a given subcommand, this should print a brief help message. The contents of this message should be pulled from the first line beginning with `##` in the file corresponding to the subcommand. If the subcommand is incomplete, e.g. corresponds to a directory, not a file, note this to the user, and list all of the files in the directory
 - Nixify it

# Acknowledgements

Heavily inspired by Ian Henry's `sd`
