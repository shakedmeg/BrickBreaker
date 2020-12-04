Object = require 'Lib/oop'
Timer = require 'Lib/EnhancedTimer'

require 'GameObject'
require 'Circle'
require 'Rectangle'
require 'utils'

function love.load(...)
	local width, height = love.graphics.getDimensions()
	resize(width/gw, height/gh)


    local object_files = {}
    recursiveEnumerate('Objects', object_files)
    requireFiles(object_files)

    local object_files = {}
    recursiveEnumerate('Managers', object_files)
    requireFiles(object_files)

	local scene_files = {}
    recursiveEnumerate('Scenes', scene_files)
    requireFiles(scene_files)
    timer = Timer()
    current_scene = nil
	gotoScene('Level1', 3)
end


function love.update(dt)
    timer:update(dt)
    if current_scene then current_scene:update(dt) end
end

function love.draw()
    if current_scene then current_scene:draw() end
end


function gotoScene(scene_type, ...)
    current_scene = _G[scene_type](...)
end


function recursiveEnumerate(folder, file_list)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, item in ipairs(items) do
        local file = folder .. '/' .. item
        local t = love.filesystem.getInfo(file)
        if t.type == "file" then
            table.insert(file_list, file)
        elseif t.type == "directory" then
            recursiveEnumerate(file, file_list)
        end
    end
end

function requireFiles(files)
    for _, file in ipairs(files) do
        local file = file:sub(1, -5)
        require(file)
    end
end

function resize(sw, sh)
    love.window.setMode(sw*gw, sh*gh) 
    sx, sy = sw, sh
end



function love.run()
    if love.math then love.math.setRandomSeed(os.time()) end
    if love.load then love.load(arg) end
    if love.timer then love.timer.step() end

    local dt = 0
    local fixed_dt = 1/60
    local accumulator = 0

    while true do
        if love.event then
            love.event.pump()
            for name, a, b, c, d, e, f in love.event.poll() do
                if name == 'quit' then
                    if not love.quit or not love.quit() then
                        return a
                    end
                end
                love.handlers[name](a, b, c, d, e, f)
            end
        end

        if love.timer then
            love.timer.step()
            dt = love.timer.getDelta()
        end

        accumulator = accumulator + dt
        while accumulator >= fixed_dt do
            if love.update then love.update(fixed_dt) end
            accumulator = accumulator - fixed_dt
        end

        if love.graphics and love.graphics.isActive() then
            love.graphics.clear(love.graphics.getBackgroundColor())
            love.graphics.origin()
            if love.draw then love.draw() end
            love.graphics.present()
        end

        if love.timer then love.timer.sleep(0.0001) end
    end
end