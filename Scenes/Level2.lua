Level2 = Level:extend();

function Level2:new(lives)
    Level2.super.new(self, lives, Rectangle(gw*0.15, gw*0.1, gw*0.70, gh * 0.26), gw*0.02, gh*0.02)

    local y = self.blocksZone.y
    for i = 1,4 do
        local x = self.blocksZone.x
        local row = tostring(i)
        local block
        self.blocks[row] = {}
        for j = 1, 6 do
            block = Block(x, y)
            self.blocks[row][tostring(j)] = block
            self.numOfBlocks = self.numOfBlocks + 1
            x = x + block.width + self.gapX
        end
        y = y + block.height + self.gapY
    end
    self.currentNumOfBlocks = self.numOfBlocks
end

function Level2:update(dt)
    Level1.super.update(self, dt)
end

function Level2:draw()
    Level1.super.draw(self)
end
