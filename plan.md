# Implementation Plan: Mamoth Mod for Luanti

## Architecture

The mod is a single-directory Luanti mod with five files. All game logic lives in `init.lua`, organized into four sections. Dependencies: `default` mod and `mobs` (Mobs Redo framework).

```
mammoth-parent/code/mammoth/
├── mod.conf                    # Mod metadata
├── init.lua                    # All logic (tusk item, mob def, spawning, egg)
└── textures/
    ├── mammoth_mammoth.png      # 16x16 two-tone brown (mob body)
    ├── mammoth_tusk.png         # 16x16 two-tone ivory (tusk item)
    └── mammoth_egg.png          # 16x16 two-tone tan (spawn egg)
```

## Design Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Framework | Mobs Redo by TenPlus1 | Handles AI, spawning, taming, breeding, capture |
| Mob type | Neutral animal | `attack_type = "dogfight"` retaliates when hit |
| Visual | `"cube"` stretched | Simple placeholder; proper mesh can come later |
| Namespace | `core` (not `minetest`) | Modern Luanti convention, matches pruner mod |
| Code layout | Section-based single file | Matches pruner mod style |
| Textures | Two-tone programmatic PNGs | Minimal detail placeholders with visual interest |

## Implementation Sections (init.lua)

### Section A: Custom Item Registration
- `core.register_craftitem("mammoth:tusk", {...})` with description and inventory image
- No crafting recipe — drop-only item

### Section B: Mob Definition
- `mobs:register_mob("mammoth:mammoth", {...})` with all properties:
  - `type = "animal"`, `passive = false`, `attacks_monsters = false`
  - `attack_type = "dogfight"`, `group_attack = true`
  - `hp_min = 30, hp_max = 50`, `armor = 100`
  - `walk_velocity = 1, run_velocity = 3`
  - `jump = false, stepheight = 1.1, fear_height = 4`
  - `damage = 4, reach = 3`
  - `visual = "cube"`, `visual_size = {x = 3, y = 2.5}`
  - Textures: 6 identical `"mammoth_mammoth.png"` entries
  - `collisionbox = {-0.8, -1.0, -0.8, 0.8, 0.8, 0.8}`
  - Drops table with meat_raw, leather, and tusk
  - `follow = {"default:wheat", "default:dry_grass_1"}`
  - `on_rightclick = mobs.feed_tame` (standard Mobs Redo taming)
  - `water_damage = 0, floats = 1, lava_damage = 5`

### Section C: Spawn Configuration
- `mobs:spawn({...})` with:
  - `name = "mammoth:mammoth"`
  - `nodes = {"default:dirt_with_snow", "default:snowblock", "default:ice"}`
  - `chance = 12000, active_object_count = 2`
  - `min_light = 0, max_light = 15`

### Section D: Spawn Egg Registration
- `mobs:register_egg("mammoth:mammoth", "Mammoth", "mammoth_egg.png", 1)`

## mod.conf Structure

```
name = mammoth
description = Adds a woolly mammoth mob that roams snowy biomes
depends = default, mobs
```

## Textures (Programmatic PNGs)

All three textures are 16x16 pixel PNGs generated programmatically:

- **mammoth_mammoth.png**: Two-tone brown — lighter brown top half (#8B6914), darker brown bottom half (#5C4410)
- **mammoth_tusk.png**: Two-tone ivory — lighter cream top half (#FFFFF0), darker cream bottom half (#D2C6A5)
- **mammoth_egg.png**: Two-tone tan — lighter tan top half (#D2B48C), darker tan bottom half (#A0855B)

## Risk Assessment

| Risk | Likelihood | Mitigation |
|------|-----------|------------|
| PNG generation produces invalid file | Low | Use known-good minimal PNG byte sequence with correct checksums |
| Mobs Redo API mismatch | Low | Using well-documented, stable API functions |
| Visual size/collision mismatch | Medium | Collision box set tighter than visual; test in-game |
| Taming count not exposed directly | Low | Mobs Redo uses `on_rightclick` with internal feed counter |
