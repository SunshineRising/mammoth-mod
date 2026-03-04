-- Mammoth Mod for Luanti
-- Adds a woolly mammoth mob that roams snowy biomes

-- Section A: Custom Item Registration

core.register_craftitem("mammoth:tusk", {
    description = "Mammoth Tusk",
    inventory_image = "mammoth_tusk.png",
})

-- Section B: Mob Definition

mobs:register_mob("mammoth:mammoth", {
    type = "animal",
    passive = false,
    attacks_monsters = false,
    attack_type = "dogfight",
    group_attack = true,
    damage = 4,
    reach = 3,
    hp_min = 30,
    hp_max = 50,
    armor = 100,
    walk_velocity = 1,
    run_velocity = 3,
    breed = true,
    breed_distance = 10,
    jump = true,
    jump_height = 1,
    stepheight = 2,
    fear_height = 4,
    visual = "mesh",
    mesh = "mammoth_mammoth.b3d",
    visual_size = {x = 3.0, y = 3.0},
    textures = {
        {"mammoth_mammoth_mesh.png"},
    },
    collisionbox = {-3.0, -0.01, -3.0, 3.0, 6, 3.0},
    view_range = 16,
    baby_size = 0.4,
    makes_footstep_sound = true,
    pathfinding = true,
    animation = {
        speed_normal = 80,
        stand_start = 0,
        stand_end = 100,
        walk_start = 300,
        walk_end = 450,
        punch_start = 100,
        punch_end = 300,
        die_start = 200,
        die_end = 300,
        die_speed = 50,
        die_loop = false,
        die_rotate = true,
    },
    drops = {
        {name = "mobs:meat_raw", chance = 1, min = 2, max = 5},
        {name = "mobs:leather", chance = 1, min = 1, max = 3},
        {name = "mammoth:tusk", chance = 2, min = 1, max = 2},
    },
    follow = {"default:wheat", "default:dry_grass_1"},
    on_rightclick = function(self, clicker)
        if mobs:feed_tame(self, clicker, 10, true, true) then
            return
        end
        if mobs:capture_mob(self, clicker, 0, 60, 5, false, nil) then
            return
        end
    end,
    water_damage = 0,
    floats = 1,
    lava_damage = 5,
})

-- Section C: Spawn Configuration

mobs:spawn({
    name = "mammoth:mammoth",
    nodes = {"default:dirt_with_snow", "default:snowblock", "default:ice"},
    chance = 12000,
    active_object_count = 2,
    min_light = 0,
    max_light = 15,
})

-- Section D: Spawn Egg Registration

mobs:register_egg("mammoth:mammoth", "Mammoth", "mammoth_egg.png", 1)
