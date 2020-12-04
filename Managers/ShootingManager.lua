ShootingManager = Object:extend()

-- this class will manages the shots that are being fired from the blocks
function ShootingManager:new(level)
    self.level = level
    self.projectiles = {}
end

function ShootingManager:update(dt)
    for _, projectile in pairs(self.projectiles) do
        projectile:update(dt)
    end
end

-- creates a new shooting timer that will fire a new shot by the given rate (rate is determined by the amount of blocks left)
-- if there already is a timer it will delete it and put a new one 
function ShootingManager:startShooting(rate)
	print("starting shoot rate " .. rate)
	if self.shootingTimer then timer:cancel(self.shootingTimer) end

	self.shootingTimer = timer:every(rate*20, function() self:shoot() end)
end


-- randomly generates a blockNumber, gets a block from the field with it and fires a new projectile from that blocks.
function ShootingManager:shoot()
	local blockNumber = love.math.random(self.level.currentNumOfBlocks)
	local block = self.level:getBlockByNumber(blockNumber)
	local xShot = block.x + love.math.random(block.width) - 1
	local yShot = block.y + block.height
	table.insert(self.projectiles, Projectile(xShot, yShot))
end

-- returns the first projectile in the projectiles table
function ShootingManager:getProjectile()
	local projectile
	if #self.projectiles ~= 0 then
        projectile = self.projectiles[1]
    end
    return projectile
end