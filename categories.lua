if not data.raw["recipe-category"]["ammunition-or-electromagnetics"] then
    data:extend({
        {
            type = "recipe-category",
            name = "ammunition-or-electromagnetics"
        }
    })
    if mods["Castra"] then
        data:extend({
            {
                type = "recipe-category",
                name = "castra-ammunition-or-electromagnetics"
            }
        })
    end
end

local assembling_machines = data.raw["assembling-machine"]

for name, am in pairs(assembling_machines) do
    local categories = {}
    for _, category in ipairs(am.crafting_categories) do
        categories[category] = true
    end

    if categories["ammunition"] then
        table.insert(am.crafting_categories, "ammunition-or-electromagnetics")
        if mods["Castra"] then
            table.insert(am.crafting_categories, "castra-ammunition-or-electromagnetics")
        end
    end

    if categories["electromagnetics"] then
        table.insert(am.crafting_categories, "ammunition-or-electromagnetics")
    end

    if mods["Castra"] then
        table.insert(am.crafting_categories, "castra-ammunition-or-electromagnetics")
    end
end


if not data.raw["recipe-category"]["ammunition-or-chemistry-or-cryogenics"] then
    data:extend({
        {
            type = "recipe-category",
            name = "ammunition-or-chemistry-or-cryogenics"
        }
    })
end

for name, am in pairs(assembling_machines) do
    local categories = {}
    for _, category in ipairs(am.crafting_categories) do
        categories[category] = true
    end

    if categories["ammunition"] then
        table.insert(am.crafting_categories, "ammunition-or-chemistry-or-cryogenics")
        if mods["Castra"] then
            table.insert(am.crafting_categories, "castra-ammunition-or-chemistry-or-cryogenics")
        end
    end



    if categories["chemistry"] then
        table.insert(am.crafting_categories, "ammunition-or-chemistry-or-cryogenics")
        if mods["Castra"] then
            table.insert(am.crafting_categories, "castra-ammunition-or-chemistry-or-cryogenics")
        end
    end

    if categories["cryogenics"] then
        table.insert(am.crafting_categories, "ammunition-or-chemistry-or-cryogenics")

        if mods["Castra"] then
            table.insert(am.crafting_categories, "castra-ammunition-or-chemistry-or-cryogenics")
        end
    end
end


