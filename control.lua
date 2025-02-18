
script.on_event(defines.events.on_script_trigger_effect, function(event)

    if event.effect_id == "swarm-micromissile-fired" then
        --game.print("Fire!")

        local source = event.source_entity
        if source then
            local missiles = source.surface.find_entities_filtered{
                position = event.source_position,
                radius = 0.1,
                type = "projectile"
            }
            --game.print("Missiles: " .. table_size(missiles))
            for _, missile in ipairs(missiles) do
                if string.find(missile.name, "micromissile") and string.find(missile.name, "swarm") then
                    local d = missile.orientation
                    d = d + math.random() / 2 - 0.25
                    if d > 1.0 then
                        d = d - 1.0
                    end
                    if d < 0 then
                        d = d + 1.0
                    end
                    missile.orientation = d
                end
            end
        end

    end


end
)