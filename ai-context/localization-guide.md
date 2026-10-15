# 🌐 Localization & Translation Guide: LegaiaRecomp

## 1. Overview of the Localization System
LegaiaRecomp introduces a modern, high-performance localization architecture designed to make translating the game clean, fast, and completely free of legacy PlayStation 1 ROM hacking limitations.

In original PS1 ROM hacking:
- Strings were hardcoded in fixed memory locations.
- Translations had to adhere to strict **byte budgets**; any translation longer than the original English string would overwrite adjacent memory and crash the game.
- Character sets were limited to fixed 8-bit ASCII tables.

In **LegaiaRecomp**:
- The **`text_xlate`** subsystem intercepts string rendering calls at runtime.
- It computes a 64-bit **FNV-1a hash** of the source string.
- If a translation exists in the active translation table (`translations/*.toml`), the engine dynamically substitutes the text from a managed string arena.
- **No string length limits:** Translations can be as long and natural as needed without risking memory corruption!

---

## 2. Configuration (`game.toml`)
Localization is configured in `game.toml`:

```toml
[localization]
enabled = true
language = "id"
path = "translations/legaia_id.toml"
```

To switch languages, change the `language` code and `path` to the desired language file (e.g. `translations/legaia_es.toml`, `translations/legaia_fr.toml`).

---

## 3. Translation File Format (`translations/legaia_id.toml`)
Translations are stored in human-readable TOML files.

### Entry Schema:
```toml
# Item Name
[[entry]]
hash = "0x89ab12cd34ef5678"
original = "Healing Berry"
translation = "Buah Pemulih"
context = "Common HP recovery item (restores 500 HP)"

# Dialogue with character code and line break
[[entry]]
hash = "0x1234567890abcdef"
original = "Look! The Genesis Tree is glowing!"
translation = "Lihat! Pohon Genesis mulai bersinar!"
context = "Scene at Rim Elm Genesis Tree"

# Dialogue with escape codes
[[entry]]
hash = "0xfedcba0987654321"
original = "{c1:00}, are you ready to depart?"
translation = "{c1:00}, apakah kamu sudah siap berangkat?"
context = "Elder asking Vahn before leaving Rim Elm"
```

---

## 4. Special Characters & Escape Codes

### 4.1 Character Name Substitutions
| Escape Code | Replaced With | Note |
| :--- | :--- | :--- |
| `{c1:00}` | Vahn | Or custom name chosen by player |
| `{c1:01}` | Noa | Heroine from Mt. Rikuroa |
| `{c1:02}` | Gala | Biron monk hero |

### 4.2 Other Engine Escape Codes
| Escape Code | Purpose |
| :--- | :--- |
| `{c2:xx}` / `{c4:xx}` | Dynamic Item / Key Name substitution |
| `{c3:xx}` | Dynamic Seru Magic Name substitution |
| `{c5:xx}` | Dynamic Tactical Arts Name substitution |
| `{cf:31}` | Color change: Gold / Highlight |
| `{cf:00}` | Color change: Default white |
| `{01}` | Item icon prefix |

### 4.3 Line Breaks
* The pipe character `|` (`ASCII 0x7C`) represents a **newline** in dialogue windows.
* Use `|` at natural sentence breaks to ensure dialogue looks balanced and readable across the 3-line dialogue box:
  ```text
  "Aku mendengar bahwa ada serangga aneh|di dalam hutan Rim Elm."
  ```

---

## 5. Adding a New Community Language
Want to add Spanish, French, Portuguese, or another language?

1. Copy `translations/legaia_id.toml` to `translations/legaia_<lang>.toml`.
2. Translate the `translation` fields while preserving `hash`, `original`, and all `{c1:xx}` / `{cf:xx}` escape codes.
3. Update `game.toml` to point to your new file:
   ```toml
   [localization]
   enabled = true
   language = "es"
   path = "translations/legaia_es.toml"
   ```
4. Test in-game and submit a pull request!
