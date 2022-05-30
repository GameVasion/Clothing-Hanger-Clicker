return { -- This file is where all the shop functions are stored.
    enter = function()
        shop = {
            "Mini Clothing Hangers",
            "Plastic Clothing Hangers",
            "Copper Clothing Hangers",
            "Clicker Power"
        }
        shopPrice = {
            10, -- mini hanger
            25, -- plastic hanger
            50, -- copper hanger
            50 -- clicker power
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
                shopFunc:CopperHangerBuy()
            end
            if mouseX >= 400 and mouseX <= 450 and mouseY >= 140 and mouseY <= 190 then
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
                    shopFunc:CopperHangerBuy()
                end
                if buttonSelection == 4 then
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
        end
    end,
    MiniHangerBuy = function()
        if miniHangerOwn >= 1 then
            if clicks >= math.floor(shopPrice[1] * (miniHangerOwn * 1.1)) then
                price = math.floor(shopPrice[1] * (miniHangerOwn * 1.1))
                miniHangerOwn = miniHangerOwn + 1
                clicks = clicks - price
                CHPS = CHPS + 1
            end
        else
            if clicks >= shopPrice[1] then
                miniHangerOwn = miniHangerOwn + 1
                clicks = clicks - shopPrice[1]
                CHPS = CHPS + 1
            end
        end
    end,
    PlasticHangerBuy = function()
        if plasticHangerOwn >= 1 then
            if clicks >= math.floor(shopPrice[3] * (plasticHangerOwn * 1.1)) then
                price = math.floor(shopPrice[3] * (plasticHangerOwn * 1.1)) -- eww decimals
                plasticHangerOwn = plasticHangerOwn + 1
                clicks = clicks - price
                CHPS = CHPS + 2
            end
        else
            if clicks >= shopPrice[3] then
                plasticHangerOwn = plasticHangerOwn + 1
                clicks = clicks - shopPrice[3]
                CHPS = CHPS + 2
            end
        end
    end,
    CopperHangerBuy = function()
        if copperHangerOwn >= 1 then
            if clicks >= math.floor(shopPrice[2] * (copperHangerOwn * 1.1)) then
                price = math.floor(shopPrice[2] * (copperHangerOwn * 1.1))
                copperHangerOwn = copperHangerOwn + 1
                clicks = clicks - price
                CHPS = CHPS + 5
            end
        else
            if clicks >= shopPrice[2] then
                copperHangerOwn = copperHangerOwn + 1
                clicks = clicks - shopPrice[2]
                CHPS = CHPS + 5
            end
        end
    end,
    ClickPowerBuy = function()
        if clickerPowerOwn >= 1 then
            if clicks >= math.floor(shopPrice[2] * (clickerPowerOwn * 1.1)) then
                price = math.floor(shopPrice[2] * (clickerPowerOwn * 1.1))
                clickerPowerOwn = clickerPowerOwn + 1
                clicks = clicks - price
                clickUpgrade = clickUpgrade + 1
            end
        else
            if clicks >= shopPrice[2] then
                clickerPowerOwn = clickerPowerOwn + 1
                clicks = clicks - shopPrice[2]
                clickUpgrade = clickUpgrade + 1
            end
        end
    end,
    drawUI = function()
        if input:getActiveDevice() == "joy" then
            for i = 0, #shop-1 do -- will need to test this
                love.graphics.rectangle("line", 95, 35 + (100 * i), 60,60)
            end
        end

        for i = 1, #shop do
            love.graphics.rectangle("fill", 100*i, 140, 50,50)
            love.graphics.print(i, 23 + 100*i,195)
        end

        love.graphics.print("| Shop (In order) |", 0, 280)
        if miniHangerOwn >= 1 then
            love.graphics.print(shop[1]..": " .. shopPrice[1] * (miniHangerOwn * 1.1), 0, 300) -- I hate math
        else
            love.graphics.print(shop[1]..": " .. shopPrice[1], 0, 300)
        end

        if plasticHangerOwn >= 1 then
            love.graphics.print("\n"..shop[2]..": " .. shopPrice[2] * (plasticHangerOwn * 1.1), 0, 300)
        else
            love.graphics.print("\n"..shop[2]..": " .. shopPrice[2], 0, 300)
        end

        if copperHangerOwn >= 1 then
            love.graphics.print("\n\n"..shop[3]..": " .. shopPrice[3] * (copperHangerOwn * 1.1), 0, 300)
        else
            love.graphics.print("\n\n"..shop[3]..": " .. shopPrice[3], 0, 300)
        end
        
        if clickerPowerOwn >= 1 then
            love.graphics.print("\n\n\n"..shop[#shop]..": " .. shopPrice[#shop] * (clickerPowerOwn * 1.1), 0, 300) 
        else
            love.graphics.print("\n\n\n"..shop[#shop]..": " .. shopPrice[#shop], 0, 300) 
        end
    end
}