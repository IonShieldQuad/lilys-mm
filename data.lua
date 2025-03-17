local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")


function minituarize(anim)
    if anim.layers then
        for _, layer in ipairs(anim.layers) do
            if layer.scale then
                layer.scale = layer.scale * 0.6
            end
        end
    else
        if anim.scale then
            anim.scale = anim.scale * 0.6
        end
    end
    return anim
end

-- basic
local mm_i = {
    type = "ammo",
    name = "micromissile",
    icon = "__lilys-mm__/graphics/icons/micromissile.png",
    ammo_category = "rocket",
    ammo_type =
    {
        target_type = "position",
        range_modifier = 1.4,
        cooldown_modifier = 0.1,
        action =
        {
            type = "direct",
            action_delivery =
            {
                type = "projectile",
                projectile = "micromissile",
                starting_speed = 0.4,
                starting_speed_deviation = 0.25,
                direction_deviation = 0.1,
                range_deviation = 0.1,
                
                source_effects =
                {
                    type = "create-entity",
                    entity_name = "explosion-hit"
                }
            }
        }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-e[micromissile]",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_move,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 1000,
    weight = 5 * kg
}

data:extend({mm_i})

--basic projectile
local mm = {
    type = "projectile",
    name = "micromissile",
    flags = { "not-on-map" },
    hidden = true,
    acceleration = 0.1,
    turn_speed = 0.1,
    force_condition = "not-same",
    --turning_speed_increases_exponentially_with_projectile_speed = true,
    collision_box = { { -0.5, -0.3 }, { 0.5, 0.3 } },
    action = {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "create-entity",
                    entity_name = "explosion"
                },
                {
                    type = "damage",
                    damage = { amount = 40, type = "explosion" }
                },
                {
                    type = "create-entity",
                    entity_name = "small-scorchmark-tintable",
                    check_buildability = true
                },
                {
                    type = "invoke-tile-trigger",
                    repeat_count = 1
                },
                {
                    type = "destroy-decoratives",
                    from_render_layer = "decorative",
                    to_render_layer = "object",
                    include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                    include_decals = false,
                    invoke_decorative_trigger = true,
                    decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                    radius = 0.5               -- large radius for demostrative purposes
                }
            }
        }
    },
    --light = {intensity = 0.5, size = 4},
    animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({ 1, 0.8, 0.3 }),
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
    smoke = require("__base__.prototypes.entity.rocket-projectile-pictures").smoke,
}


mm.animation = minituarize(mm.animation)
mm.shadow = minituarize(mm.shadow)
data:extend({mm})



-- homing
local mmh_i = {
    type = "ammo",
    name = "micromissile-homing",
    icon = "__lilys-mm__/graphics/icons/micromissile-homing.png",
    ammo_category = "rocket",
    ammo_type =
    {
        target_type = "entity",
        range_modifier = 1.4,
        cooldown_modifier = 0.1,
        action =
        {
            type = "direct",
            action_delivery =
            {
                type = "projectile",
                projectile = "micromissile-homing",
                starting_speed = 0.4,
                starting_speed_deviation = 0.25,
                direction_deviation = 0.2,
                range_deviation = 0.2,
                
                source_effects =
                {
                    type = "create-entity",
                    entity_name = "explosion-hit"
                }
            }
        }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-f[micromissile-homing]",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_move,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 1000,
    weight = 10 * kg
}

data:extend({ mmh_i })

-- homing projectile
local mmh = {
    type = "projectile",
    name = "micromissile-homing",
    flags = { "not-on-map" },
    hidden = true,
    acceleration = 0.1,
    turn_speed = 0.1,
    --turning_speed_increases_exponentially_with_projectile_speed = true,
    action =
    {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "create-entity",
                    entity_name = "explosion"
                },
                {
                    type = "damage",
                    damage = { amount = 40, type = "explosion" }
                },
                {
                    type = "create-entity",
                    entity_name = "small-scorchmark-tintable",
                    check_buildability = true
                },
                {
                    type = "invoke-tile-trigger",
                    repeat_count = 1
                },
                {
                    type = "destroy-decoratives",
                    from_render_layer = "decorative",
                    to_render_layer = "object",
                    include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                    include_decals = false,
                    invoke_decorative_trigger = true,
                    decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                    radius = 0.5                           -- large radius for demostrative purposes
                }
            }
        }
    },
    --light = {intensity = 0.5, size = 4},
    animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({ 1, 0.8, 0.3 }),
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
    smoke = require("__base__.prototypes.entity.rocket-projectile-pictures").smoke,
}


mmh.animation = minituarize(mmh.animation)
mmh.shadow = minituarize(mmh.shadow)
data:extend({ mmh })



-- explosive
local mme_i = {
    type = "ammo",
    name = "micromissile-explosive",
    icon = "__lilys-mm__/graphics/icons/micromissile-explosive.png",
    ammo_category = "rocket",
    ammo_type =
    {
        target_type = "position",
        range_modifier = 1.2,
        cooldown_modifier = 0.1,
        action =
        {
            type = "direct",
            action_delivery =
            {
                type = "projectile",
                projectile = "micromissile-explosive",
                starting_speed = 0.4,
                starting_speed_deviation = 0.25,
                direction_deviation = 0.15,
                range_deviation = 0.15,
                
                source_effects =
                {
                    type = "create-entity",
                    entity_name = "explosion-hit"
                }
            }
        }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-f[micromissile-explosive]",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_move,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 1000,
    weight = 10 * kg
}

data:extend({ mme_i })

--explosive projectile
local mme = {
    type = "projectile",
    name = "micromissile-explosive",
    flags = { "not-on-map" },
    hidden = true,
    acceleration = 0.1,
    turn_speed = 0.1,
    force_condition = "not-same",
    --turning_speed_increases_exponentially_with_projectile_speed = true,
    collision_box = { { -0.5, -0.3 }, { 0.5, 0.3 } },
    action = {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "explosion"
          },
          {
            type = "damage",
            damage = {amount = 20, type = "explosion"}
          },
          {
            type = "create-entity",
            entity_name = "medium-scorchmark-tintable",
            check_buildability = true
          },
          {
            type = "invoke-tile-trigger",
            repeat_count = 1
          },
          {
            type = "destroy-decoratives",
            from_render_layer = "decorative",
            to_render_layer = "object",
            include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
            include_decals = false,
            invoke_decorative_trigger = true,
            decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
            radius = 2.5 -- large radius for demostrative purposes
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = 3.5,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = 35, type = "explosion"}
                  },
                  {
                    type = "create-entity",
                    entity_name = "explosion"
                  }
                }
              }
            }
          }
        }
      }
    },
    --light = {intensity = 0.5, size = 4},
    animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({ 1, 0.2, 0.2 }),
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
    smoke = require("__base__.prototypes.entity.rocket-projectile-pictures").smoke,
}


mme.animation = minituarize(mme.animation)
mme.shadow = minituarize(mme.shadow)
data:extend({ mme })


-- incendiary
local mmi_i = {
    type = "ammo",
    name = "micromissile-incendiary",
    icon = "__lilys-mm__/graphics/icons/micromissile-incendiary.png",
    ammo_category = "rocket",
    ammo_type =
    {
        target_type = "position",
        range_modifier = 1.2,
        cooldown_modifier = 0.1,
        action =
        {
            type = "direct",
            action_delivery =
            {
                type = "projectile",
                projectile = "micromissile-incendiary",
                starting_speed = 0.4,
                starting_speed_deviation = 0.25,
                direction_deviation = 0.15,
                range_deviation = 0.15,
                
                source_effects =
                {
                    type = "create-entity",
                    entity_name = "explosion-hit"
                }
            }
        }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-f[micromissile-incendiary]",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_move,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 1000,
    weight = 10 * kg
}


data:extend({ mmi_i })


--incendiary projectile
local mmi = {
    type = "projectile",
    name = "micromissile-incendiary",
    flags = { "not-on-map" },
    hidden = true,
    acceleration = 0.1,
    turn_speed = 0.1,
    force_condition = "not-same",
    --turning_speed_increases_exponentially_with_projectile_speed = true,
    collision_box = { { -0.5, -0.3 }, { 0.5, 0.3 } },
    action = {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "create-entity",
                    entity_name = "explosion"
                },
                {
                    type = "damage",
                    damage = { amount = 10, type = "explosion" }
                }, 
                {
                type = "damage",
                damage = { amount = 20, type = "fire" }
                },
                {
                    type = "create-entity",
                    entity_name = "medium-scorchmark-tintable",
                    check_buildability = true
                },
                {
                    type = "invoke-tile-trigger",
                    repeat_count = 1
                },
                {
                    type = "create-sticker",
                    sticker = "fire-sticker",
                    show_in_tooltip = true
                },
                {
                    type = "create-fire",
                    entity_name = "fire-flame",
                    show_in_tooltip = true,
                    initial_ground_flame_count = 2
                },
                {
                    type = "destroy-decoratives",
                    from_render_layer = "decorative",
                    to_render_layer = "object",
                    include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                    include_decals = false,
                    invoke_decorative_trigger = true,
                    decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                    radius = 2.5                   -- large radius for demostrative purposes
                },
                {
                    type = "nested-result",
                    action =
                    {
                        type = "area",
                        radius = 3.5,
                        action_delivery =
                        {
                            type = "instant",
                            target_effects =
                            {
                                {
                                    type = "damage",
                                    damage = { amount = 35, type = "fire" },
                                    apply_damage_to_trees = false
                                },
                                {
                                    type = "create-sticker",
                                    sticker = "fire-sticker",
                                    show_in_tooltip = true
                                },
                            }
                        }
                    }
                }
            }
        }
    },
    --light = {intensity = 0.5, size = 4},
    animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({ 1, 0.6, 0.0 }),
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
    smoke = require("__base__.prototypes.entity.rocket-projectile-pictures").smoke,
}


mmi.animation = minituarize(mmi.animation)
mmi.shadow = minituarize(mmi.shadow)

data:extend({ mmi })




-- kinetic
local mmk_i = {
    type = "ammo",
    name = "micromissile-kinetic",
    icon = "__lilys-mm__/graphics/icons/micromissile-kinetic.png",
    ammo_category = "rocket",
    ammo_type =
    {
        target_type = "position",
        range_modifier = 1.2,

        cooldown_modifier = 0.1,
        action =
        {
            type = "direct",
            action_delivery =
            {
                type = "projectile",
                projectile = "micromissile-kinetic",
                starting_speed = 0.8,
                starting_speed_deviation = 0.25,
                direction_deviation = 0.05,
                range_deviation = 0.05,
                
                source_effects =
                {
                    type = "create-entity",
                    entity_name = "explosion-hit"
                }
            }
        }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-f[micromissile-kinetic]",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_move,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 1000,
    weight = 10 * kg
}

data:extend({ mmk_i })

--kinetic projectile
local mmk = {
    type = "projectile",
    name = "micromissile-kinetic",
    flags = { "not-on-map" },
    hidden = true,
    acceleration = 0.1,
    turn_speed = 0.1,
    direction_only = true,
    force_condition = "not-same",
    --turning_speed_increases_exponentially_with_projectile_speed = true,
    collision_box = { { -0.5, -0.3 }, { 0.5, 0.3 } },
    piercing_damage = 500,
    action = {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "create-entity",
                    entity_name = "explosion-hit",
                    offsets = { { 0, 1 } },
                    offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } }
                },
                {
                    type = "damage",
                    damage = { amount = 80, type = "physical" }
                },
                {
                    type = "invoke-tile-trigger",
                    repeat_count = 1
                },
                {
                    type = "destroy-decoratives",
                    from_render_layer = "decorative",
                    to_render_layer = "object",
                    include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                    include_decals = false,
                    invoke_decorative_trigger = true,
                    decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                    radius = 0.5                           -- large radius for demostrative purposes
                },
            }
        }
    },
    --light = {intensity = 0.5, size = 4},
    animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({ 0.4, 0.0, 0.5 }), 
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
    smoke = require("__base__.prototypes.entity.rocket-projectile-pictures").smoke,
}


mmk.animation = minituarize(mmk.animation)
mmk.shadow = minituarize(mmk.shadow)
data:extend({ mmk })

local mma_i = {}
local mma = {}
if mods["space-age"] then
-- arc
mma_i = {
    type = "ammo",
    name = "micromissile-arc",
    icon = "__lilys-mm__/graphics/icons/micromissile-arc.png",
    ammo_category = "rocket",
    ammo_type =
    {
        target_type = "position",
        range_modifier = 1.2,

        cooldown_modifier = 0.1,
        action =
        {
            type = "direct",
            action_delivery =
            {
                type = "projectile",
                projectile = "micromissile-arc",
                starting_speed = 0.4,
                starting_speed_deviation = 0.25,
                direction_deviation = 0.1,
                range_deviation = 0.1,
                
                source_effects =
                {
                    type = "create-entity",
                    entity_name = "explosion-hit"
                }
            }
        }
    },
    subgroup = "ammo",
    order = "d[rocket-launcher]-f[micromissile-arc]",
    inventory_move_sound = item_sounds.ammo_small_inventory_move,
    pick_sound = item_sounds.ammo_small_inventory_move,
    drop_sound = item_sounds.ammo_small_inventory_move,
    stack_size = 1000,
    weight = 10 * kg
}

data:extend({ mma_i })

local beam = table.deepcopy(data.raw["beam"]["chain-tesla-gun-beam-bounce"])
beam.name = "micromissile-arc-chain-beam-bounce"
for _, effect in ipairs(beam.action.action_delivery.target_effects) do
    if effect.type == "damage" then
            effect.damage = { amount = 3, type = "electric" }
    end
end
local arc = table.deepcopy(data.raw["chain-active-trigger"]["chain-tesla-gun-chain"])
arc.name = "chain-micromissile-arc"
arc.max_jumps = 2
arc.max_range_per_jump = 8
arc.fork_chance = 0.2
arc.jump_delay_ticks = 0
local arcdel = arc.action.action_delivery
arcdel.beam = "micromissile-arc-chain-beam-bounce"
arcdel.max_range = 8.5
arcdel.duration = 20
data:extend({beam, arc})


--arc projectile
mma = {
    type = "projectile",
    name = "micromissile-arc",
    flags = { "not-on-map" },
    hidden = true,
    acceleration = 0.1,
    turn_speed = 0.1,
    force_condition = "not-same",
    --turning_speed_increases_exponentially_with_projectile_speed = true,
    collision_box = { { -0.5, -0.3 }, { 0.5, 0.3 } },
    action = {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            target_effects =
            {
                {
                    type = "nested-result",
                    action = {
                        type = "area",
                        radius = 2.5,
                        trigger_from_target = true,
                        action_delivery = {
                            {
                                type = "chain",
                                chain = "chain-micromissile-arc"
                            },
                            {
                                type = "beam",
                                add_to_shooter = false,
                                beam = "micromissile-arc-chain-beam-bounce",
                                duration = 20,
                                max_length = 8
                            }
                        }
                    }
                },
                {
                    type = "damage",
                    damage = { amount = 5, type = "physical" }
                },
                {
                    type = "damage",
                    damage = { amount = 20, type = "electric" }
                },
                {
                    type = "push-back",
                    distance = 0.5
                },
                {
                    type = "create-sticker",
                    sticker = "tesla-turret-stun"
                },
                {
                    type = "create-sticker",
                    sticker = "tesla-turret-slow"
                },
                {
                    type = "create-entity",
                    entity_name = "small-scorchmark-tintable",
                    check_buildability = true
                },
                {
                    type = "invoke-tile-trigger",
                    repeat_count = 1
                },
                {
                    type = "destroy-decoratives",
                    from_render_layer = "decorative",
                    to_render_layer = "object",
                    include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                    include_decals = false,
                    invoke_decorative_trigger = true,
                    decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                    radius = 0.5                           -- large radius for demostrative purposes
                },
            }
        }
    },
    --light = {intensity = 0.5, size = 4},
    animation = require("__base__.prototypes.entity.rocket-projectile-pictures").animation({ 0.0, 0.5, 1.0 }),
    shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
    smoke = require("__base__.prototypes.entity.rocket-projectile-pictures").smoke,
}


mma.animation = minituarize(mma.animation)
mma.shadow = minituarize(mma.shadow)
data:extend({ mma })

end

--recipe basic
data:extend({
    {
        type = "recipe",
        name = "micromissile",
        category = (mods["Age-of-Production"] and "ammunition-or-crafting" or "advanced-crafting"),
        subgroup = "ammo",
        allow_productivity = true,
        enabled = false,
        energy_required = 5,
        ingredients =
        {
            { type = "item",  name = (mods["space-age"] and "carbon-fiber" or "low-density-structure"), amount = 2 },
            { type = "item", name = "rocket-fuel",   amount = 1 },
            { type = "item",  name = "explosives",   amount = 1 }
        },
        results = { { type = "item", name = "micromissile", amount = 10 } }
    }
})
if mods["space-age"] then
--recipe basic
data:extend({
    {
        type = "recipe",
        name = "micromissile-alt",
        category = (mods["Age-of-Production"] and "ammunition-or-crafting" or "advanced-crafting"),
        subgroup = "ammo",
        allow_productivity = true,
        enabled = false,
        energy_required = 5,
        ingredients =
        {
            { type = "item", name = "low-density-structure", amount = 2 },
            { type = "item", name = "rocket-fuel",                                                     amount = 1 },
            { type = "item", name = "explosives",                                                      amount = 1 }
        },
        results = { { type = "item", name = "micromissile", amount = 10 } }
    }
})
end

--recipe homing
data:extend({
    {
        type = "recipe",
        name = "micromissile-homing",
        category = (mods["Age-of-Production"] and "ammunition-or-crafting" or "advanced-crafting"),
        subgroup = "ammo",
        allow_productivity = false,
        enabled = false,
        energy_required = 1,
        ingredients =
        {
            { type = "item", name = "micromissile",    amount = 1 },
            { type = "item", name = "processing-unit", amount = 1 }
        },
        results = { { type = "item", name = "micromissile-homing", amount = 1 } }
    }
})

--recipe explosive
data:extend({
    {
        type = "recipe",
        name = "micromissile-explosive",
        category = (mods["Age-of-Production"] and "ammunition-or-crafting" or "advanced-crafting"),
        subgroup = "ammo",
        allow_productivity = false,
        enabled = false,
        energy_required = 1,
        ingredients =
        {
            { type = "item", name = "micromissile",    amount = 1 },
            { type = "item", name = "explosives", amount = 1 }
        },
        results = { { type = "item", name = "micromissile-explosive", amount = 1 } }
    }
})

--recipe incendiary
data:extend({
    {
        type = "recipe",
        name = "micromissile-incendiary",
        category = (mods["Age-of-Production"] and "ammunition-or-chemistry-or-cryogenics" or (mods["space-age"] and "chemistry-or-cryogenics" or "chemistry")),
        crafting_machine_tint = {
            primary = { r = 1.000, g = 0.735, b = 0.643, a = 1.000 }, -- #ffbba4ff
            secondary = { r = 0.749, g = 0.557, b = 0.490, a = 1.000 }, -- #bf8e7dff
            tertiary = { r = 0.837, g = 0.637, b = 0.637, a = 1.000 }, -- #c2a2a2ff
            quaternary = { r = 0.883, g = 0.283, b = 0.283, a = 1.000 }, -- #c84848ff
            },
        subgroup = "ammo",
        allow_productivity = false,
        enabled = false,
        energy_required = 1,
        ingredients =
        {
            { type = "item", name = "micromissile",    amount = 1 },
            { type = "fluid", name = "light-oil", amount = 50 }
        },
        results = { { type = "item", name = "micromissile-incendiary", amount = 1 } }
    }
})


--recipe kinetic
data:extend({
    {
        type = "recipe",
        name = "micromissile-kinetic",
        category = (mods["Age-of-Production"] and "ammunition-or-crafting" or "advanced-crafting"),
        subgroup = "ammo",
        allow_productivity = false,
        enabled = false,
        energy_required = 1,
        ingredients =
        {
            { type = "item", name = "micromissile", amount = 1 },
            { type = "item", name = (mods["space-age"] and "tungsten-plate" or "steel-plate"), amount = (mods["space-age"] and 1 or 2) }
        },
        results = { { type = "item", name = "micromissile-kinetic", amount = 1 } }
    }
})

if mods["space-age"] then
--recipe arc
data:extend({
    {
        type = "recipe",
        name = "micromissile-arc",
            category = (mods["Age-of-Production"] and "ammunition-or-electromagnetics" or "electromagnetics"),
        subgroup = "ammo",
        allow_productivity = false,
        enabled = false,
        energy_required = 1,
        ingredients =
        {
            { type = "item", name = "micromissile",    amount = 3 },
            { type = "item", name = "supercapacitor", amount = 3 }
        },
        results = { { type = "item", name = "micromissile-arc", amount = 2 } }
    }
})
end

--technology
if mods["space-age"] then
    data.extend({
        -- technology
        {
            type = "technology",
            name = "mass-rocketry",
            icon_size = 256,
            icon = "__lilys-mm__/graphics/technology/mass-rocketry.png",
            prerequisites = {"rocket-turret", "utility-science-pack",},
            unit =
            {
                ingredients =
                {
                    { "automation-science-pack",   1 },
                    { "logistic-science-pack",     1 },
                    { "military-science-pack",     1 },
                    { "chemical-science-pack",     1 },
                    { "space-science-pack",        1 },
                    { "utility-science-pack",        1 },
                    { "agricultural-science-pack", 1 }
                },
                time = 30,
                count = 1000
            },
            effects =
            {
                {
                    type = "unlock-recipe",
                    recipe = "micromissile"
                },
                {
                    type = "unlock-recipe",
                    recipe = "micromissile-alt"
                },
                {
                    type = "unlock-recipe",
                    recipe = "micromissile-homing"
                },
                {
                    type = "unlock-recipe",
                    recipe = "micromissile-explosive"
                },
                {
                    type = "unlock-recipe",
                    recipe = "micromissile-kinetic"
                }
            }
        }
    })
else
    data.extend({
        -- technology
        {
            type = "technology",
            name = "mass-rocketry",
            icon_size = 256,
            icon = "__lilys-mm__/graphics/technology/mass-rocketry.png",
            prerequisites = { "rocketry, utility-science-pack", "rocket-fuel", "low-density-structure" },
            unit =
            {
                ingredients =
                {
                    { "automation-science-pack",   1 },
                    { "logistic-science-pack",     1 },
                    { "military-science-pack",     1 },
                    { "chemical-science-pack",     1 },
                    { "utility-science-pack",      1 }
                },
                time = 30,
                count = 1000
            },
            effects =
            {
                {
                    type = "unlock-recipe",
                    recipe = "micromissile"
                },
                {
                    type = "unlock-recipe",
                    recipe = "micromissile-homing"
                },
                {
                    type = "unlock-recipe",
                    recipe = "micromissile-explosive"
                },
                {
                    type = "unlock-recipe",
                    recipe = "micromissile-kinetic"
                }
            }
        }
    })
end
local tech = data.raw["technology"]["mass-rocketry"]
--technology
local tech_2 = table.deepcopy(data.raw["technology"]["mass-rocketry"])
tech_2.name = "mass-rocketry-2"
tech_2.icon = "__lilys-mm__/graphics/technology/mass-rocketry-2.png"
tech_2.prerequisites = { "mass-rocketry" }
tech_2.unit.count = 10000
tech_2.effects = {}

if mods["space-age"] then
    table.insert(tech_2.prerequisites, "metallurgic-science-pack")
    table.insert(tech_2.prerequisites, "electromagnetic-science-pack")
    table.insert(tech_2.unit.ingredients, {"metallurgic-science-pack", 1})
    table.insert(tech_2.unit.ingredients, {"electromagnetic-science-pack", 1})
end

table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "micromissile-incendiary"
})

if mods["space-age"] then
    table.insert(tech.effects, {
        type = "unlock-recipe",
        recipe = "micromissile-arc"
    })
end




function make_pack(missile)
    local pack = table.deepcopy(missile)
    pack.name = missile.name .. "-pack"
    pack.icon = string.gsub(missile.icon, ".png", "-pack.png")
    pack.magazine_size = 20
    pack.order = missile.order .. "-pack"
    
    pack.inventory_move_sound = item_sounds.ammo_large_inventory_move
    pack.pick_sound = item_sounds.ammo_large_inventory_move
    pack.drop_sound = item_sounds.ammo_large_inventory_move
    pack.stack_size = missile.stack_size / 10
    pack.weight = missile.weight * 20
    return pack
end
    

function make_pack_recipe(missile)
    local recipe = {
        type = "recipe",
        name = missile.name .. "-pack",
        subgroup = "ammo",
        category = (mods["Age-of-Production"] and "ammunition-or-crafting" or "crafting"),
        allow_productivity = false,
        enabled = false,
        energy_required = 1,
        ingredients =
        {
            { type = "item", name = missile.name, amount = 20 }
        },
        results = { { type = "item", name = missile.name .. "-pack", amount = 1 } }
    }
    return recipe
end

function make_swarm_pack(missile, projectile, no_scatter)
    local pack = table.deepcopy(missile)
    local proj = table.deepcopy(projectile)

    pack.name = missile.name .. "-swarm-pack"
    proj.name = projectile.name .. "-swarm"
    pack.icon = nil
    pack.icons = {
        {
            icon = string.gsub(missile.icon, ".png", "-pack.png"),
            --scale = 1
        },
        {
            icon = "__base__/graphics/icons/signal/signal-stack-size.png",
            tint = {0.70, 0.70, 0.70, 0.70},
            scale = 0.4
        },
    }
    pack.magazine_size = 20 / 4
    pack.order = missile.order .. "-swarm-pack"
    pack.ammo_type.action.repeat_count = 4

    if not no_scatter then

        if missile.ammo_type.target_type == "entity" then
            proj.turn_speed = 0.001
            proj.turning_speed_increases_exponentially_with_projectile_speed = true
            pack.ammo_type.action.action_delivery.direction_deviation = 4
            pack.ammo_type.action.action_delivery.range_deviation = pack.ammo_type.action.action_delivery.range_deviation *
            1.5
        else
            proj.turn_speed = 0.002
            proj.turning_speed_increases_exponentially_with_projectile_speed = true
            pack.ammo_type.action.action_delivery.direction_deviation = pack.ammo_type.action.action_delivery
            .direction_deviation * 2
            pack.ammo_type.action.action_delivery.range_deviation = pack.ammo_type.action.action_delivery.range_deviation *
            1.5
        end
        
        pack.ammo_type.action.action_delivery.projectile = pack.ammo_type.action.action_delivery.projectile .. "-swarm"

        local act = pack.ammo_type.action
        pack.ammo_type.action = {
            type = "direct",
            action_delivery = {
                {
                    type = "instant",
                    target_effects = {
                        {
                            type = "nested-result",
                            action = act
                        }
                    }
                },
                {
                    type = "instant",
                    source_effects = {
                        {
                            type = "script",
                            effect_id = "swarm-micromissile-fired"
                        }
                    }
                }
            }
        }
    else

        pack.ammo_type.action.action_delivery.direction_deviation = pack.ammo_type.action.action_delivery
            .direction_deviation * 3
        pack.ammo_type.action.action_delivery.range_deviation = pack.ammo_type.action.action_delivery.range_deviation *
            2

    end

    pack.inventory_move_sound = item_sounds.ammo_large_inventory_move
    pack.pick_sound = item_sounds.ammo_large_inventory_move
    pack.drop_sound = item_sounds.ammo_large_inventory_move
    pack.stack_size = missile.stack_size / 10
    pack.weight = missile.weight * 20
    return {pack, proj}
end

function make_swarm_pack_recipe(missile)
    local recipe = {
        type = "recipe",
        name = missile.name .. "-swarm-pack",
        category = (mods["Age-of-Production"] and "ammunition-or-crafting" or "crafting"),
        subgroup = "ammo",
        allow_productivity = false,
        enabled = false,
        energy_required = 1,
        ingredients =
        {
            { type = "item", name = missile.name, amount = 20 }
        },
        results = { { type = "item", name = missile.name .. "-swarm-pack", amount = 1 } }
    }
    return recipe
end

--packs
data.extend({
    make_pack(mm_i),
    make_pack(mmh_i),
    make_pack(mme_i),
    make_pack(mmk_i),
    make_pack(mmi_i),
    make_pack_recipe(mm_i),
    make_pack_recipe(mmh_i),
    make_pack_recipe(mme_i),
    make_pack_recipe(mmk_i),
    make_pack_recipe(mmi_i)
})
    data:extend(make_swarm_pack(mm_i, mm))
    data:extend(make_swarm_pack(mmh_i, mmh))
    data:extend(make_swarm_pack(mme_i, mme))
    data:extend(make_swarm_pack(mmk_i, mmk, true))
    data:extend(make_swarm_pack(mmi_i, mmi))
    data:extend({
    make_swarm_pack_recipe(mm_i),
    make_swarm_pack_recipe(mmh_i),
    make_swarm_pack_recipe(mme_i),
    make_swarm_pack_recipe(mmk_i),
    make_swarm_pack_recipe(mmi_i)
})
if mods["space-age"] then
    data.extend({
    make_pack(mma_i),
    make_pack_recipe(mma_i),
    make_swarm_pack_recipe(mma_i)
})
data.extend(make_swarm_pack(mma_i, mma))
end


table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "micromissile-pack"
})
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "micromissile-homing-pack"
})
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "micromissile-explosive-pack"
})
table.insert(tech.effects, {
    type = "unlock-recipe",
    recipe = "micromissile-kinetic-pack"
})
    table.insert(tech.effects, {
        type = "unlock-recipe",
        recipe = "micromissile-incendiary-pack"
    })
if mods["space-age"] then
    table.insert(tech.effects, {
        type = "unlock-recipe",
        recipe = "micromissile-arc-pack"
    })
end

table.insert(tech_2.effects, {
    type = "unlock-recipe",
    recipe = "micromissile-swarm-pack"
})
table.insert(tech_2.effects, {
    type = "unlock-recipe",
    recipe = "micromissile-homing-swarm-pack"
})
table.insert(tech_2.effects, {
    type = "unlock-recipe",
    recipe = "micromissile-explosive-swarm-pack"
})
table.insert(tech_2.effects, {
    type = "unlock-recipe",
    recipe = "micromissile-kinetic-swarm-pack"
})
table.insert(tech_2.effects, {
    type = "unlock-recipe",
    recipe = "micromissile-incendiary-swarm-pack"
})
if mods["space-age"] then
    table.insert(tech_2.effects, {
        type = "unlock-recipe",
        recipe = "micromissile-arc-swarm-pack"
    })
end

---@diagnostic disable-next-line: assign-type-mismatch
data:extend({tech_2})
    














--q-homing section

-- only works on single missiles, not packs
function make_q_homing(item, projectile, special)
    local q = table.deepcopy(item)
    q.name = item.name .. "-q"
    q.icon = string.gsub(item.icon, ".png", "-q.png")
    q.order = item.order .. "-q"
    q.ammo_type.target_type = "entity"
    q.ammo_type.action.action_delivery.projectile = q.ammo_type.action.action_delivery.projectile .. "-q"

    local p = table.deepcopy(projectile)
    p.name = projectile.name .. "-q"
    p.direction_only = false
    p.collision_box = {{0, 0}, {0, 0} }
    if special then
        p.action = {
            type = "area",
            trigger_from_target = true,
            radius = 0,
            action_delivery = item.ammo_type.action.action_delivery
            --[[action_delivery =
            {
                type = "projectile",
                projectile = projectile.name,
                starting_speed = item.starting_speed,
                starting_speed_deviation = projectile.starting_speed_deviation,
                direction_deviation = projectile.direction_deviation,
                range_deviation = projectile.range_deviation,
                max_range = projectile.max_range,
            }--]]
    }
    end
    return {q, p}
end

function make_q_recipe(missile)
    local recipe = {
        type = "recipe",
        name = missile.name .. "-q",
        category = "cryogenics",
        subgroup = "ammo",
        allow_productivity = false,
        enabled = false,
        energy_required = 1,
        ingredients =
        {
            { type = "item", name = missile.name, amount = 1 },
            { type = "item", name = "quantum-processor", amount = 1 },
            { type = "fluid", name = "fluoroketone-cold", amount = 10 }
        },
        results = { { type = "item", name = missile.name .. "-q", amount = 1 } }
    }
    return recipe
end

--q-homing
if (settings.startup["enable-q-homing"].value and mods["space-age"]) then 
    local mme_q = make_q_homing(mme_i, mme)
    local mmk_q = make_q_homing(mmk_i, mmk)
    local mma_q = make_q_homing(mma_i, mma)
    data:extend(mme_q)
    data:extend(mmk_q)
    data:extend(mma_q)

    data:extend({
        make_q_recipe(mme_i),
        make_q_recipe(mmk_i),
        make_q_recipe(mma_i)
    })

    data:extend({
        make_pack(mme_q[1]),
        make_pack(mmk_q[1]),
        make_pack(mma_q[1]),
        make_pack_recipe(mme_q[1]),
        make_pack_recipe(mmk_q[1]),
        make_pack_recipe(mma_q[1]),
        make_swarm_pack_recipe(mme_q[1]),
        make_swarm_pack_recipe(mmk_q[1]),
        make_swarm_pack_recipe(mma_q[1])
    })

    data:extend(make_swarm_pack(mme_q[1], mme_q[2]))
    data:extend(make_swarm_pack(mmk_q[1], mmk_q[2]))
    data:extend(make_swarm_pack(mma_q[1], mma_q[2]))


    local mmi_q = make_q_homing(mmi_i, mmi)
    data:extend(mmi_q)

    data:extend({
        make_q_recipe(mmi_i),
        make_pack(mmi_q[1]),
        make_pack_recipe(mmi_q[1]),
        make_swarm_pack_recipe(mmi_q[1])
    })

    data:extend( make_swarm_pack(mmi_q[1], mmi_q[2]) )


--technology
    local q_rocketry = 
    {
        type = "technology",
        name = "q-rocketry",
        icon_size = 256,
        icon = "__lilys-mm__/graphics/technology/q-rocketry.png",
        prerequisites = { "mass-rocketry-2", "quantum-processor", "cryogenic-science-pack"},
        unit =
        {
            ingredients =
            {
                { "automation-science-pack",   1 },
                { "logistic-science-pack",     1 },
                { "military-science-pack",     1 },
                { "chemical-science-pack",     1 },
                { "space-science-pack",        1 },
                { "utility-science-pack",      1 },
                { "agricultural-science-pack", 1 },
                { "cryogenic-science-pack",    1 }
            },
            time = 60,
            count = 5000
        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "micromissile-explosive-q"
            },
            {
                type = "unlock-recipe",
                recipe = "micromissile-kinetic-q"
            },
            {
                type = "unlock-recipe",
                recipe = "micromissile-arc-q"
            },
            {
                type = "unlock-recipe",
                recipe = "micromissile-explosive-q-pack"
            },
            {
                type = "unlock-recipe",
                recipe = "micromissile-kinetic-q-pack"
            },
            {
                type = "unlock-recipe",
                recipe = "micromissile-arc-q-pack"
            },
            {
                type = "unlock-recipe",
                recipe = "micromissile-explosive-q-swarm-pack"
            },
            {
                type = "unlock-recipe",
                recipe = "micromissile-kinetic-q-swarm-pack"
            },
            {
                type = "unlock-recipe",
                recipe = "micromissile-arc-q-swarm-pack"
            }
        }
    }

    
    table.insert(q_rocketry.effects, {
        type = "unlock-recipe",
        recipe = "micromissile-incendiary-q"
    })
    table.insert(q_rocketry.effects, {
        type = "unlock-recipe",
        recipe = "micromissile-incendiary-q-pack"
    })
    table.insert(q_rocketry.effects, {
        type = "unlock-recipe",
        recipe = "micromissile-incendiary-q-swarm-pack"
    })
    

    data.extend({q_rocketry})

end


