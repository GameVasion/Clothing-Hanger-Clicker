return {
    MiniHangerBuy = function()
        if miniHangerOwn >= 1 then
            if clicks >= shopPrice[1] * (miniHangerOwn * 1.1) then
                price = shopPrice[1] * (miniHangerOwn * 1.1)
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
    ClickPowerBuy = function()
        if clickerPowerOwn >= 1 then
            if clicks >= shopPrice[2] * (clickerPowerOwn * 1.1) then
                price = shopPrice[2] * (clickerPowerOwn * 1.1)
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
    PlasticHangerBuy = function()
        if plasticHangerOwn >= 1 then
            if clicks >= shopPrice[3] * (plasticHangerOwn * 1.1) then
                price = shopPrice[3] * (plasticHangerOwn * 1.1)
                plasticHangerOwn = plasticHangerOwn + 1
                clicks = clicks - price
                CHPS = CHPS + 1
            end
        else
            if clicks >= shopPrice[3] then
                plasticHangerOwn = plasticHangerOwn + 1
                clicks = clicks - shopPrice[3]
                CHPS = CHPS + 1
            end
        end
    end,
}