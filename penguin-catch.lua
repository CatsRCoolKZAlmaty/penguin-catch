scriptroot.SurfaceGui.Frame.TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
scriptroot.SurfaceGui.Frame.TextLabel.TextColor3 = Color3.new(1, 1, 1)

print("Penguin Catch")

local upPort = io.port.input.new(1)
local downPort = io.port.input.new(2)
local leftPort = io.port.input.new(3)
local rightPort = io.port.input.new(4)

upPort.Type = "boolean"
downPort.Type = "boolean"
leftPort.Type = "boolean"
rightPort.Type = "boolean"

local WIDTH, HEIGHT = 20, 10
local penguin = {x = 10, y = 5}
local fish = {x = math.random(WIDTH), y = math.random(HEIGHT)}
local score = 0
local direction = "none"

local function draw()
    local display = ""

    for y = 1, HEIGHT do
        local dotsRemoved = 0
        local dotsToRemove = 0

        if y == penguin.y and y == fish.y then
            dotsToRemove = 2
        elseif y == penguin.y then
            dotsToRemove = 1
        elseif y == fish.y then
            dotsToRemove = 1
        end

        local x = 1
        while x <= WIDTH do
            if penguin.x == x and penguin.y == y then
                display = display .. "🐧"
            elseif fish.x == x and fish.y == y then
                display = display .. "🐟"
            elseif dotsRemoved < dotsToRemove and ((y == penguin.y and x ~= penguin.x) or (y == fish.y and x ~= fish.x)) then
                dotsRemoved = dotsRemoved + 1
            else
                display = display .. "."
            end
            x = x + 1
        end

        display = display .. "\n"
    end

    display = display .. "Score: " .. score
    scriptroot.SurfaceGui.Frame.TextLabel.Text = display
end

local function move()
if direction == "up" then penguin.y = penguin.y - 1 end
if direction == "down" then penguin.y = penguin.y + 1 end
if direction == "left" then penguin.x = penguin.x - 1 end
if direction == "right" then penguin.x = penguin.x + 1 end

if penguin.x < 1 then penguin.x = WIDTH end
if penguin.x > WIDTH then penguin.x = 1 end
if penguin.y < 1 then penguin.y = HEIGHT end
if penguin.y > HEIGHT then penguin.y = 1 end

if penguin.x == fish.x and penguin.y == fish.y then
score = score + 1
fish.x = math.random(WIDTH)
fish.y = math.random(HEIGHT)
end
end

upPort.Changed:Connect(function() if upPort:GetValue() then direction = "up" end end)
downPort.Changed:Connect(function() if downPort:GetValue() then direction = "down" end end)
leftPort.Changed:Connect(function() if leftPort:GetValue() then direction = "left" end end)
rightPort.Changed:Connect(function() if rightPort:GetValue() then direction = "right" end end)

task.spawn(function()
while true do
move()
draw()
task.wait(0.33)
end
end)
