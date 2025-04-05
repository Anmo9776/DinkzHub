-- main.lua

-- Wait until player is fully loaded
repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Helper to load modules from GitHub
local function loadModule(name)
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/DinkzHub/main/modules/" .. name .. ".lua"))()
    end)
    if not success then
        warn("Failed to load module:", name, result)
    end
end

-- Load NPC quest data
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Anmo9776/DinkzHub/main/npcdata.lua"))()
end)

-- Initialize settings
getgenv().DinkzSettings = getgenv().DinkzSettings or {
    AutoFarm = true,
    FastAttack = true,
    AutoAura = true,
    AutoRedeemCodes = true,
    AutoRaids = false,
    ESPEnabled = true,
    ESPEnemies = true,
    ESPPlayers = true,
    ESPFruits = true,
    ESPBerries = true,
    SelectedWeapon = "",
    SelectedIsland = "",
    MasteryFarm = false
}

-- Load modules
loadModule("ui")           -- GUI & toggles
loadModule("autofarm")     -- Auto quest, move, farm
loadModule("fastattack")   -- No delay damage
loadModule("aura")         -- Buso Haki auto enable
loadModule("redeemcodes")  -- Auto claim all codes
loadModule("autorais")     -- Auto Raids
loadModule("esp")          -- All ESP text: fruits, players, enemies
loadModule("tp")           -- Teleport system

-- Confirm loaded
print("[DinkzHub] Loaded all systems.")
