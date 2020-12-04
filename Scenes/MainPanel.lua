MainPanel = Object:extend();

function MainPanel:new(text)
    self.text = text or "Start"
    self.main_canvas = love.graphics.newCanvas(gw, gh)
    local width = gw*0.3
    local height = gh*0.2
    self.playButtonImage = Image("Images/Button.png", gw*0.5, gh*0.5, width, height)
    self.playRect = Rectangle(self.playButtonImage.x - width/2, self.playButtonImage.y - height/2, width, height)
    self.font = love.graphics.newFont("Fonts/arial.ttf", 40)
end

function MainPanel:update(dt)
    local x, y = love.mouse.getPosition( )
    if love.mouse.isDown(1) then
        if x > self.playRect.x and x < self.playRect:getSecondX() and
            y > self.playRect.y and y < self.playRect:getSecondY() then
                gotoScene("Level1", 3)
        end
    end
end

function MainPanel:draw()
    love.graphics.setCanvas(self.main_canvas)
    love.graphics.clear()

    love.graphics.draw(self.playButtonImage.image, self.playButtonImage.x, self.playButtonImage.y, 0 , self.playButtonImage.sx, self.playButtonImage.sy, self.playButtonImage.ox, self.playButtonImage.oy)
    love.graphics.printf(self.text, 0, gh*0.5 - self.font:getHeight()/2, gw, "center")

    love.graphics.setCanvas()

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setBlendMode('alpha', 'premultiplied')
    love.graphics.draw(self.main_canvas, 0, 0, 0, sx, sy)
    love.graphics.setBlendMode('alpha')
end