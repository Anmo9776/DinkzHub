-- modules/aura.lua

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function enableAura()
    if not getgenv().DinkzSettings.AutoAura then return end

    local character = LocalPlayer.Character
    if not character then return end

    local hasAura = false

    for _, v in pairs(character:GetChildren()) do
        if v:IsA("Accessory") and v.Name:find("Armament") then
            hasAura = true
            break
        end
    end

    if not hasAura then
        local event = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Buso")
        if event then
            event:FireServer()
        end
    end
end

-- Run on character added
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    enableAura()
end)

-- Periodically check aura every 5 seconds
while true do
    task.wait(5)
    enableAura()
end
