-- ui/gui.lua

getgenv().DinkzSettings = {
    AutoFarm = true,
    AutoHaki = true,
    FastAttack = true,
    WeaponMastery = true,
    AutoRaid = false,
    ESP = true,
    AutoCodes = true
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Main ScreenGui
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "DinkzHubGUI"
screenGui.ResetOnSpawn = false

-- Floating Button
local floatBtn = Instance.new("TextButton", screenGui)
floatBtn.Size = UDim2.new(0, 100, 0, 40)
floatBtn.Position = UDim2.new(0, 10, 0.5, -20)
floatBtn.Text = "DinkzHub"
floatBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
floatBtn.TextColor3 = Color3.new(1, 1, 1)
floatBtn.BorderSizePixel = 0
floatBtn.Active = true
floatBtn.Draggable = true

-- Main Panel
local panel = Instance.new("Frame", screenGui)
panel.Size = UDim2.new(0, 220, 0, 300)
panel.Position = UDim2.new(0, 120, 0.5, -150)
panel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
panel.Visible = false

local uicorner = Instance.new("UICorner", panel)
uicorner.CornerRadius = UDim.new(0, 8)

-- Toggle Buttons
local toggles = {
    { "AutoFarm", "Auto Farm" },
    { "FastAttack", "Fast Attack" },
    { "AutoHaki", "Auto Aura" },
    { "WeaponMastery", "Mastery Farm" },
    { "AutoCodes", "Auto Codes" },
    { "AutoRaid", "Auto Raids" },
    { "ESP", "ESP" },
}

for i, data in ipairs(toggles) do
    local key, label = unpack(data)

    local toggleBtn = Instance.new("TextButton", panel)
    toggleBtn.Size = UDim2.new(0, 200, 0, 30)
    toggleBtn.Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 40)
    toggleBtn.Text = label .. ": ON"
    toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggleBtn.TextColor3 = Color3.new(1, 1, 1)
    toggleBtn.Name = key

    toggleBtn.MouseButton1Click:Connect(function()
        local current = getgenv().DinkzSettings[key]
        getgenv().DinkzSettings[key] = not current
        toggleBtn.Text = label .. ": " .. (getgenv().DinkzSettings[key] and "ON" or "OFF")
    end)
end

-- Show/Hide GUI Toggle
floatBtn.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)
