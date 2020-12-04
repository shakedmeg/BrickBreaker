MainMenu = Object:extend();

function MainMenu:new()
    self.area = Area(self)
    self.main_canvas = love.graphics.newCanvas(gw, gh)
end

function MainMenu:update(dt)
    self.area:update(dt)
end

function MainMenu:draw()
    love.graphics.setCanvas(self.main_canvas)
    love.graphics.clear()

    local w = gw/2 - gw*0.3/2
    local h = gh/2 - gh*0.2/2
        love.graphics.rectangle('fill', w, h, gw*0.3, gh*0.2)
        self.area:draw()
    love.graphics.setCanvas()

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setBlendMode('alpha', 'premultiplied')
    love.graphics.draw(self.main_canvas, 0, 0, 0, sx, sy)
    love.graphics.setBlendMode('alpha')
end

function MainMenu:__tostring()
  return "MainMenu"
end