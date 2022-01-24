shop = {}

function shop.load()
    print("in the shop")
end

function shop.update(dt)
    
end

function shop.keypressed(key)
    if key == "1" then
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
    elseif key == "2" then
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
end

function shop.draw()
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