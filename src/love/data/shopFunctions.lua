return { -- This file is where all the shop functions are stored.
    enter = function() -- I am so sorry modders (not like anyone is going to mod anyways lmfao)
        shopPriceOG = {
            10, -- mini hanger
            25, -- plastic hanger
            50, -- copper hanger
            50 -- clicker power
        }
        shop = {
            {"Mini Clothing Hangers", shopPriceOG[1]},
            {"Plastic Clothing Hangers", shopPriceOG[2]},
            {"Copper Clothing Hangers", shopPriceOG[3]},
            {"Clicker Power", shopPriceOG[#shopPriceOG]} -- a table in a table!?!? wtf?!?!?!
        }
        print("in the shop")
        buttonSelection = 1
    end,
    update = function(dt)
        if miniHangerOwn ~= 1 then
            shop[1][2] = shopPriceOG[1]
        else
            shop[1][2] = math.floor(shopPriceOG[1] * (miniHangerOwn * 1.1))
        end
        if plasticHangerOwn ~= 1 then
            shop[2][2] = shopPriceOG[2]
        else
            shop[2][2] = math.floor(shopPriceOG[2] * (plasticHangerOwn * 1.1))
        end
        if copperHangerOwn ~= 1 then
            shop[3][2] = shopPriceOG[3]
        else
            shop[3][2] = math.floor(shopPriceOG[3] * (copperHangerOwn * 1.1))
        end
        if clickerPowerOwn ~= 1 then
            shop[4][2] = shopPriceOG[4]
        else
            shop[4][2] = math.floor(shopPriceOG[4] * (clickerPowerOwn * 1.1))
        end
        if input:pressed("gameClick") then
            if mouseX >= 100 and mouseX <= 150 and mouseY >= 140 and mouseY <= 190 then
                shopFunc:MiniHangerBuy()
            elseif mouseX >= 200 and mouseX <= 250 and mouseY >= 140 and mouseY <= 190 then
                shopFunc:PlasticHangerBuy()
            elseif mouseX >= 300 and mouseX <= 350 and mouseY >= 140 and mouseY <= 190 then
                shopFunc:CopperHangerBuy()
            elseif mouseX >= 400 and mouseX <= 450 and mouseY >= 140 and mouseY <= 190 then
                shopFunc:ClickPowerBuy()
            end
            if input:getActiveDevice() == "joy" then
                if buttonSelection == 1 then
                    shopFunc:MiniHangerBuy()
                elseif buttonSelection == 2 then
                    shopFunc:PlasticHangerBuy()
                elseif buttonSelection == 3 then
                    shopFunc:CopperHangerBuy()
                elseif buttonSelection == 4 then
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
            if clicks >= shop[1][2] then
                price = shop[1][2]
                miniHangerOwn = miniHangerOwn + 1
                clicks = clicks - price
                CHPS = CHPS + 1
            end
        else
            if clicks >= shopPriceOG[1] then
                miniHangerOwn = miniHangerOwn + 1
                clicks = clicks - shopPriceOG[1]
                CHPS = CHPS + 1
            end
        end
    end,
    PlasticHangerBuy = function()
        if plasticHangerOwn >= 1 then
            if clicks >= shop[2][2] then
                price = shop[2][2]
                plasticHangerOwn = plasticHangerOwn + 1
                clicks = clicks - price
                CHPS = CHPS + 2
            end
        else
            if clicks >= shopPriceOG[2] then
                plasticHangerOwn = plasticHangerOwn + 1
                clicks = clicks - shopPriceOG[2]
                CHPS = CHPS + 2
            end
        end
    end,
    CopperHangerBuy = function()
        if copperHangerOwn >= 1 then
            if clicks >= shop[3][2] then
                price = shop[3][2]
                copperHangerOwn = copperHangerOwn + 1
                clicks = clicks - price
                CHPS = CHPS + 5
            end
        else
            if clicks >= shopPriceOG[3][2] then
                copperHangerOwn = copperHangerOwn + 1
                clicks = clicks - shopPriceOG[3]
                CHPS = CHPS + 5
            end
        end
    end,
    ClickPowerBuy = function()
        if clickerPowerOwn >= 1 then
            if clicks >= shop[4][2] then
                price = shop[4][2]
                clickerPowerOwn = clickerPowerOwn + 1
                clicks = clicks - price
                clickUpgrade = clickUpgrade + 1
            end
        else
            if clicks >= shopPriceOG[2] then
                clickerPowerOwn = clickerPowerOwn + 1
                clicks = clicks - shopPriceOG[2]
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
        for i = 1, #shop do
            love.graphics.print(shop[i][1]..": "..shop[i][2], 0, 300+(20*i))
        end
    end
}