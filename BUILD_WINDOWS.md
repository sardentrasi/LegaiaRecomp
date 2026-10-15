# Panduan Menjalankan & Membangun LegaiaRecomp di Windows

*Legend of Legaia (SCUS-94254)* telah dikonversi menjadi kode C native 64-bit yang siap dikompilasi langsung di Windows tanpa memerlukan emulator.

---

## 1. Persyaratan Lingkungan di Windows

Pastikan salah satu dari toolchain berikut telah terpasang di komputer Windows Anda:

- **Opsi A (Paling Mudah): Visual Studio 2022 Community**
  - Pastikan modul **"Desktop development with C++"** tercentang saat instalasi Visual Studio.
  - Sudah menyertakan CMake dan MSVC compiler secara otomatis.
- **Opsi B: MSYS2 MinGW-w64**
  - Paket: `mingw-w64-x86_64-toolchain`, `mingw-w64-x86_64-cmake`, `mingw-w64-x86_64-ninja`.

---

## 2. Cara Build Otomatis (Satu Klik)

1. Buka folder `LegaiaRecomp` di Windows Explorer.
2. Klik ganda (double-click) file:
   ```cmd
   build_windows.bat
   ```
3. Script akan otomatis mengonfigurasi CMake dan mengompilasi runtime menjadi:
   `build-windows\Release\Legaia_Recompiled.exe` (atau `build-windows\Legaia_Recompiled.exe`).

---

## 3. Cara Build Manual (Command Prompt / PowerShell)

Buka terminal di dalam folder `LegaiaRecomp`:

```cmd
:: 1. Konfigurasi CMake
cmake -S . -B build-windows -G "Visual Studio 17 2022" -A x64

:: 2. Kompilasi Target Runtime
cmake --build build-windows --config Release --target psx-runtime
```

---

## 4. Cara Menjalankan Game & Memuat Disc

1. Salin file disc PS1 asli Anda:
   - `Legend of Legaia (USA).cue`
   - `Legend of Legaia (USA).bin`
   ke dalam folder `LegaiaRecomp` atau folder build di sebelah executable.
2. Jalankan `Legaia_Recompiled.exe`.
3. Game akan langsung memuat disc secara otomatis sesuai konfigurasi `game.toml`.

---

## 5. Fitur Mod & Bahasa Indonesia yang Terpasang

Executable Windows secara otomatis membawa paket mod dan sistem lokalisasi yang telah kita siapkan di `mods/bundled/`:

1. **`legaia.vahn.blazingslash` (Vahn Blazing Slash Cinematic Special):**
   - Mengaktifkan jurus sinematik 6-stage Gi Delilas (Spell `0x79`) untuk Vahn (input: R D L D L / 50 AP).
   - Menggunakan model 3D Vahn asli (15-bone human rig) dengan koreksi damage multi-hit dan camera tracks lengkap.
   - Status: **Aktif (Enabled)** secara default di `mods\state.toml`.

2. **`legaia.localization.indonesian` (Terjemahan Penuh Bahasa Indonesia):**
   - Menimpa teks dialog cerita, nama jurus, item, dan menu ke dalam Bahasa Indonesia secara otomatis.
   - Dilengkapi modul `text_xlate` (`translations\legaia_id.toml`) untuk terjemahan on-the-fly.
   - Status: **Aktif (Enabled)** secara default di `mods\state.toml`.

3. **Fitur Visual Bawaan psxrecomp:**
   - **PGXP (Sub-pixel Vertex Precision):** Menghilangkan polygon wobble khas PS1.
   - **Resolusi Tinggi & Widescreen:** Mendukung resolusi 1080p, 1440p, hingga 4K serta aspek rasio 16:9 / 21:9.
