local curOS = love.system.getOS()

local saveData = (curOS ~= "Web" and [[
[Save]
clicks=0
]])

local saveIni

local save = {}

if love.filesystem.getInfo("saveData.ini") then
    saveIni = ini.load("saveData.ini")
else
    local success, message = love.filesystem.write("settings.ini", saveData)

    if success then
        love.window.showMessageBox("Success", "SaveData file successfully created: \"" .. love.filesystem.getSaveDirectory() .. "/settings.ini\"")
    else
        love.window.showMessageBox("Error", message)
    end
end

saveIni = ini.load("saveData.ini")
clicks = tonumber(ini.readKey(saveIni, "Save", "clicks"))

return save