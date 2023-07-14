return { -- This file is where all the shop functions are stored.
    enter = function() -- I am so sorry modders (not like anyone is going to mod anyways lmfao)
        shop = {
            -- Name : Price : CHPS count/clicker count : Is Clicker Upgrade
            {"Mini Clothing Hangers", 10, 1, false},
            {"Plastic Clothing Hangers", 25, 2, false},
            {"Copper Clothing Hangers", 50, 5, false},
            {"Steel Clothing Hangers", 100, 10, false},
            {"Iron Clothing Hangers", 250, 20, false},
            {"Gold Clothing Hangers", 450, 50, false},
            {"Clicker Power", 50, 1, true} 
        }
        OGShopPrice = {
            10, -- Mini Hanger
            25, -- Plastic Hanger
            50, -- Copper Hanger
            100, -- Steel Hanger
            250, -- Iron Hanger
            450, -- Gold Hanger
            50 -- Clicker Power
        }
        print("in the shop")
        buttonSelection = 1
    end,
    update = function(dt)
        for i = 1, #shop do
            if __OWNED[i] ~= 0 then
                shop[i][2] = math.floor(OGShopPrice[i] * __OWNED[i] * 1.12)
            end
        end
        if input:pressed("gameClick") then
            if input:getActiveDevice() ~= "joy" then
                if mouseX >= 100 and mouseX <= 150 and mouseY >= 140 and mouseY <= 190 then
                    buttonSelection = 1
                elseif mouseX >= 200 and mouseX <= 250 and mouseY >= 140 and mouseY <= 190 then
                    buttonSelection = 2
                elseif mouseX >= 300 and mouseX <= 350 and mouseY >= 140 and mouseY <= 190 then
                    buttonSelection = 3
                elseif mouseX >= 400 and mouseX <= 450 and mouseY >= 140 and mouseY <= 190 then
                    buttonSelection = 4
                elseif mouseX >= 500 and mouseX <= 550 and mouseY >= 140 and mouseY <= 190 then
                    buttonSelection = 5
                elseif mouseX >= 100 and mouseX <= 150 and mouseY >= 230 and mouseY <= 280 then
                    buttonSelection = 6
                elseif mouseX >= 200 and mouseX <= 250 and mouseY >= 230 and mouseY <= 280 then -- Clicker Power will ALWAYS be last. 
                    buttonSelection = #__OWNED
                else
                    buttonSelection = 0
                end
            end
            if buttonSelection ~= 0 then
                if sounds.shopBuy[#sounds.shopBuy]:isPlaying() then
                    sounds.shopBuy[#sounds.shopBuy] = sounds.shopBuy[#sounds.shopBuy]:clone()
                    sounds.shopBuy[#sounds.shopBuy]:play()
                else
                    sounds.shopBuy[#sounds.shopBuy]:play()
                end
                if not shop[buttonSelection][4] then
                    if clicks >= shop[buttonSelection][2] then
                        __OWNED[buttonSelection] = __OWNED[buttonSelection] + 1
                        clicks = clicks - shop[buttonSelection][2]
                        CHPS = CHPS + shop[buttonSelection][3]
                    end
                else
                    if clicks >= shop[buttonSelection][2] then
                        __OWNED[buttonSelection] = __OWNED[buttonSelection] + 1
                        clicks = clicks - shop[buttonSelection][2]
                    end
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
    drawUI = function()
        if input:getActiveDevice() == "joy" then
            for i = 1, 5 do -- will need to test this
                if buttonSelection ~= 6 then
                    love.graphics.rectangle("line", 95, -65 + (100 * i), 60,60)
                end
            end
            for i = 1, 2 do
                if buttonSelection >= 6 then
                    love.graphics.rectangle("line", 95, 230 - 105 + (100 * i), 60,60)
                end
            end
        end

        for i = 1, 5 do
            love.graphics.rectangle("fill", 100*i, 140, 50,50, 10, 10, 100)
            love.graphics.print(i, 23 + 100*i,195)
        end
        for i = 1, 2 do 
            love.graphics.rectangle("fill", 100*i, 230, 50,50, 10, 10, 100)
            love.graphics.print(i+5, 23 + 100*i,290)
        end
        

        love.graphics.print("| Shop (In order) |", 0, 280)
        for i = 1, #shop do
            love.graphics.print(shop[i][1]..": "..shop[i][2], 0, 300+(20*i))
        end
        if buttonSelection then
            love.graphics.print("\n\n\nButton Selection = " .. buttonSelection)
        end
    end
}