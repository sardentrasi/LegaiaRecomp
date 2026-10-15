# 🗡️ Legend of Legaia Recompiled (LegaiaRecomp)

[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-blue.svg)](https://github.com/sardentrasi/LegaiaRecomp)
[![Recompilation](https://img.shields.io/badge/Recomp-psxrecomp%20AOT-brightgreen.svg)](https://github.com/RetroPortingToolKit/psxrecomp)
[![Game](https://img.shields.io/badge/Game-Legend%20of%20Legaia%20(SCUS--94254)-red.svg)](https://en.wikipedia.org/wiki/Legend_of_Legaia)
[![License](https://img.shields.io/badge/License-MIT-orange.svg)](LICENSE)

An open-source, native PC static recompilation of the classic PlayStation 1 JRPG **Legend of Legaia** (`SCUS-94254`, NTSC-U).

Instead of traditional emulation that interprets MIPS instructions at runtime, **LegaiaRecomp** translates the original MIPS R3000A machine code ahead-of-time (AOT) into clean, portable 64-bit C code. The resulting engine runs as a native PC executable with uncapped performance, widescreen rendering, sub-pixel polygon precision, instant loading, and a powerful native modding ecosystem.

---

## ✨ Features & Enhancements

- 🚀 **High Framerate Rendering:** Uncapped 60 FPS / 120 FPS+ combat and exploration.
- 🌟 **PGXP Geometry Correction:** Eliminates the iconic PS1 polygon jitter, vertex snapping, and affine texture warping for razor-sharp 3D models.
- 🖥️ **True Widescreen & Ultrawide:** Native 16:9, 21:9, and 32:9 rendering without stretching HUD or character proportions.
- ⚡ **Instantaneous Load Times:** Seamless transitions between the world map, towns, and tactical combat encounters.
- 🎮 **Modern Controller & Audio:** Full gamepad vibration and analog stick support via SDL3, paired with OpenAL 3D spatial sound and SPU voice mixing.
- ⚔️ **Native Modding Architecture (`.psxmod`):** Modular mod loading with zero modification to your original game disc.
- 🌐 **Dynamic Localization Engine (`text_xlate`):** On-the-fly string translation using 64-bit FNV-1a hash tables, freeing translations from legacy PS1 byte budgets.

---

## 🎁 Bundled / Preloaded Mods

LegaiaRecomp comes out-of-the-box with two showcase mods:

### 1. ⚔️ Vahn Blazing Slash Super Art (`legaia.vahn.blazingslash`)
- **What it does:** Transfers Gi Delilah's iconic cinematic attack (**Spell `0x79` / PROT 0958**) directly to **Vahn**!
- **Features:** 
  - Complete 6-stage battle cinematic: dynamic camera swing, high-speed dash, 4-hit mid-air fiery slashes, ground shockwave eruption, and recovery sheath.
  - Fully bound to Vahn's 3D hero model, weapon bone hierarchy, and custom flame particle VFX.
  - No disc hacking required: loaded seamlessly as a sparse CD-ROM sector overlay.

### 2. 🇮🇩 Indonesian Localization Pack (`legaia.localization.indonesian`)
- **What it does:** Complete Bahasa Indonesia translation covering in-game dialogue, story cutscenes, menu systems, items, and battle interfaces.
- **Features:**
  - High-quality literary translation tuned to each character's unique voice (Vahn, Noa, Gala, Meta, Terra, Ozma).
  - Uses dynamic `text_xlate` to render natural phrasing without awkward abbreviations.

---

## 🚀 Quick Start (How to Play)

### Prerequisites
1. You must legally own an original retail copy of *Legend of Legaia* (USA, `SCUS-94254`).
2. Dump your disc into `.bin` / `.cue` format using your favorite disc dumping tool (e.g. ImgBurn, MPF).

### Running the Game
1. Clone or download this repository:
   ```bash
   git clone --recursive https://github.com/sardentrasi/LegaiaRecomp.git
   cd LegaiaRecomp
   ```
2. Place your disc dump in the `disc/` folder:
   - `disc/Legend of Legaia (USA).cue`
   - `disc/Legend of Legaia (USA).bin`
3. Build or download the latest release executable (see [Building](#-building-the-project)).
4. Launch `Legaia_Recompiled.exe` (Windows) or `./Legaia_Recompiled` (Linux).
5. Enjoy *Legend of Legaia* natively on your PC!

---

## 🔨 Building the Project

The recompiled C code (`generated/`) is already committed to this repository. You **do not** need Python or specialized decompilation tools to build the game—only standard C/C++ build tools!

### 🪟 Windows (Visual Studio 2022 / MinGW)

We provide an automated, one-click Windows build script:

1. Open **Command Prompt** or **PowerShell** in the `LegaiaRecomp` directory.
2. Run:
   ```cmd
   build_windows.bat
   ```
3. The script will automatically detect Visual Studio 2022, configure CMake, build with MSVC, stage required assets, and produce `build-release\Legaia_Recompiled.exe`.

> For advanced Windows build options, see [BUILD_WINDOWS.md](BUILD_WINDOWS.md).

### 🐧 Linux (Ubuntu / Debian / Fedora / Arch)

1. Install dependencies:
   ```bash
   # Ubuntu / Debian:
   sudo apt update
   sudo apt install -y build-essential cmake ninja-build libsdl3-dev libopenal-dev libgl1-mesa-dev
   
   # Arch Linux:
   sudo pacman -S base-devel cmake ninja sdl3 openal mesa
   ```
2. Configure and build:
   ```bash
   cmake -S . -B build-release -G Ninja -DCMAKE_BUILD_TYPE=Release
   cmake --build build-release --target psx-runtime
   ```
3. Run:
   ```bash
   ./build-release/Legaia_Recompiled
   ```

---

## 🧩 Community Modding Guide

LegaiaRecomp is built from the ground up for modders. Anyone can create new arts, balance tweaks, custom textures, or translations without touching the base game code!

### Mod Directory Anatomy
Mods are placed in `mods/packages/<your_mod_id>/<version>/`:
```text
mods/packages/my_custom_art/1.0.0/
├── manifest.toml            # Mod metadata, priority, and sector mappings
└── assets/                  # Sparse replacement chunks (optional)
```

### Creating `manifest.toml`
```toml
format_version = 7

[package]
id = "my_custom_mod"
name = "My Awesome Legaia Mod"
version = "1.0.0"
author = "YourHandle"
description = "Adds new custom Tactical Arts and combat rebalances."
priority = 50

[target]
serial = "SCUS-94254"
edition = "recomp"

# Optional: replace specific CD-ROM sectors on-the-fly
[[runs]]
sector_offset = 33288
sector_count = 1
file = "assets/run_000.bin"
```

### Enabling / Disabling Mods
Edit `mods/state.toml`:
```toml
[mods]
"legaia.vahn.blazingslash" = true
"legaia.localization.indonesian" = true
"my_custom_mod" = true
```

### Adding New Language Translations
Translations are located in `translations/` as clean TOML files:
1. Copy `translations/legaia_id.toml` to `translations/legaia_<lang>.toml`.
2. Translate dialogue strings while preserving escape codes (`{c1:00}` for Vahn, `|` for newline).
3. Set your active language in `game.toml`:
   ```toml
   [localization]
   enabled = true
   language = "es"
   path = "translations/legaia_es.toml"
   ```

---

## 🤝 Contributing

Contributions from the community are warmly welcome! Here are ways you can help:
- 🎨 **Visual Mods:** Create HD texture packs, UI remasters, or custom character skins.
- ⚔️ **Combat Mods:** Design new Tactical Arts, boss mechanics, or balance overhauls.
- 🌍 **Translations:** Help localize *Legend of Legaia* into Spanish, French, German, Japanese, and more.
- 💻 **Engine Improvements:** Enhance rendering features, optimize GTE instructions, or add new platform backends.

To contribute:
1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/my-new-mod`).
3. Commit your changes (`git commit -m 'Add awesome new mod'`).
4. Push to the branch (`git push origin feature/my-new-mod`).
5. Open a **Pull Request**.

---

## ⚖️ Legal & Disclaimer

- *Legend of Legaia* is a registered trademark of **Sony Interactive Entertainment Inc.** / **Contrail** / **Prokion**.
- **LegaiaRecomp** is an independent, non-profit open-source project and is **not** affiliated with, endorsed by, or sponsored by Sony or any of its subsidiaries.
- This repository contains **NO** copyrighted game assets, proprietary ROM dumps, disc images, or retail PlayStation BIOS binaries.
- All builds run using clean-room open-source BIOS implementations ([OpenBIOS](https://github.com/RetroPortingToolKit/openbios)).
- Users must supply their own legally purchased disc image to play.
