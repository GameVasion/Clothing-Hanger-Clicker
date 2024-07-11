local graphics = {}
graphics.cache = {}

function graphics.newImage(path)
    local path = "assets/img/" .. path .. ".png"

    if not love.filesystem.getInfo(path) then
        error("File " .. path .. " does not exist!")
    end

    if not graphics.cache[path] then
        graphics.cache[path] = love.graphics.newImage(path)
    end

    local object = {
        x = 0,
        y = 0,
        width = graphics.cache[path]:getWidth(),
        height = graphics.cache[path]:getHeight(),

        alignment = "top-left",
        rotation = 0,
        scale = 1,
        opacity = 1,

        image = graphics.cache[path],

        _type = "image",

        getWidth = function(self)
            return self.width * self.scale
        end,

        getHeight = function(self)
            return self.height * self.scale
        end,

        draw = function(self)
            local x, y = self.x, self.y
            local ox, oy = 0, 0
            if self.alignment == "center" then
                ox = self.width / 2
                oy = self.height / 2
            elseif self.alignment == "top-left" then
                -- do nothing
            elseif self.alignment == "top-right" then
                ox = self.width
            elseif self.alignment == "bottom-left" then
                oy = self.height
            elseif self.alignment == "bottom-right" then
                ox = self.width
                oy = self.height
            end

            -- get current color
            local r, g, b, a = love.graphics.getColor()
            love.graphics.setColor(r, g, b, self.opacity)
            love.graphics.draw(self.image, x, y, self.rotation, self.scale, self.scale, ox, oy)
            love.graphics.setColor(r, g, b, a)
        end
    }

    return object
end

function graphics.newButton(x,y,w,h,str)
    local object = {
        x = x or 0,
        y = y or 0,

        width = w or 100,
        height = h or 100,

        roundness = 10,

        color = {
            r = 0.5,
            g = 0.5,
            b = 0.5,
            a = 1
        },

        hoveredColor = {
            r = 0.6,
            g = 0.6,
            b = 0.6,
            a = 1
        },

        text = {
            string = str or "Button",
            font = love.graphics.newFont(20),
            color = {
                r = 1,
                g = 1,
                b = 1,
                a = 1
            },
            hoveredColor = {
                r = 1,
                g = 1,
                b = 1,
                a = 1
            }
        },

        draw = function(self)
            -- get current color
            local r, g, b, a = love.graphics.getColor()
            if self:isHovered() then
                love.graphics.setColor(self.hoveredColor.r, self.hoveredColor.g, self.hoveredColor.b, self.hoveredColor.a)
            else
                love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
            end
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.roundness)
            love.graphics.setColor(r, g, b, a)

            -- get current font
            local font = love.graphics.getFont()
            love.graphics.setFont(self.text.font)

            -- get current color
            local r, g, b, a = love.graphics.getColor()
            if self:isHovered() then
                love.graphics.setColor(self.text.hoveredColor.r, self.text.hoveredColor.g, self.text.hoveredColor.b, self.text.hoveredColor.a)
            else
                love.graphics.setColor(self.text.color.r, self.text.color.g, self.text.color.b, self.text.color.a)
            end
            love.graphics.printf(self.text.string, self.x, self.y + self.height / 2 - self.text.font:getHeight() / 2, self.width, "center")
            love.graphics.setColor(r, g, b, a)

            -- set font back
            love.graphics.setFont(font)
        end,

        isHovered = function(self)
            local x, y = love.mouse.getPosition()
            
            return x > self.x and
                   x < self.x + self.width and
                   y > self.y and
                   y < self.y + self.height
        end,

        isClicked = function(self)
            return self:isHovered() and input:pressed("pressed")
        end
    }

    return object
end

function graphics.shopButton(x,y,w,h,str, data, realName)
    local object = {
        x = x or 0,
        y = y or 0,

        width = w or 100,
        height = h or 100,

        roundness = 10,

        color = {
            r = 0.5,
            g = 0.5,
            b = 0.5,
            a = 1
        },

        data = data,
        name = realName,

        hoveredColor = {
            r = 0.6,
            g = 0.6,
            b = 0.6,
            a = 1
        },

        text = {
            string = str or "Button",
            font = love.graphics.newFont(20),
            color = {
                r = 1,
                g = 1,
                b = 1,
                a = 1
            },
            hoveredColor = {
                r = 1,
                g = 1,
                b = 1,
                a = 1
            }
        },

        draw = function(self)
            -- get current color
            local r, g, b, a = love.graphics.getColor()
            if self:isHovered() then
                love.graphics.setColor(self.hoveredColor.r, self.hoveredColor.g, self.hoveredColor.b, self.hoveredColor.a)
            else
                love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
            end
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.roundness)
            love.graphics.setColor(r, g, b, a)

            -- get current font
            local font = love.graphics.getFont()
            love.graphics.setFont(self.text.font)

            -- get current color
            local r, g, b, a = love.graphics.getColor()
            if self:isHovered() then
                love.graphics.setColor(self.text.hoveredColor.r, self.text.hoveredColor.g, self.text.hoveredColor.b, self.text.hoveredColor.a)
            else
                love.graphics.setColor(self.text.color.r, self.text.color.g, self.text.color.b, self.text.color.a)
            end
            love.graphics.printf(self.text.string, self.x, self.y, self.width, "center")
            love.graphics.setColor(r, g, b, a)

            -- set font back
            love.graphics.setFont(font)
        end,

        isHovered = function(self)
            local x, y = love.mouse.getPosition()
            
            return x > self.x and
                   x < self.x + self.width and
                   y > self.y and
                   y < self.y + self.height
        end,

        isClicked = function(self)
            return self:isHovered() and input:pressed("pressed")
        end
    }

    return object
end

return graphics