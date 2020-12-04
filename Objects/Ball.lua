Ball = Circle:extend()


function Ball:new(margin)
	Ball.super.new(self, gw*0.5, gh*0.925, gh*0.025)
	self.margin = margin
	self.speed = 800
	self.state = IdleState(self)
	self.xDir = math.cos(270)
	self.yDir = math.sin(270)
end


function Ball:update(dt, level)
	self.state:update(dt, self, level)
end

function Ball:draw()
	Ball.super.draw(self)
end

-- return 8 points that will be used to test collisions, points are:
-- ball max x, ball center y 
-- ball min x, ball center y 
-- ball center x, ball max y 
-- ball center x, ball min y 
-- ball max x, ball min y
-- ball max x, ball max y 
-- ball min x, ball min y 
-- ball min x, ball max y 
function Ball:getCollisionPoints()
	local ballRight = self.x + self.r
	local ballLeft = self.x - self.r
	local ballButtom = self.y + self.r
	local ballTop = self.y - self.r
	return  {{["x"] = ballRight, ["y"] = self.y},
			 {["x"] = ballLeft, ["y"] = self.y},
			 {["x"] = self.x, ["y"] = ballButtom},
			 {["x"] = self.x, ["y"] = ballTop},
             {["x"] = ballRight, ["y"] = ballTop},
             {["x"] = ballRight, ["y"] = ballButtom},
             {["x"] = ballLeft, ["y"] = ballTop},
             {["x"] = ballLeft, ["y"] = ballButtom}}
end

function Ball:flipXDir()
	self.xDir = self.xDir * (-1)
end

function Ball:flipYDir()
	self.yDir = self.yDir * (-1)
end


function Ball:respawn()
	self.x = gw*0.5
	self.y = gh*0.925
	self.state = IdleState(self)
	self.xDir = math.cos(270)
	self.yDir = math.sin(270)
end