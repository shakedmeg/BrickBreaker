Projectile = Rectangle:extend()


function Projectile:new(x, y)
	Projectile.super.new(self, x, y, gw * 0.01, gh * 0.02)
	self.speed = 200
end

function Projectile:update(dt)
	self.y = self.y + self.speed * dt 
end

function Projectile:draw()
	Projectile.super.draw(self)
end