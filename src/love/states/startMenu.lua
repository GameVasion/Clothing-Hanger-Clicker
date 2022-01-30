return { -- horrible menu lol
    load = function()

    end,

    update = function(dt)
        if input:pressed("confirm") then
            Gamestate.switch(clickerMenu)
        end
    end,

    draw = function()
        love.graphics.printf("Please Press Enter", 320, 360, 200, "center", 0, 3, 3)
    end
}