-- modules/ui.lua

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Global Settings Table
getgenv().DinkzSettings = getgenv().DinkzSettings or {
    AutoFarm = true,
    FastAttack = true,
    AutoAura = true,
    AutoRedeemCodes = true,
    AutoRaids = true,
    ESPEnabled = true,
    ESPEnemies = true,
    ESPPlayers = true,
    ESPFruits = true,
    ESPBerries = true,
    SelectedWeapon = "",
    SelectedIsland = "",
    MasteryFarm = false
}

-- GUI
local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "DinkzHubUI"
screenGui.ResetOnSpawn = false

-- Floating Button
local floatBtn = Instance.new("TextButton", screenGui)
floatBtn.Size = UDim2.new(0, 100, 0, 40)
floatBtn.Position = UDim2.new(0, 20, 0.5, 0)
floatBtn.Text = "Dinkz Hub"
floatBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
floatBtn.TextColor3 = Color3.new(1, 1, 1)
floatBtn.TextScaled = true
floatBtn.Draggable = true
floatBtn.Active = true

-- Main UI
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 500)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Visible = false

local uiCorner = Instance.new("UICorner", mainFrame)
uiCorner.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Dinkz Hub"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

-- Toggle Generator
local yPos = 50
local settings = {
    {Key = "AutoFarm", Label = "Auto Farm"},
    {Key = "FastAttack", Label = "Fast Attack"},
    {Key = "AutoAura", Label = "Auto Aura"},
    {Key = "AutoRedeemCodes", Label = "Auto Redeem"},
    {Key = "AutoRaids", Label = "Auto Raids"},
    {Key = "ESPEnabled", Label = "Enable ESP"},
    {Key = "ESPEnemies", Label = "ESP Enemies"},
    {Key = "ESPPlayers", Label = "ESP Players"},
    {Key = "ESPFruits", Label = "ESP Fruits"},
    {Key = "ESPBerries", Label = "ESP Berries"},
    {Key = "MasteryFarm", Label = "Mastery Farm"}
}

for _, setting in ipairs(settings) do
    local toggle = Instance.new("TextButton", mainFrame)
    toggle.Size = UDim2.new(1, -20, 0, 30)
    toggle.Position = UDim2.new(0, 10, 0, yPos)
    toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.Text = setting.Label .. ": " .. (getgenv().DinkzSettings[setting.Key] and "ON" or "OFF")
    toggle.Font = Enum.Font.SourceSans
    toggle.TextScaled = true
    toggle.MouseButton1Click:Connect(function()
        getgenv().DinkzSettings[setting.Key] = not getgenv().DinkzSettings[setting.Key]
        toggle.Text = setting.Label .. ": " .. (getgenv().DinkzSettings[setting.Key] and "ON" or "OFF")
    end)
    yPos += 35
end

-- Weapon Dropdown
local weaponLabel = Instance.new("TextLabel", mainFrame)
weaponLabel.Position = UDim2.new(0, 10, 0, yPos)
weaponLabel.Size = UDim2.new(1, -20, 0, 25)
weaponLabel.Text = "Select Weapon"
weaponLabel.TextColor3 = Color3.new(1, 1, 1)
weaponLabel.BackgroundTransparency = 1
weaponLabel.TextScaled = true
yPos += 25

local weaponDropdown = Instance.new("TextButton", mainFrame)
weaponDropdown.Position = UDim2.new(0, 10, 0, yPos)
weaponDropdown.Size = UDim2.new(1, -20, 0, 30)
weaponDropdown.Text = "Choose..."
weaponDropdown.TextColor3 = Color3.new(1, 1, 1)
weaponDropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
weaponDropdown.TextScaled = true

local function refreshWeapons()
    local tools = LocalPlayer.Backpack:GetChildren()
    for _, tool in ipairs(tools) do
        if tool:IsA("Tool") then
            local opt = Instance.new("TextButton", weaponDropdown)
            opt.Size = UDim2.new(1, 0, 0, 25)
            opt.Position = UDim2.new(0, 0, 0, 30)
            opt.Text = tool.Name
            opt.TextScaled = true
            opt.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            opt.TextColor3 = Color3.new(1, 1, 1)
            opt.MouseButton1Click:Connect(function()
                getgenv().DinkzSettings.SelectedWeapon = tool.Name
                weaponDropdown.Text = tool.Name
                for _, child in pairs(weaponDropdown:GetChildren()) do
                    if child:IsA("TextButton") and child ~= weaponDropdown then child:Destroy() end
                end
            end)
        end
    end
end

weaponDropdown.MouseButton1Click:Connect(refreshWeapons)
yPos += 35

-- Island Dropdown
local islands = {
    "Starter Island", "Jungle", "Desert", "Snow Island",
    "Marine Base", "Sky Island", "Colosseum", "Haunted Castle", "Cake Island"
}

local islandLabel = Instance.new("TextLabel", mainFrame)
islandLabel.Position = UDim2.new(0, 10, 0, yPos)
islandLabel.Size = UDim2.new(1, -20, 0, 25)
islandLabel.Text = "Fly Teleport"
islandLabel.TextColor3 = Color3.new(1, 1, 1)
islandLabel.BackgroundTransparency = 1
islandLabel.TextScaled = true
yPos += 25

local islandDropdown = Instance.new("TextButton", mainFrame)
islandDropdown.Position = UDim2.new(0, 10, 0, yPos)
islandDropdown.Size = UDim2.new(1, -20, 0, 30)
islandDropdown.Text = "Choose Island"
islandDropdown.TextColor3 = Color3.new(1, 1, 1)
islandDropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
islandDropdown.TextScaled = true

islandDropdown.MouseButton1Click:Connect(function()
    for _, island in pairs(islands) do
        local opt = Instance.new("TextButton", islandDropdown)
        opt.Size = UDim2.new(1, 0, 0, 25)
        opt.Position = UDim2.new(0, 0, 0, 30)
        opt.Text = island
        opt.TextScaled = true
        opt.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        opt.TextColor3 = Color3.new(1, 1, 1)
        opt.MouseButton1Click:Connect(function()
            getgenv().DinkzSettings.SelectedIsland = island
            islandDropdown.Text = island
            for _, child in pairs(islandDropdown:GetChildren()) do
                if child:IsA("TextButton") and child ~= islandDropdown then child:Destroy() end
            end
        end)
    end
end)

-- Toggle UI visibility
floatBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
