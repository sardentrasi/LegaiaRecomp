# ⚔️ Modding Guide: LegaiaRecomp

## 1. Overview of the Native Modding System
LegaiaRecomp features a native, non-destructive modding engine (`psx_mod_manager`) adhering to **PSXMod Format Version 7**. 

Unlike legacy ROM hacking where modifications required modifying and rebuilding the entire 466 MB CD-ROM image (`.bin`), LegaiaRecomp mods:
- Are completely modular and isolated in individual package folders.
- Never modify or corrupt the base game disc.
- Can be dynamically enabled, disabled, and reordered via `mods/state.toml`.
- Support sparse disc sector overlays, static RAM memory patches, and native C function hooks.

---

## 2. Mod Directory Structure
Mods are installed into:
- Preloaded system mods: `mods/preloaded/packages/<package_id>/<version>/`
- User mods: `mods/packages/<package_id>/<version>/`

### Standard Mod Package Layout
```text
mods/preloaded/packages/legaia.vahn.blazingslash/1.0.0/
├── manifest.toml            # Mod configuration, priority, target, and sector mapping
├── assets/                  # Replacement binary data chunks
│   ├── run_000.bin
│   ├── run_001.bin
│   └── ...
└── patches/                 # Optional static memory patches
```

---

## 3. Manifest Specification (`manifest.toml`)
Every mod package must have a valid `manifest.toml` at its root.

```toml
format_version = 7

[package]
id = "legaia.vahn.blazingslash"
name = "Vahn Blazing Slash Super Art"
version = "1.0.0"
author = "SardenTrasi & Community"
description = "Transfers Gi Delilah's iconic Blazing Slash (Spell 0x79 / PROT 0958) full 6-stage cinematic & animation to Vahn with his 3D model."
priority = 100

[target]
serial = "SCUS-94254"
edition = "recomp"

[[runs]]
sector_offset = 33288
sector_count = 1
file = "assets/run_000.bin"

[[runs]]
sector_offset = 33290
sector_count = 2
file = "assets/run_001.bin"
```

### Fields:
- `format_version`: Must be `7`.
- `[package].id`: Unique reverse-DNS identifier (e.g. `legaia.vahn.blazingslash`).
- `[package].priority`: Higher priorities override conflicting sectors from lower priority mods.
- `[target].serial`: PlayStation 1 disc serial (e.g. `SCUS-94254`).
- `[[runs]]`: Sparse CD-ROM replacement table:
  - `sector_offset`: The absolute LBA sector number on the disc.
  - `sector_count`: Number of 2,352-byte sectors to replace.
  - `file`: Path to the raw replacement sector binary within the package.

---

## 4. Case Study 1: Vahn Blazing Slash Mod (`legaia.vahn.blazingslash`)

### 4.1 Technical Background: Spell `0x79` & PROT 0958
In *Legend of Legaia*, Gi Delilah is a fierce boss possessing the special cinematic attack **Blazing Slash**. In the combat engine's internal architecture:
- Blazing Slash is classified as a **Cinematic Magic/Spell (Internal ID: `0x79`)**, not a simple standard art.
- The combat execution bytecode is governed by Combat Protocol **PROT 0958**.
- During execution, the combat engine spawns a dedicated 6-stage choreography loop:
  1. **Stage 1 (Cinematic Intro):** Camera swings dynamically around the caster, dimming arena lighting and charging fire energy.
  2. **Stage 2 (Dash & Leap):** High-velocity dash toward the targeted enemy with motion trails and leap into the air.
  3. **Stage 3 (Aerial Multi-Slash):** Rapid 4-hit mid-air sword slashes leaving incandescent fiery trails.
  4. **Stage 4 (Ground Slam & Eruption):** Downward plunge triggering a fiery shockwave and explosion.
  5. **Stage 5 (Recovery & Sheath):** Backward somersault landing and weapon flourish/sheath animation.
  6. **Stage 6 (Combat Resolution):** Multi-hit damage computation, status effect checks, and camera return to default battle perspective.

### 4.2 Retargeting to Vahn
To allow Vahn to execute Blazing Slash without visual glitches:
1. **3D Model & Bone Binding:** The combat engine's caster entity pointer is redirected to Vahn's hero actor ID (`0x00`), binding the sword swing motion matrices to Vahn's right hand node and weapon attachment bone.
2. **Animation Matrix Retargeting:** Gi Delilah's bone hierarchy was adapted to Vahn's skeleton using forward kinematics delta transformation, preventing broken joints or stretched limbs.
3. **Sparse Disc Distribution:** Stored across 10 sparse sector runs (42 sectors, 98 KB) in `mods/preloaded/packages/legaia.vahn.blazingslash/1.0.0/assets/`.

---

## 5. Case Study 2: Indonesian Localization (`legaia.localization.indonesian`)
The Indonesian translation mod replaces 90 sparse sector runs (604 sectors, 1.42 MB) covering:
- In-game dialogue script tables (`.MAN` / `.MES` bytecode).
- Battle interface textures and character nameplates.
- World map and town signboards.
- System menu graphics and prompt windows.

Combined with the runtime `text_xlate` engine (`translations/legaia_id.toml`), players experience a complete, immersive Indonesian language playthrough with zero disc modification.

---

## 6. How to Create a New Mod

### Step 1: Create Mod Directory
```bash
mkdir -p mods/packages/my_custom_art/1.0.0/assets
```

### Step 2: Write `manifest.toml`
```toml
format_version = 7

[package]
id = "my_custom_art"
name = "My Custom Art Mod"
version = "1.0.0"
author = "Your Name"
description = "Custom tactical arts modification for Vahn."
priority = 50

[target]
serial = "SCUS-94254"
edition = "recomp"

[[runs]]
sector_offset = 33288
sector_count = 1
file = "assets/run_000.bin"
```

### Step 3: Enable the Mod in `mods/state.toml`
Open `mods/state.toml` and add your mod:
```toml
[mods]
"legaia.vahn.blazingslash" = true
"legaia.localization.indonesian" = true
"my_custom_art" = true
```

### Step 4: Run the Game
Launch `Legaia_Recompiled` (Linux) or `Legaia_Recompiled.exe` (Windows). The runtime will automatically detect the mod, validate its manifest, and inject the overlays at boot.
