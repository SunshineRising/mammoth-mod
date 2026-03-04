# Tasks: Mamoth Mod for Luanti

## Task Overview

| Task | Description | Dependencies | Status |
|------|-------------|-------------|--------|
| T1 | Create mod directory structure and mod.conf | None | done |
| T2 | Generate three placeholder textures | T1 | done |
| T3 | Write init.lua — tusk item and mob definition | T1 | done |
| T4 | Write init.lua — spawn config and egg registration | T3 | done |

---

### T1: Create mod directory structure and mod.conf

**Status**: done
**Dependencies**: None

Create the `mammoth/` directory inside `mammoth-parent/code/`, including `textures/` subdirectory, and write `mod.conf`.

**Acceptance criteria**:
- `mammoth-parent/code/mammoth/` directory exists
- `mammoth-parent/code/mammoth/textures/` directory exists
- `mammoth-parent/code/mammoth/mod.conf` contains:
  ```
  name = mammoth
  description = Adds a woolly mammoth mob that roams snowy biomes
  depends = default, mobs
  ```

**Files**:
- Create: `mammoth/mod.conf`

---

### T2: Generate three placeholder textures

**Status**: done
**Dependencies**: T1

Generate three minimal valid 16x16 PNG files with two-tone coloring:

1. `mammoth/textures/mammoth_mammoth.png` — two-tone brown (lighter top, darker bottom)
2. `mammoth/textures/mammoth_tusk.png` — two-tone ivory/cream (lighter top, darker bottom)
3. `mammoth/textures/mammoth_egg.png` — two-tone tan (lighter top, darker bottom)

**Acceptance criteria**:
- All three files exist and are valid PNGs
- Each image is 16x16 pixels
- Each has visible two-tone coloring (top half lighter, bottom half darker)

**Files**:
- Create: `mammoth/textures/mammoth_mammoth.png`
- Create: `mammoth/textures/mammoth_tusk.png`
- Create: `mammoth/textures/mammoth_egg.png`

---

### T3: Write init.lua — tusk item and mob definition

**Status**: done
**Dependencies**: T1

Write `init.lua` containing:
- Section A: `core.register_craftitem("mammoth:tusk", {...})` with description "Mammoth Tusk" and `inventory_image = "mammoth_tusk.png"`
- Section B: `mobs:register_mob("mammoth:mammoth", {...})` with all properties from the spec:
  - type animal, neutral (passive=false, attacks_monsters=false), dogfight attack, group_attack
  - HP 30-50, armor 100, damage 4, reach 3
  - walk_velocity 1, run_velocity 3, jump false, stepheight 1.1, fear_height 4
  - cube visual, visual_size {x=3, y=2.5}, 6x mammoth_mammoth.png textures
  - collisionbox {-0.8, -1.0, -0.8, 0.8, 0.8, 0.8}
  - Drops: meat_raw (2-5), leather (1-3), tusk (1-2 at 50%)
  - follow wheat + dry_grass_1, on_rightclick = mobs.feed_tame
  - water_damage 0, floats 1, lava_damage 5

**Acceptance criteria**:
- `mammoth/init.lua` exists with tusk registration and mob definition
- Uses `core` namespace (not `minetest`)
- All mob properties match spec values
- Section comments match pruner mod style

**Files**:
- Create: `mammoth/init.lua`

---

### T4: Write init.lua — spawn config and egg registration

**Status**: done
**Dependencies**: T3

Append to `init.lua`:
- Section C: `mobs:spawn({...})` with name, nodes (dirt_with_snow, snowblock, ice), chance 12000, active_object_count 2, min_light 0, max_light 15
- Section D: `mobs:register_egg("mammoth:mammoth", "Mammoth", "mammoth_egg.png", 1)`

**Acceptance criteria**:
- Spawn configuration targets only snowy/icy nodes
- Chance is 12000, max 2 per section
- Egg registered with correct texture
- Uses `core` namespace throughout

**Files**:
- Edit: `mammoth/init.lua`
