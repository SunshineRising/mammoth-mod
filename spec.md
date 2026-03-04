# Feature Specification: Mamoth Mod for Luanti

## Overview

A Luanti mod that adds a **Woolly Mammoth** mob using the Mobs Redo framework by TenPlus1. The mammoth is a large, neutral animal that roams snowy biomes. It is passive until attacked, at which point it and nearby mammoths fight back as a herd. Players can tame mammoths by feeding them wheat or dry grass, breed tamed pairs, and capture them with lasso or net.

## Requirements

### Functional Requirements

#### FR-1: Custom Item — Mammoth Tusk
- Register `mammoth:tusk` as a craftitem (no crafting recipe)
- Description: an ivory mammoth tusk collectible drop
- Uses `mammoth_tusk.png` as inventory image

#### FR-2: Mob Definition
- Registered via `mobs:register_mob("mammoth:mammoth", {...})`
- Type: `"animal"`, passive until attacked
- HP: 30–50 (via `hp_min = 30, hp_max = 50`)
- Armor: 100
- Walk speed: slow (~1). Run speed: faster (~3) when attacking
- Cannot jump (`jump = false`), `stepheight = 1.1` for slopes
- Default `fall_speed` (takes fall damage)
- `fear_height = 4` (avoids cliffs)

#### FR-3: Combat Behavior
- Melee attack: ~4 damage (roughly twice cow damage of ~2)
- Extended reach: `reach = 3` for large body size
- `group_attack = true` — nearby mammoths join fights (herd defense)
- `attack_type = "dogfight"`
- Tamed mammoths do not attack their owner

#### FR-4: Visual Appearance
- `visual = "cube"` stretched to elongated shape
- `visual_size = {x = 3, y = 2.5}` — wider than tall, suggesting a large quadruped
- Single texture `mammoth_mammoth.png` on all six faces (list of 6 identical entries)
- Collision box tighter than visual: approximately `{-0.8, -1.0, -0.8, 0.8, 0.8, 0.8}`

#### FR-5: Drops
- 2–5 `mobs:meat_raw` (guaranteed, chance = 1)
- 1–3 `mobs:leather` (guaranteed, chance = 1)
- 1–2 `mammoth:tusk` at 50% chance (chance = 0.5)

#### FR-6: Taming and Breeding
- Follow items: `{"default:wheat", "default:dry_grass_1"}`
- Taming via right-click feeding, 10 feedings to tame (`follow_count = 10`)
- Two tamed, well-fed mammoths can breed to produce a baby
- `child_texture = {"mammoth_mammoth.png"}` (same texture, scaled smaller by framework)

#### FR-7: Capture
- Lasso: 60% success (`lasso = 60`)
- Net: 5% success (`net = 5`)

#### FR-8: Environmental Behavior
- Floats in water (`water_damage = 0`, `floats = 1`)
- Takes lava damage (`lava_damage = 5`)

#### FR-9: Spawning
- Via `mobs:spawn({...})`
- Spawn nodes: `{"default:dirt_with_snow", "default:snowblock", "default:ice"}`
- Daytime only (`min_light = 0, max_light = 15`, `active_object_count = 2`)
- Chance: 1 in 12000 (`chance = 12000`)
- Max 2 active per map section

#### FR-10: Spawn Egg
- Via `mobs:register_egg("mammoth:mammoth", "Mammoth", "mammoth_egg.png", 1)`

### Non-Functional Requirements

#### NFR-1: Code Conventions
- Uses the `core` namespace throughout (modern Luanti convention, not legacy `minetest` alias)
- Texture naming follows Luanti convention: `modname_itemname.png`
- Section-based code organization matching the pruner mod style

#### NFR-2: Dependencies
- Hard dependency on `default` mod (for wheat, dry grass, snow/ice node references)
- Hard dependency on `mobs` mod (Mobs Redo framework for mob registration, AI, spawning, taming, breeding)

#### NFR-3: Sounds
- Left empty/nil for this version — no custom sounds

## Mod Structure

```
mammoth-parent/code/mammoth/
├── mod.conf                    # Mod metadata (name, description, depends)
├── init.lua                    # All mod logic in one file
└── textures/
    ├── mammoth_mammoth.png      # 16x16 brown placeholder (mob body)
    ├── mammoth_tusk.png         # 16x16 ivory/cream placeholder (tusk item)
    └── mammoth_egg.png          # 16x16 placeholder (spawn egg)
```

Five files total.

## API Functions Used

| Function | Purpose |
|----------|---------|
| `core.register_craftitem` | Register the tusk drop item |
| `mobs:register_mob` | Register the mammoth mob entity |
| `mobs:spawn` | Configure natural spawning rules |
| `mobs:register_egg` | Register the spawn egg item |

## Edge Cases

| Edge Case | Handling |
|-----------|---------|
| Mammoth spawns near cliff | `fear_height = 4` prevents walking off edges |
| Player attacks tamed mammoth | Tamed mammoths do not retaliate against owner |
| Mammoth in water | Floats, takes no water damage |
| Mammoth in lava | Takes 5 damage per tick |
| No Mobs Redo installed | Hard dependency prevents mod loading |
| Mammoth at unloaded chunk border | Handled by Mobs Redo framework |

## Clarification Decisions

- **Mob behavior**: Neutral (retaliates when attacked), not fully passive. Uses `attack_type = "dogfight"` with `passive = false` and `attacks_monsters = false`.
- **Textures**: Two-tone minimal detail placeholders (e.g., darker bottom half on body texture for visual interest)
- **Artifact location**: All SpecSwarm artifacts (spec.md, plan.md, tasks.md) live in `mammoth-parent/code/` alongside prompt.md

## Out of Scope

- Custom 3D mesh model (using cube placeholder for now)
- Custom sounds or particle effects
- Rideable mammoth
- Mammoth-specific crafting recipes using tusks
- Server-configurable settings (spawn rate, HP, etc.)

## Testing Plan

1. Place mod in Luanti mods directory alongside Mobs Redo and default game
2. Enable mod for a test world
3. `/giveme mammoth:tusk` — verify tusk item registered properly
4. `/spawnentity mammoth:mammoth` or use spawn egg — check appearance and size
5. Hit the mammoth — verify it fights back with herd defense
6. Hold wheat near mammoth — confirm it follows
7. Right-click feed wheat 10 times — confirm taming with heart particles
8. Kill a mammoth — verify correct drops (meat, leather, tusk at 50%)
9. Travel to snowy biome — verify natural spawning on snow/ice only
