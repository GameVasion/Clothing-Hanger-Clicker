local shop = {}
local hangerButtons = {}
local clickerButtons = {}

function shop:enter()
    hangerButtons = {}
    clickerButtons = {}

    -- for all in hangers, add a button to hangerButtons
    for i, v in pairs(hangers) do
        table.insert(hangerButtons, graphics.shopButton(10, 115, 250, 100, v.name .. '\n$' .. math.floor(v.data.price) .. '\nCHPS: ' .. v.data.CHPS, v.data, v.name))
    end

    -- sort the hangerButtons table by price
    table.sort(hangerButtons, function(a, b) return a.data.ogPrice < b.data.ogPrice end)

    -- organize hangarButtons into a grid
    pages = {{}}
    local x = 10
    local y = 115
    for i, v in ipairs(hangerButtons) do
        -- there can be 4 rows of buttons per page
        if i % 3 == 0 then
            table.insert(pages, {})
        end
        v.x = x
        v.y = y
        x = x + v.width + 10
        if x + v.width > love.graphics.getWidth() then
            x = 10
            y = y + v.height + 10
        end

        table.insert(pages[#pages], v)
    end

    -- for all in clickers, add a button to clickerButtons
    for i, v in pairs(clickers) do
        --table.insert(clickerButtons, graphics.newButton(10, 10, 100, 100, v.name .. '\n$' .. v.data.price .. '\nCHPS: ' .. v.data.CHPS))
    end

    backButton = graphics.newButton(push.getWidth() - 110, push.getHeight() - 110, 100, 100, "Back")
end

function shop:update(dt)
    -- check for isClicked on all buttons
    for i, v in ipairs(hangerButtons) do
        if v:isClicked() then
            if clicks >= v.data.price then
                clicks = clicks - v.data.price
                v.data.price = v.data.price * 1.1
                CHPS = CHPS + v.data.CHPS
                boughtHangers[v.name] = boughtHangers[v.name] + 1

                -- update the button text
                v.text.string = v.name .. '\n$' .. math.floor(v.data.price) .. '\nCHPS: ' .. v.data.CHPS
            end
        end
    end

    if backButton:isClicked() then
        state.switch(states.play)
    end
end

function shop:draw()
    for i, v in ipairs(hangerButtons) do
        v:draw()
    end

    for i, v in ipairs(clickerButtons) do
        v:draw()
    end

    backButton:draw()
end

function shop:mousepressed(x, y, button, istouch, presses)

end

function shop:mousereleased(x, y, button, istouch, presses)

end

return shop