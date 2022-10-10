local timer

function love.load()    
    -- load libriries 
    baton = require "lib.baton"
	Gamestate = require "lib.gamestate"
    lovesize = require "lib.lovesize"
    lume = require "lib.lume"
    Timer = require "lib.timer"
    fuck = require "lib.fuck"
    loveframes = require("lib.LoveFrames")
    require 'lib/lovefs/lovefs'
    require 'lib/lovefs/loveframesDialog'

    -- load modules
    graphics = require "modules.graphics"
    input = require "modules.input"
    
    -- load states
    shopMenu = require "states.shop"
    clickerMenu = require "states.clicker"
    startMenu = require "states.startMenu"

    -- Data/Function files
    shopFunc = require "data.shopFunctions"-- Shop data
    clickerFunc = require "data.clickerFunctions"-- Clicker data

    sounds = {
        shopBuy = {
            [1] = love.audio.newSource("audio/shopBuy.wav", "static")
        },
        hangerClick = {
            [1] = love.audio.newSource("audio/hangerClick.wav", "static") -- Unused (I hate the sound)
        }
    }

    function saveGame()
        f = {}
        f.savefile = {
            saveClicks = clicks,
            saveminiHangerOwn = __OWNED[1],
            saveplasticHangerOwn = __OWNED[2],
            savecopperHangerOwn = __OWNED[3],
            savesteelHangerOwn = __OWNED[4],
            saveironHangerOwn = __OWNED[5],
            savegoldHangerOwn = __OWNED[6],

            saveclickerPowerOwn = __OWNED[#__OWNED],

            saveCHPs = CHPS,
            saveVer = saveVer
        }
        serialized = lume.serialize(f)
        love.filesystem.write("die.chcsave", serialized)
        tableStr = lume.serialize(f.savefile, "die.chcsave")
        print(tableStr)
        fuckStr = fuck:e(tostring(tableStr))
        love.filesystem.write("die.chcsave", fuckStr)
    end

    function autoHanger()
        Timer.after(
            1,
            function()
                clicks = clicks + CHPS
                autoHanger()
            end
        )
    end
    autoHanger()
    fsload = lovefs()
    btload = loveframes.Create('button', window)	
	btload:SetPos(0,0)
	btload:SetSize(200, 40)
	btload:SetText('Load save file')
    btload.OnClick = function(object)
		fsload:loadDialog(loveframes, nil, {'All | *.*',})
	end

    love.graphics.setDefaultFilter("nearest")
    clothingHanger = graphics.newImage(love.graphics.newImage(graphics.imagePath("clothingHanger")))
    love.graphics.setDefaultFilter("linear")
    clothingHanger.sizeX, clothingHanger.sizeY = 2.2
    clothingHanger.x, clothingHanger.y = 340, 350

    timer = 0
    shop1Price = 10
    shop2Price = 50
    if love.filesystem.getInfo("die.chcsave") then
        savefile = love.filesystem.read("die.chcsave")
        f = lume.deserialize(fuck:d(love.filesystem.read("die.chcsave")))
        print(lume.serialize(fuck:d(love.filesystem.read("die.chcsave")), "die.chcsave"))
        print(lume.deserialize(fuck:d(love.filesystem.read("die.chcsave"))))

        clicks = f.saveClicks
        CHPS = f.saveCHPs or 0
        __OWNED = {
            [1] = f.saveminiHangerOwn,
            [2] = f.saveplasticHangerOwn,
            [3] = f.savecopperHangerOwn,
            [4] = f.savesteelHangerOwn,
            [5] = f.saveironHangerOwn,
            [6] = f.savegoldHangerOwn
        }
        table.insert(__OWNED, f.saveclickerPowerOwn) -- makes sure Clicker Power is ALWAYS last
        saveVer = f.saveVer
    end -- removed elseif statement to fix saves
    if not love.filesystem.getInfo("die.chcsave") or saveVer ~= 2 then -- if there is no save file or the save file is outdated
        love.window.showMessageBox(
            "Save Error",
            "Old/Unavailable savefile detected.\
            Resetting save...",
            "error"
        )
        clicks = 0
        CHPS = 0
        __OWNED = {
            [1] = 0, -- Mini Hanger
            [2] = 0, -- Plastic Hanger
            [3] = 0, -- Copper Hanger
            [4] = 0, -- Steel Hanger
            [5] = 0, -- Iron Hanger
            [6] = 0, -- Gold Hanger
        }
        table.insert(__OWNED, 0) -- makes sure Clicker Power is ALWAYS last
        saveVer = 2
    end
    if love.filesystem.getInfo("version.txt") then
        __VERSION__ = love.filesystem.read("version.txt")
    else
        __VERSION__ = "UNKNOWN"
    end

    love.window.setIcon(love.image.newImageData("icon.png"))

    love.window.setMode(720, 620, {resizable=true, vsync=true}) 
    lovesize.set(720, 620)

    Gamestate.switch(startMenu)
    
end

function love.update(dt)
    if Gamestate.current() == startMenu then
        if fsload.selectedFile then
            ext = fsload.selectedFile:match('[^'..fsload.sep..']+$'):match('[^.]+$')
            if ext == 'chcsave' then
                newImage = fsload:loadSave()
            end
        end
    end
    input:update()
    loveframes.update(dt)
    graphics.screenBase(lovesize.getWidth(), lovesize.getHeight())
    Gamestate.update(dt)
    Timer.update(dt)
    
    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()
end

function love.keypressed(key)
	if key == "6" then
		love.filesystem.createDirectory("screenshots")

		love.graphics.captureScreenshot("screenshots/" .. os.time() .. ".png")
    elseif key == "escape" then
        saveGame()
        love.event.quit()
    else
        Gamestate.keypressed(key)
    end
end

function love.resize(width, height)
	lovesize.resize(width, height)
end

function love.mousepressed(x, y, button, istouch, presses)
	Gamestate.mousepressed(x, y, button, istouch, presses)
    loveframes.mousepressed(x, y, button)
end
function love.mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button)
end
function love.keypressed(key, unicode)
	loveframes.keypressed(key, unicode)
end

function love.keyreleased(key, unicode)
	loveframes.keyreleased(key)
end

function love.textinput(text)
	loveframes.textinput(text)
end

function love.draw()
    graphics.screenBase(lovesize.getWidth(), lovesize.getHeight())
        lovesize.begin()
            Gamestate.draw()
        lovesize.finish()
    graphics.screenBase(love.graphics.getWidth(), love.graphics.getHeight())
    if Gamestate.current() ~= startMenu then
        love.graphics.print(
            "Clicks: " .. clicks ..
            "\nCHPS: " .. CHPS 
        )
    end
    love.graphics.printf(
        "Version: " .. __VERSION__,
        615,
        602,
        100,
        "right"
    )
    if Gamestate.current() == startMenu then
        loveframes.draw()
    end
    if not love.filesystem.isFused() then love.graphics.print("\n\n\n\n\n\nDEBUG\nMouse X: " .. mouseX .. "\nMouse Y: " .. mouseY,620) end
end

function love.quit()
    saveGame()
end
