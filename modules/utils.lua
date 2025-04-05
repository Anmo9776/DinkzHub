-- modules/utils.lua

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

getgenv().DinkzUtils = {}

-- Detect current player level
function DinkzUtils.GetLevel()
    local level = 1
    pcall(function()
        local stats = LocalPlayer:WaitForChild("Data")
        level = stats.Level.Value
    end)
    return level
end

-- Get nearest enemy by name match
function DinkzUtils.GetNearestEnemy(name)
    local closest, distance = nil, math.huge
    for _, v in ipairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
            if name == nil or v.Name:find(name) then
                local dist = (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if dist < distance and v.Humanoid.Health > 0 then
                    closest = v
                    distance = dist
                end
            end
        end
    end
    return closest
end

-- Smooth fly tween
function DinkzUtils.FlyTo(pos)
    local hrp = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    local tween = game:GetService("TweenService"):Create(hrp, TweenInfo.new((hrp.Position - pos).Magnitude / 250, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
    tween:Play()
    tween.Completed:Wait()
end
