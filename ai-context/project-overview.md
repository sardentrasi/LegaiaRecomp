# LegaiaRecomp: Project Overview & Vision

## 1. Executive Summary
**LegaiaRecomp** is an open-source native PC static recompilation of *Legend of Legaia* (Sony PlayStation 1, NTSC-U release `SCUS-94254`). Using the `RetroPortingToolKit/psxrecomp` static recompilation framework, all original MIPS R3000A machine code is translated ahead-of-time into clean, portable 64-bit C code that compiles and runs natively on Windows (x64), Linux (x86_64, ARM64), and macOS.

## 2. Key Pillars & Goals
1. **Hardware-Uncapped Performance:**
   - 60/120 FPS high framerate rendering.
   - PGXP (Precision Geometry Transform Pipeline) sub-pixel precision eliminating PS1 3D polygon jitter and affine texture warping.
   - True 16:9 / 21:9 ultrawide aspect ratios without stretching.
   - Instantaneous, near-zero loading times.
2. **First-Class Native Modding (`.psxmod`):**
   - Clean, modular mod packaging without modifying base ISO dumps.
   - Declarative RAM patches and sparse disc sector overlays.
   - C/C++ dynamic hook API for deep gameplay and combat logic modification.
3. **Built-in Multilingual Localization (`text_xlate`):**
   - Non-destructive on-the-fly string translation via FNV-1a64 hash tables (`translations/*.toml`).
   - Indonesian translation bundled as a first-class feature with live in-game language switching.
4. **Legal & Preservation Centric:**
   - Ships zero copyrighted game assets or retail BIOS images.
   - Clean-room OpenBIOS bundled by default.
   - Players supply their own legal disc dump (`.cue` / `.bin`).
