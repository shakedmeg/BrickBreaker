Level = Object:extend();

function Level:new(lives, blocksZone, gapX, gapY)
    self.blocks = {}
    self.paddle = Paddle()
    self.ball = Ball(self.paddle.rect.width/2 + self.paddle.r)
    self.lives = lives
    self.main_canvas = love.graphics.newCanvas(gw, gh)
    self.blocksZone = blocksZone
    self.gapX = gapX
    self.gapY = gapY
    self.collisionManager = CollisionManager(self)
    self.shootingManager = ShootingManager(self)
    self.numOfBlocks = 0
    self.currentNumOfBlocks = 0
    self.dead = false
end

function Level:update(dt)
    if self.dead then return end
    self.ball.state:handleInput(self.ball)

    self.paddle:update(dt)
    self.ball:update(dt, self)
    self.shootingManager:update(dt)
    self.collisionManager:update(dt, self.ball, self.paddle)
end

function Level:draw()
    love.graphics.setCanvas(self.main_canvas)
    love.graphics.clear()
    
    if not self.dead then
        self.ball:draw()
        self.paddle:draw()
    end

    for _, v in pairs(self.blocks) do
        for _, block in pairs(v) do
            block:draw()
        end
    end


    for _, projectile in pairs(self.shootingManager.projectiles) do
        projectile:draw()
    end

    love.graphics.setCanvas()

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setBlendMode('alpha', 'premultiplied')
    love.graphics.draw(self.main_canvas, 0, 0, 0, sx, sy)
    love.graphics.setBlendMode('alpha')
end

-- turn dead to true, decrement lives, and deletes projectiles from screen. if no lives are left it will activate a game over scene (TODO)
-- else it respwans the ball and the paddle
function Level:die()
    self.dead = true
    self.lives = self.lives -1
    self.shootingManager.projectiles = {}
    timer:cancel(self.shootingManager.shootingTimer)
    if self.lives == 0 then
        love.graphics.print("Game Over")
    else
        timer:after(1, function() self:respawn() end)
    end
end

function Level:respawn()
    self.ball:respawn()
    self.paddle:respawn()
    self.dead = false
end



-- iterates the blocks table and finds a block by a blockNumber
function Level:getBlockByNumber(blockNumber)
    local counter = 0
    local k, v = next(self.blocks)
    local innerK, innerV
    while counter < blockNumber do
        counter = counter + 1
        innerK, innerV = next(v, innerK)
        if innerK == nil then
            k, v = next(self.blocks, k)
            innerK, innerV = next(v)
        end
    end
    return innerV
end

-- removes a block by a key
function Level:removeBlock(key)
    self.blocks[key.y][key.x] = nil
    if next(self.blocks[key.y]) == nil then
        self.blocks[key.y] = nil
    end
    self.currentNumOfBlocks = self.currentNumOfBlocks - 1
end


-- escalates the fire rate or moves to the next level if no blocks are left
function Level:escelate()
    if self.currentNumOfBlocks > 0 then
        self.shootingManager:startShooting(self.currentNumOfBlocks / self.numOfBlocks)
    else 
        self.shootingManager.projectiles = {}
        timer:cancel(self.shootingManager.shootingTimer)
        timer:after(1, function() gotoScene("Level2", self.lives) end)
    end
end