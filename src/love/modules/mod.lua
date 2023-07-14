-- TODO: custom shop item support.

local mod = {}

function mod.loadCustomHangers()
    if love.filesystem.getInfo("mod/hangers/") then
        for _, file in ipairs(love.filesystem.getDirectoryItems("mod/hangers/")) do
            local data = json.decode(love.filesystem.read("mod/hangers/" .. file))
            data.data.ogPrice = data.data.price
            hangers[data.name] = data     
        end

        -- for all in hangers, add a variable to boughtHangers
        for k, v in pairs(hangers) do
            if not boughtHangers[v.name] then
                boughtHangers[v.name] = 0
            end
        end

        -- sort the hangers table by price
        table.sort(hangers, function(a, b) return a.data.price < b.data.price end)
    else
        -- create mod/ and mod/hangers/
        love.filesystem.createDirectory("mod")
        love.filesystem.createDirectory("mod/hangers")
    end
end

return mod