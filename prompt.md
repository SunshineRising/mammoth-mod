Build a Luanti mod called "mammoth" that adds a woolly mammoth mob using the Mobs Redo framework by TenPlus1. The mod lives at `mammoth-parent/code/mammoth/` and depends on "default" and "mobs".

**Mod structure:**
- `mod.conf` — name is `mammoth`, depends on `default` and `mobs`
- `init.lua` — all logic in one file, organized into sections: custom item registration, mob definition, spawn configuration, and spawn egg registration. Use the `core` namespace throughout (not `minetest`).
- `textures/` — three placeholder 16x16 solid-color PNGs: `mammoth_mammoth.png` (brown, for the mob body), `mammoth_tusk.png` (ivory/cream, for the tusk item), and `mammoth_egg.png` (for the spawn egg)

**Custom item:** Register one craftitem `mammoth:tusk` — an ivory mammoth tusk drop with no crafting recipe. Uses `mammoth_tusk.png` as its inventory image.

**Mob definition** (registered via `mobs:register_mob("mammoth:mammoth", {...})`):
- Type: `"animal"`, passive until attacked. HP: 30–50. Armor: 100 (slightly tougher than default).
- Slow walk speed, faster run speed when attacking. Cannot jump but `stepheight` is 1.1 so it handles slopes. `fall_speed` is default (takes fall damage). Avoids cliffs.
- Melee attack dealing roughly twice cow damage, with extended reach for its size. Group attack enabled so nearby mammoths join fights (herd defense).
- Visual: Use `"cube"` visual type, stretched to an elongated shape (wider than tall, longer than wide) via `visual_size` to suggest a large quadruped. Single texture `mammoth_mammoth.png` on all faces. Collision box slightly tighter than visual to prevent terrain clipping.
- Drops: 2–5 `mobs:meat_raw` (guaranteed), 1–3 `mobs:leather` (guaranteed), 1–2 `mammoth:tusk` at 50% chance.
- Taming: Follow item is `"default:wheat"` and `"default:dry_grass_1"`. Taming is done by right-click feeding 10 times. Tamed mammoths won't attack their owner.
- Breeding: Two tamed, well-fed mammoths can breed to produce a baby.
- Capture: Lasso at 60%, net at 5%.
- Sounds: Can be left empty or nil for now.
- Floats in water, takes lava damage.

**Spawning** (via `mobs:spawn({...})`):
- Spawns on `"default:dirt_with_snow"`, `"default:snowblock"`, and `"default:ice"`.
- Daytime only, any light level. Chance: 1 in 12000. Max 2 active per map section.

**Spawn egg:** Register via `mobs:register_egg("mammoth:mammoth", ...)` using `mammoth_egg.png`.

Use the existing pruner mod at `pruner-parent/code/pruner/` as a reference for style, the `core` namespace convention, and section-based code organization.
