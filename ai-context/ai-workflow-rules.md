# 🤖 AI Assistant Workflow & Safety Directives: LegaiaRecomp

> [!WARNING]
> **MANDATORY RULES FOR ALL AI AGENTS:** Working with static binary recompilations, native hardware abstractions, and PS1 disc memory layouts requires extreme precision. Follow these non-negotiable directives at all times.

---

## 1. Non-Negotiable Directives

### 1. Never Commit Local AI Orchestrators
* `ai-context-loader.md` and `AI-CONTEXT-LOADER.md` are local orchestrators designed solely for AI agents working in development environments.
* They **MUST REMAIN IN `.gitignore`** and must **NEVER** be committed or pushed to the public GitHub repository.

### 2. Never Commit Disc Images or Copyrighted BIOS Files
* Never commit or stage `.bin`, `.cue`, `.iso`, `.img`, or `SCPH*.BIN` files.
* Only sparse mod asset runs located strictly under `mods/**/assets/*.bin` are permitted to be committed to version control.
* Always build and run against the bundled, clean-room OpenBIOS.

### 3. Maintain Integrity of Generated Shards (`generated/`)
* Do not manually rewrite, reformat, or alter function declarations across the 35 shards (`SCUS_942.54_full_00.c` .. `34.c`) or `SCUS_942.54_dispatch.c` unless regenerating them using `psxrecomp_cli.py generate`.
* Mod logic belongs in `mods/` or clean, modular C hooks in the runtime, not as random manual edits inside 1.26 million lines of recompiled machine code.

### 4. Respect Escape Codes & Formatting in Translations
* When modifying `translations/*.toml`, never remove or alter escape sequences:
  - `{c1:00}`, `{c1:01}`, `{c1:02}`: Hero character name substitutions.
  - `{c2:xx}`, `{c3:xx}`, `{c4:xx}`, `{c5:xx}`: Item and Art substitutions.
  - `{cf:xx}`: Color palette codes.
  - `|`: Dialogue line break.
* Ensure all strings are encoded in valid UTF-8 without control character corruption.

### 5. Always Run Verification Builds
* Before completing any task that modifies C code, CMake files, or configuration:
  ```bash
  cmake --build build-release
  ```
* Verify that the executable links without errors.

### 6. Apply Ponytail Rules
* No unnecessary abstractions.
* No boilerplate.
* Shortest working diff wins.
