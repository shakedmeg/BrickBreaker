Paddle = GameObject:extend()

-- the paddle is consturcted from two circles and a rectangle the only moves horizontally on the screen
function Paddle:new()
	Paddle.super.new(self, gw*0.5, gh*0.975)
	local w = gw*0.1
	local h = gh*0.025
	self.rect = Rectangle(self.x - w/2, self.y - h/2, w, h)

	self.r = self.rect.height/2
	self.c1 = Circle(self.rect.x, self.rect.y + self.rect.height/2, self.r)
	self.c2 = Circle(self.rect.x + self.rect.width, self.rect.y + self.rect.height/2, self.r)
	self.speed = 800

end

-- moves the paddle within the screen's limitations
function Paddle:update(dt)
	local x = love.mouse.getX()
	if x > self.x then 
		self.x = math.min(x, self.x + (dt * self.speed), gw - self.rect.width/2 - self.r)
	elseif x < self.x then
	    self.x = math.max(x, self.x - (dt * self.speed), self.rect.width/2 + self.r)
	end
	self.rect.x = self.x - self.rect.width/2
	self.c1.x = self.rect.x
	self.c2.x = self.rect.x + self.rect.width
end

function Paddle:draw()
	love.graphics.print("mouse " .. love.mouse.getX() .. " paddle x " .. self.x, 0, 0, 0 ,5, 5, 0, 0)
	self.rect.draw(self.rect)
	self.c1.draw(self.c1)
	self.c2.draw(self.c2)
end

function Paddle:respawn()
	self.x = gw*0.5
	self.y = gh*0.975
	self.rect.x = self.x - self.rect.width/2
	self.rect.y = self.y - self.rect.height/2

	self.c1.x = self.rect.x
	self.c1.y = self.rect.y + self.rect.height/2
	self.c2.x = self.rect.x + self.rect.width
	self.c2.y = self.rect.y + self.rect.height/2
end