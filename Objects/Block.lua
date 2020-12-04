Block = Rectangle:extend()
Block.width = gw*0.1
Block.height = gh*0.05


function Block:new(x, y)
	Block.super.new(self, x, y, gw*0.1, gh*0.05)
end


function Block:draw()
	Block.super.draw(self)
end
