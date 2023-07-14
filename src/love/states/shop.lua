local shop = {}
local hangerButtons = {}
local pageButton

function shop:enter()
    hangerButtons = {}

    -- for all in hangers, add a button to hangerButtons
    for i, v in pairs(hangers) do
        table.insert(hangerButtons, graphics.shopButton(10, 115, 250, 100, v.name .. '\n$' .. math.floor(v.data.price) .. '\nCHPS: ' .. v.data.CHPS, v.data, v.name))
    end

    -- sort the hangerButtons table by price
    table.sort(hangerButtons, function(a, b) return a.data.ogPrice < b.data.ogPrice end)

    -- organize hangarButtons into a grid
    curPage = 1
    pages = {{}}
    local x = 10
    local y = 115
    local currPage = 1
    local lastPage = 1
    for i, v in ipairs(hangerButtons) do
        -- there can be 4 rows of buttons per page
        if i % 10 == 0 then
            table.insert(pages, {})
            currPage = currPage + 1
        end
        v.x = x
        v.y = y
        x = x + v.width + 10
        if x + v.width > love.graphics.getWidth() then
            x = 10
            y = y + v.height + 10
        end

        -- change y if page is not 1
        -- set y back to 0 if its a new page
        if currPage ~= lastPage then
            y = 115
            v.y = y
        end
        print(currPage, lastPage)

        table.insert(pages[#pages], v)

        lastPage = currPage
    end

    if #pages > 1 then
        -- add a next button
        pageButton = graphics.newButton(push.getWidth() - 110, push.getHeight() - 110, 100, 100, "->")
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

    if pageButton and pageButton:isClicked() then
        curPage = curPage + 1
        if curPage > #pages then
            curPage = 1
        end
    end
end

function shop:draw()
    for i, v in ipairs(pages[curPage]) do
        v:draw()
    end

    if pageButton then
        backButton.x = 10
        backButton.y = push.getHeight() - 110
    end
    backButton:draw()

    if pageButton then
        pageButton:draw()
    end
end

function shop:mousepressed(x, y, button, istouch, presses)

end

function shop:mousereleased(x, y, button, istouch, presses)

end

return shop