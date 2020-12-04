Rectangle = GameObject:extend()

function Rectangle:new(x, y, w, h)
	Rectangle.super.new(self, x, y)
	self.width = w
	self.height = h
end

function Rectangle:draw()
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Rectangle:getSecondX()
	return self.x + self.width
end

function Rectangle:getSecondY()
	return self.y + self.height
end