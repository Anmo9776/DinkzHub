-- modules/autorais.lua

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local function startRaid()
    if not getgenv().DinkzSettings.AutoRaids then return end

    local hasChip = false
    local inventory = LocalPlayer.Backpack:GetChildren()

    for _, item in ipairs(inventory) do
        if item:IsA("Tool") and item.Name:find("Chip") then
            hasChip = true
            break
        end
    end

    if hasChip then
        local raidRemote = Remotes:FindFirstChild("Raids") or Remotes:FindFirstChild("RaidsStart")
        if raidRemote then
            pcall(function()
                raidRemote:InvokeServer("Start", "Flame") -- You can change "Flame" to any raid type you want
            end)
        end
    end
end

-- Runs every 20 seconds to check for chips and start raid
while true do
    task.wait(20)
    if getgenv().DinkzSettings.AutoRaids then
        startRaid()
    end
end
