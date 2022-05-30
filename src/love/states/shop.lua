return {
    enter = function()
        shop = {
            "Mini Clothing Hangers",
            "Plastic Clothing Hangers",
            "Clicker Power"
        }
        shopPrice = {
            10,
            25,
            50
        }
        print("in the shop")
        buttonSelection = 1
    end,

    update = function(dt)
        if input:pressed("gameClick") then
            if mouseX >= 100 and mouseX <= 150 and mouseY >= 140 and mouseY <= 190 then
                shopFunc:MiniHangerBuy()
            end
            if mouseX >= 200 and mouseX <= 250 and mouseY >= 140 and mouseY <= 190 then
                shopFunc:PlasticHangerBuy()
            end
            if mouseX >= 300 and mouseX <= 350 and mouseY >= 140 and mouseY <= 190 then
                shopFunc:ClickPowerBuy()
            end
            if input:getActiveDevice() == "joy" then
                if buttonSelection == 1 then
                    shopFunc:MiniHangerBuy()
                end
                if buttonSelection == 2 then
                    shopFunc:PlasticHangerBuy()
                end
                if buttonSelection == 3 then
                    shopFunc:ClickPowerBuy()
                end
            end
        elseif input:pressed("gameRight") then
            if buttonSelection ~= #shop then
                buttonSelection = buttonSelection + 1
            end
        elseif input:pressed("gameLeft") then
            if buttonSelection ~= 1 then
                buttonSelection = buttonSelection - 1
            end
        elseif input:pressed("shopButton") then
            Gamestate.switch(clickerMenu)
        end
    end,

    draw = function()
        if input:getActiveDevice() == "joy" then
            if buttonSelection == 1 then 
                love.graphics.rectangle("line", 95, 135, 60,60)
            elseif buttonSelection == 2 then
                love.graphics.rectangle("line", 195, 135, 60,60)
            elseif buttonSelection == 3 then
                love.graphics.rectangle("line", 295, 135, 60,60)
            end
        end

        for i = 1, #shop do
            love.graphics.rectangle("fill", 100*i, 140, 50,50)
            moment = 100 * i
            love.graphics.print(i, 23 + moment,195)
        end

        if miniHangerOwn >= 1 then
            love.graphics.print("\n\n"..shop[1]..": " .. shopPrice[1] * (miniHangerOwn * 1.1)) -- I hate math
        else
            love.graphics.print("\n\n"..shop[1]..": " .. shopPrice[1])
        end
        
        if clickerPowerOwn >= 1 then
            love.graphics.print("\n\n\n"..shop[2]..": " .. shopPrice[2] * (clickerPowerOwn * 1.1)) 
        else
            love.graphics.print("\n\n\n"..shop[2]..": " .. shopPrice[2]) 
        end
    end
}
