return { -- horrible menu lol (Ima work on it later ig)
    enter = function()
        textPos = {}
        textPos[1] = love.graphics.getWidth() / 2 - 25
        textPos[2] = 1000
        Timer.tween(0.5, textPos, {[2] = love.graphics.getHeight() / 2 - 25}, "out-elastic")
    end,

    update = function(dt)
        if input:pressed("confirm") then
            Gamestate.switch(clickerMenu)
        end
    end,

    draw = function()
        -- print "Press Enter" in the middle of the screen
        love.graphics.print("Press Enter", textPos[1], textPos[2])
    end
}
