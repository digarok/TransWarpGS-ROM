# TransWarpGS-ROM
The TransWarp IIgs ROM 1.8s Disassembly (and reassembly!)

![Build TWGS v1.8 100% Parity](https://github.com/digarok/TransWarpGS-ROM/workflows/.github/workflows/main.yml/badge.svg)

This project is intended for educational purposes only.  

## About

The TransWarp GS is an accelerator card add-on for the Apple IIgs.  This project features a complete dissassembly of the source code of the TransWarp IIgs ROM (v1.8s) which can be built into a 100% binary parity version using Merlin32.

## Build

You can build the source using Merlin32 directly in the `src/twgs_1.8s` directory like `merlin32 -V . twgs.s`

There's also a build script in the root folder called `build.sh` but it expects `merlin32` to exist in your path so you'll need to set that up or modify the script to point to where it's located on your system. The advantage of running `./build.sh` is that it checks the output binary and if everything matches it will tell you with the following message:
```
Binary is v1.8s compatible
````

## Comparing

You could always use `diff` to check against the 1.8s ROM for differences in your output object file, but that only tells you that a difference exists.  I find visual diff is very helpful for reassembling these binaries and have included a script I use, in unison with my `hihex` command-line tool to visually diff the resultant binaries.  If you don't have hihex, it should fall back to vimdiff with hexdump. 

## CI/CD 

This project uses GitHub actions that I've published on the open marketplace to build the project and also verify the resulting binary.  Now it can check the binary parity on every commit!

## Contributing

This was a quick release to get this shared out as a priority.  Right now, I'd like to accept contributions that add to the documentation and/or disassembly, versus changes or enhancements.  If you want to work on enhancements, I suggest you fork the project, add a branch, add a separate version folder in both `rom` and `src` directories.  Then if you have a new version you'd like to contribute back you can submit a pull request of that branch to this project.

## Thanks
There's no way I would've been able to get this far with the contributions of the following stellar technologists:

Henry Courbis, Anthoni Martino, Antoine Vignau, Geoff Body, Ferox (The Flaming Bird Disassembler), Ewan Wanop (BrkDown)


Also thanks to apple-iigs.info for the doc: http://www.apple-iigs.info/doc/fichiers/AE%20TransWarp%20GS%20Programmer%20Reference.pdf