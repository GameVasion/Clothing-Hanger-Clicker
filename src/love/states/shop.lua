return {
    enter = function()
        shop = {
            "Mini Clothing Hangers",
            "Clicker Power"
        }
        shopPrice = {
            10,
            50
        }
        print("in the shop")
        buttonSelection = 1

        function shop1buy()
            if shop1Owned >= 1 then
                if clicks >= shopPrice[1] * (shop1Owned * 1.1) then
                    price = shopPrice[1] * (shop1Owned * 1.1)
                    shop1Owned = shop1Owned + 1
                    clicks = clicks - price
                    CHPS = CHPS + 1
                end
            else
                if clicks >= shopPrice[1] then
                    shop1Owned = shop1Owned + 1
                    clicks = clicks - shopPrice[1]
                    CHPS = CHPS + 1
                end
            end
        end
        function shop2buy()
            if shop2Owned >= 1 then
                if clicks >= shopPrice[2] * (shop2Owned * 1.1) then
                    price = shopPrice[2] * (shop2Owned * 1.1)
                    shop2Owned = shop2Owned + 1
                    clicks = clicks - price
                    clickUpgrade = clickUpgrade + 1
                end
            else
                if clicks >= shopPrice[2] then
                    shop2Owned = shop2Owned + 1
                    clicks = clicks - shopPrice[2]
                    clickUpgrade = clickUpgrade + 1
                end
            end
        end
    end,

    update = function(dt)
        if input:pressed("gameClick") then
            if mouseX >= 100 and mouseX <= 150 and mouseY >= 140 and mouseY <= 190 then
                shop1buy()
            end
            if mouseX >= 200 and mouseX <= 250 and mouseY >= 140 and mouseY <= 190 then
                shop2buy()
            end
            if input:getActiveDevice() == "joy" then
                if buttonSelection == 1 then
                    shop1buy()
                end
                if buttonSelection == 2 then
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
                love.graphics.rectangle("line", 95, 135, 60,60)
            elseif buttonSelection == 2 then
                love.graphics.rectangle("line", 195, 135, 60,60)
            end
        end

        for i = 1, #shop do
            love.graphics.rectangle("fill", 100*i, 140, 50,50)
            moment = 100 * i
            love.graphics.print(i, 23 + moment,195)
        end

        if shop1Owned >= 1 then
            love.graphics.print("\n\n"..shop[1]..": " .. shopPrice[1] * (shop1Owned * 1.1)) -- I hate math
        else
            love.graphics.print("\n\n"..shop[1]..": " .. shopPrice[1])
        end
        
        if shop2Owned >= 1 then
            love.graphics.print("\n\n\n"..shop[2]..": " .. shopPrice[2] * (shop2Owned * 1.1)) 
        else
            love.graphics.print("\n\n\n"..shop[2]..": " .. shopPrice[2]) 
        end
    end
}
