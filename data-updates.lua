require("categories")
if settings.startup["cheap-mode"].value then
    local recipes = data.raw["recipe"]
    for name, recipe in pairs(recipes) do
        if (string.find(name, "micromissile-") and (string.find(name, "-pack") == nil)) then
            local increased = false


            for _, ingr in ipairs(recipe.ingredients) do
                if string.find(ingr.name, "micromissile") then
                    ingr.amount = ingr.amount * 10
                    increased = true
                end
            end

            if increased then
                for _, res in ipairs(recipe.results) do
                    if string.find(res.name, "micromissile") then
                        res.amount = res.amount * 10
                    end
                end

                recipe.energy_required = recipe.energy_required * 10
            end

        end
    end
end