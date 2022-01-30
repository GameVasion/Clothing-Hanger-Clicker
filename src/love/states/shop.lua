return {
    enter = function()
        print("in the shop")
        buttonSelection = 1

        function shop1buy()
            if shop1Owned >= 1 then
                if clicks >= shop1Price * (shop1Owned * 1.1) then
                    price = shop1Price * (shop1Owned * 1.1)
                    shop1Owned = shop1Owned + 1
                    clicks = clicks - price
                    CHPS = CHPS + 1
                end
            else
                if clicks >= shop1Price then
                    shop1Owned = shop1Owned + 1
                    clicks = clicks - shop1Price
                    CHPS = CHPS + 1
                end
            end
        end
        function shop2buy()
            if shop2Owned >= 1 then
                if clicks >= shop2Price * (shop2Owned * 1.1) then
                    price = shop2Price * (shop2Owned * 1.1)
                    shop2Owned = shop2Owned + 1
                    clicks = clicks - price
                    clickUpgrade = clickUpgrade + 1
                end
            else
                if clicks >= shop2Price then
                    shop2Owned = shop2Owned + 1
                    clicks = clicks - shop2Price
                    clickUpgrade = clickUpgrade + 1
                end
            end
        end
    end,

    update = function(dt)
        if input:pressed("gameClick") then
            if input:getActiveDevice() ~= "joy" then
                if mouseX >= 300 and mouseX <= 350 and mouseY >= 140 and mouseY <= 190 then
                    shop1buy()
                elseif mouseX >= 400 and mouseX <= 450 and mouseY >= 140 and mouseY <= 190 then
                    shop2buy()
                end
            else
                if buttonSelection == 1 then
                    shop1buy()
                elseif buttonSelection == 2 then
                    shop2buy()
                end
            end
        elseif input:pressed("gameRight") then
            if buttonSelection ~= 2 then
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
                love.graphics.rectangle("line", 295, 135, 60,60)
            elseif buttonSelection == 2 then
                love.graphics.rectangle("line", 395, 135, 60,60)
            end
        end

        love.graphics.rectangle("fill", 300, 140, 50,50)
        love.graphics.rectangle("fill", 400, 140, 50,50)

        if shop1Owned >= 1 then
            love.graphics.print("\nShop1 price: " .. shop1Price * (shop1Owned * 1.1)) -- I hate math
        else
            love.graphics.print("\nShop1 price: " .. shop1Price)
        end
        
        if shop2Owned >= 1 then
            love.graphics.print("\n\nShop2 price (Clicker power): " .. shop2Price * (shop2Owned * 1.1)) 
        else
            love.graphics.print("\n\nShop2 price (Clicker power): " .. shop2Price) 
        end
    end
}