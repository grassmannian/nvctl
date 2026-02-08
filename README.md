# Introduction

A client for managing user scripts. Expects a directory like
```
├── git
│   └── adog
│   └── amend
└── cp
    └── to-cluster
```
and allows user to run commands with syntax `nvctl git adog` where `git/adog` is a bash script located in the directory mentioned above

# Building

Building with Nix is supported, 

`nix build`

or use dev shell, `nix develop` followed by 

```
jpm deps
jpm build
```

This places a build binary in `JANET_BUILDPATH` which is by default `.jpm/build/nvctl`. 

You could of course install `janet` and `jpm` independantly and build with command `jpm build`

# Features:

 - Support arbitrarily nested directories, e.g. the command `build/nvctl git commit empty` should run the script in `git/commit/empty` or provide some failure message if no such script is found
 - Scripts read from any of the following directories (ordered decreasing precedence)

  1. `NVCTL_DIR`
  2. the single directory specified in ~/.config/nvctl/.nvctl
  3. ~/scripts

If none of these are specified, behavior undefined

 - pass a `--help` flag to your program (e.g `nvctl git adog --help`) to print a help dialog if one has been provided. Help dialog is the first line in the file which begins "##"

# TODO

 - handle help more cleanly
 - handle commands with arguments

# Acknowledgements

Heavily inspired by Ian Henry's `sd`
