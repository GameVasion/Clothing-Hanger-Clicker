local play = {}

function play:AABB(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and
           x2 < x1 + w1 and
           y1 < y2 + h2 and
           y2 < y1 + h1
end

function play:enter()
    shopButton = graphics.newButton(10,10,100,100,"Shop")
end

function play:update(dt)
    if shopButton:isClicked() then
        state.switch(states.shop)
    end
end

function play:draw()
    clothinghanger:draw()

    shopButton:draw()

    love.graphics.printf("Clicks: " .. math.floor(clicks), 0, 0, love.graphics.getWidth(), "right")
end

function play:mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        if self:AABB(
            x, y, 1, 1,
            love.graphics.getWidth() / 2 - clothinghanger:getWidth() / 2,
            love.graphics.getHeight() / 2 - clothinghanger:getHeight() / 2,
            clothinghanger:getWidth(),
            clothinghanger:getHeight()
        ) then
            clicks = clicks + 1
        end
    end
end

function play:mousereleased(x, y, button, istouch, presses)

end

return play