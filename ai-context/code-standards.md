# 🛠️ Code Standards & Developer Practices: LegaiaRecomp

## 1. Core Engineering Philosophy
LegaiaRecomp follows the **Ponytail (Lazy Senior Dev)** philosophy: **Lazy means efficient, not careless. The best code is the code never written.**

Before adding or modifying any code, stop at the first rung that holds:
1. **Does this need to be built at all? (YAGNI)**
2. **Does it already exist in this codebase?** Reuse the helper, util, or pattern already here; don't reinvent it.
3. **Does the standard library already do this?** Use standard C11 / C++17 library functions.
4. **Does a native platform feature or existing library cover it?** SDL3, OpenGL, OpenAL, and CMake already provide cross-platform abstractions.
5. **Only then:** write the minimum code that works.

---

## 2. Language & Portability Standards

### 2.1 C / C++ Language Level
- **C Source Code:** Strict C11 (`-std=c11` on GCC/Clang, `/std:c11` on MSVC).
- **C++ Source Code:** Strict C++17 (`-std=c++17` on GCC/Clang, `/std:c++17` on MSVC).
- **Cross-Platform Portability:** Code must compile warning-free on:
  - Windows x64 (MSVC 2022 and MinGW-w64)
  - Linux x86_64 and AArch64 (GCC 11+, Clang 14+)
  - macOS (Apple Silicon & Intel Clang)

### 2.2 Memory Safety & Fixed-Width Types
- Always use `<stdint.h>` types for hardware registers and PlayStation addresses:
  - `uint32_t` for PS1 32-bit words and addresses (`0x80010000`, `0x1F800000`).
  - `uint16_t` for half-words.
  - `uint8_t` for bytes.
  - `int32_t` / `int16_t` for signed arithmetic.
- Never make assumptions about pointer sizes (`sizeof(void*) == 8` on target 64-bit platforms, while PS1 addresses are 32-bit). Always use `uintptr_t` when converting pointers to integers.
- Never use raw unsafe string functions (`strcpy`, `sprintf`); use bounded alternatives (`snprintf`, `strncpy`, `strlcpy`).

---

## 3. Recompiled Codebase Rules (`generated/`)

1. **Deterministic Code Generation:**
   - Files in `generated/` (`SCUS_942.54_full_*.c`, `dispatch.c`, `decls.h`) are produced deterministically by `psxrecomp_cli.py`.
   - Never manually hand-edit generated shards unless committing a critical temporary override (clearly marked with `// OVERRIDE:`).
2. **Commit Policy:**
   - All generated C source files **must be committed** to the repository.
   - This ensures that players, developers, and CI workflows can build the project immediately with standard CMake and compiler tools without needing Python, disassemblers, or static analysis environments.

---

## 4. Modding & Extension Hygiene

1. **Isolation:**
   - New gameplay features, balance changes, and visual mods must live in `mods/packages/` or `mods/preloaded/packages/` as `.psxmod` packages.
   - Keep the core engine clean and generic.
2. **Minimal Diffs:**
   - Prefer small, targeted patches and sparse sector overlays over massive file replacements.
   - Every mod must have an accurate, descriptive `manifest.toml`.

---

## 5. Git & Repository Hygiene

- **NEVER COMMIT DISC IMAGES OR PIRATED ASSETS:**
  - `*.bin`, `*.cue`, `*.iso`, `SCPH*.BIN` are strictly ignored by `.gitignore`.
  - Only mod asset chunks located in `mods/**/assets/*.bin` are permitted to be committed.
- **NEVER COMMIT LOCAL AI ORCHESTRATORS:**
  - `ai-context-loader.md` is strictly gitignored to keep public repositories clean and focused for human contributors.
