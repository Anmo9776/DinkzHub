
-- modules/esp.lua

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local espFolder = Instance.new("Folder", Workspace)
espFolder.Name = "DinkzESP"

local function createBillboard(name, target, color)
    if not target:FindFirstChild("Head") then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "DinkzTag"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Adornee = target:FindFirstChild("Head")
    billboard.Parent = espFolder

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = color
    label.TextStrokeTransparency = 0
    label.Font = Enum.Font.SourceSansBold
    label.TextScaled = true

    return billboard
end

local function clearESP()
    for _, v in pairs(espFolder:GetChildren()) do
        if v:IsA("BillboardGui") then
            v:Destroy()
        end
    end
end

local function updateESP()
    clearESP()

    if getgenv().DinkzSettings.ESPEnemies then
        for _, v in pairs(Workspace:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and not Players:GetPlayerFromCharacter(v) then
                local name = string.format("%s | %d HP", v.Name, math.floor(v.Humanoid.Health))
                createBillboard(name, v, Color3.fromRGB(255, 0, 0))
            end
        end
    end

    if getgenv().DinkzSettings.ESPPlayers then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                createBillboard(player.Name, player.Character, Color3.fromRGB(0, 255, 255))
            end
        end
    end

    if getgenv().DinkzSettings.ESPFruits then
        for _, fruit in pairs(Workspace:GetChildren()) do
            if fruit:IsA("Tool") and fruit.Name:find("Fruit") then
                createBillboard(fruit.Name, fruit, Color3.fromRGB(255, 85, 255))
            end
        end
    end

    if getgenv().DinkzSettings.ESPBerries then
        for _, drop in pairs(Workspace:GetChildren()) do
            if drop:IsA("Part") and drop.Name:lower():find("berry") then
                createBillboard("Berries", drop, Color3.fromRGB(255, 255, 0))
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    if getgenv().DinkzSettings.ESPEnabled then
        updateESP()
    else
        clearESP()
    end
end)
