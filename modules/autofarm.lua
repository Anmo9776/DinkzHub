-- modules/autofarm.lua

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local Utils = getgenv().DinkzUtils

local farmData = {
    [1] = {npc = "Bandit [Lv. 5]", quest = "BanditQuest1", island = "Starter Island"},
    [10] = {npc = "Monkey [Lv. 14]", quest = "JungleQuest", island = "Jungle"},
    [30] = {npc = "Gorilla [Lv. 20]", quest = "JungleQuest", island = "Jungle"},
    [40] = {npc = "Pirate [Lv. 35]", quest = "BuggyQuest1", island = "Pirate Village"},
    [60] = {npc = "Brute [Lv. 55]", quest = "BuggyQuest1", island = "Pirate Village"},
    [75] = {npc = "Desert Bandit [Lv. 60]", quest = "DesertQuest", island = "Desert"},
    [90] = {npc = "Desert Officer [Lv. 70]", quest = "DesertQuest", island = "Desert"},
    [100] = {npc = "Snow Bandit [Lv. 90]", quest = "SnowQuest", island = "Snow Island"},
    [120] = {npc = "Snowman [Lv. 100]", quest = "SnowQuest", island = "Snow Island"},
    [130] = {npc = "Chief Petty Officer [Lv. 120]", quest = "MarineQuest2", island = "Marine Fortress"},
    [150] = {npc = "Sky Bandit [Lv. 150]", quest = "SkyQuest", island = "Skylands"},
    [175] = {npc = "Dark Master [Lv. 175]", quest = "SkyQuest", island = "Skylands"},
    [190] = {npc = "Prisoner [Lv. 190]", quest = "PrisonerQuest", island = "Prison"},
    [210] = {npc = "Dangerous Prisoner [Lv. 210]", quest = "PrisonerQuest", island = "Prison"},
    [225] = {npc = "Toga Warrior [Lv. 250]", quest = "ColosseumQuest", island = "Colosseum"},
    [275] = {npc = "Gladiator [Lv. 275]", quest = "ColosseumQuest", island = "Colosseum"},
    [300] = {npc = "Military Soldier [Lv. 300]", quest = "MagmaQuest", island = "Magma Village"},
    [325] = {npc = "Military Spy [Lv. 325]", quest = "MagmaQuest", island = "Magma Village"},
    [350] = {npc = "Fishman Warrior [Lv. 375]", quest = "FishmanQuest", island = "Underwater City"},
    [400] = {npc = "Fishman Commando [Lv. 400]", quest = "FishmanQuest", island = "Underwater City"},
    [425] = {npc = "God's Guard [Lv. 450]", quest = "SkyExp1Quest", island = "Upper Skylands"},
    [475] = {npc = "Shanda [Lv. 475]", quest = "SkyExp1Quest", island = "Upper Skylands"},
    [500] = {npc = "Royal Squad [Lv. 525]", quest = "SkyExp2Quest", island = "Upper Skylands"},
    [550] = {npc = "Royal Soldier [Lv. 550]", quest = "SkyExp2Quest", island = "Upper Skylands"},
    [575] = {npc = "Galley Pirate [Lv. 625]", quest = "FountainQuest", island = "Fountain City"},
    [650] = {npc = "Galley Captain [Lv. 650]", quest = "FountainQuest", island = "Fountain City"},
    [700] = {npc = "Raider [Lv. 700]", quest = "Area1Quest", island = "Kingdom of Rose"},
    [725] = {npc = "Mercenary [Lv. 725]", quest = "Area1Quest", island = "Kingdom of Rose"},
    [775] = {npc = "Swan Pirate [Lv. 775]", quest = "Area2Quest", island = "Kingdom of Rose"},
    [800] = {npc = "Factory Staff [Lv. 800]", quest = "Area2Quest", island = "Kingdom of Rose"},
    [850] = {npc = "Marine Lieutenant [Lv. 875]", quest = "MarineQuest3", island = "Green Zone"},
    [875] = {npc = "Marine Captain [Lv. 900]", quest = "MarineQuest3", island = "Green Zone"},
    [925] = {npc = "Zombie [Lv. 950]", quest = "ZombieQuest", island = "Graveyard"},
    [950] = {npc = "Vampire [Lv. 975]", quest = "ZombieQuest", island = "Graveyard"},
    [975] = {npc = "Snow Trooper [Lv. 1000]", quest = "SnowMountainQuest", island = "Snow Mountain"},
    [1000] = {npc = "Winter Warrior [Lv. 1050]", quest = "SnowMountainQuest", island = "Snow Mountain"},
    [1050] = {npc = "Lab Subordinate [Lv. 1100]", quest = "IceSideQuest", island = "Hot and Cold"},
    [1100] = {npc = "Horned Warrior [Lv. 1125]", quest = "IceSideQuest", island = "Hot and Cold"},
    [1150] = {npc = "Magma Ninja [Lv. 1175]", quest = "FlameQuest", island = "Hot and Cold"},
    [1200] = {npc = "Lava Pirate [Lv. 1200]", quest = "FlameQuest", island = "Hot and Cold"},
    [1225] = {npc = "Ship Deckhand [Lv. 1250]", quest = "ShipQuest1", island = "Cursed Ship"},
    [1250] = {npc = "Ship Engineer [Lv. 1275]", quest = "ShipQuest1", island = "Cursed Ship"},
    [1300] = {npc = "Ship Steward [Lv. 1300]", quest = "ShipQuest2", island = "Cursed Ship"},
    [1325] = {npc = "Ship Officer [Lv. 1325]", quest = "ShipQuest2", island = "Cursed Ship"},
    [1350] = {npc = "Arctic Warrior [Lv. 1350]", quest = "FrostQuest", island = "Ice Castle"},
    [1375] = {npc = "Snow Lurker [Lv. 1375]", quest = "FrostQuest", island = "Ice Castle"},
    [1400] = {npc = "Sea Soldier [Lv. 1425]", quest = "ForgottenQuest", island = "Forgotten Island"},
    [1450] = {npc = "Water Fighter [Lv. 1450]", quest = "ForgottenQuest", island = "Forgotten Island"},
    [1500] = {npc = "Pirate Millionaire [Lv. 1500]", quest = "PiratePortQuest", island = "Pirate Port"},
    [1525] = {npc = "Pistol Billionaire [Lv. 1525]", quest = "PiratePortQuest", island = "Pirate Port"},
    [1575] = {npc = "Cake Guard [Lv. 1575]", quest = "CakeQuest1", island = "Cake Island"},
    [1600] = {npc = "Baking Staff [Lv. 1600]", quest = "CakeQuest1", island = "Cake Island"},
    [1650] = {npc = "Head Baker [Lv. 1650]", quest = "CakeQuest2", island = "Cake Island"},
    [1700] = {npc = "Cocoa Warrior [Lv. 1700]", quest = "ChocQuest1", island = "Chocolate Island"},
    [1725] = {npc = "Chocolate Bar Battler [Lv. 1725]", quest = "ChocQuest1", island = "Chocolate Island"},
    [1775] = {npc = "Sweet Thief [Lv. 1775]", quest = "ChocQuest2", island = "Chocolate Island"},
    [1800] = {npc = "Candy Rebel [Lv. 1800]", quest = "ChocQuest2", island = "Chocolate Island"},
    [1825] = {npc = "Candy Pirate [Lv. 1825]", quest = "CandyQuest1", island = "Candy Island"},
    [1875] = {npc = "Ice Cream Chef [Lv. 1875]", quest = "CandyQuest1", island = "Candy Island"},
    [1900] = {npc = "Sweet Crafter [Lv. 1900]", quest = "CandyQuest2", island = "Candy Island"},
    [1925] = {npc = "Cookie Crafter [Lv. 1925]", quest = "CandyQuest2", island = "Candy Island"},
    [1975] = {npc = "Cocoa Commander [Lv. 1975]", quest = "CocoaQuest", island = "Candy Island"},
    [2000] = {npc = "Candy Guard [Lv. 2000]", quest = "CandyQuest2", island = "Candy Island"},
    [2050] = {npc = "Chocolate Hunter [Lv. 2050]", quest = "CandyQuest2", island = "Candy Island"},
    [2100] = {npc = "Sweet Beast [Lv. 2100]", quest = "CandyQuest2", island = "Candy Island"},
    [2200] = {npc = "Island Emissary [Lv. 2200]", quest = "TikiQuest1", island = "Tiki Outpost"},
    [2250] = {npc = "Tiki Warrior [Lv. 2250]", quest = "TikiQuest1", island = "Tiki Outpost"},
    [2300] = {npc = "Masked Soldier [Lv. 2300]", quest = "TikiQuest2", island = "Tiki Outpost"},
    [2350] = {npc = "Elite Pirate [Lv. 2400]", quest = "EliteQuest", island = "Tiki Outpost"},
    [2500] = {npc = "Elite Crew [Lv. 2500]", quest = "EliteQuest", island = "Tiki Outpost"},
    [2600] = {npc = "Elite Pirate [Lv. 2600]", quest = "EliteQuest", island = "Tiki Outpost"}
}

-- Get farming target
local function getFarmTarget()
    local level = Utils.GetLevel()
    local selected
    for reqLevel, data in pairs(farmData) do
        if level >= reqLevel then
            selected = data
        end
    end
    return selected
end

-- Take quest
local function takeQuest(questName)
    pcall(function()
        local questNPCs = workspace:FindFirstChild("QuestBoards") or workspace:FindFirstChild("NPCs")
        if questNPCs then
            for _, npc in pairs(questNPCs:GetDescendants()) do
                if npc:IsA("Model") and npc:FindFirstChild("Head") and npc.Name:find(questName) then
                    Utils.FlyTo(npc.Head.Position + Vector3.new(0, 3, 0))
                    fireproximityprompt(npc:FindFirstChildWhichIsA("ProximityPrompt"))
                    task.wait(1)
                end
            end
        end
    end)
end

-- Attack enemy
local function attackTarget(enemy)
    local weapon = LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if weapon and LocalPlayer.Character:FindFirstChild("Humanoid") then
        weapon.Parent = LocalPlayer.Character
        for _ = 1, 5 do
            if not enemy or enemy.Humanoid.Health <= 0 then break end
            Remotes:FindFirstChild("Combat"):FireServer(enemy)
            task.wait(0.1)
        end
    end
end

-- Main loop
task.spawn(function()
    while task.wait(0.3) do
        if not getgenv().DinkzSettings.AutoFarm then continue end

        local target = getFarmTarget()
        if target then
            local enemy = Utils.GetNearestEnemy(target.npc)
            if enemy then
                Utils.FlyTo(enemy.HumanoidRootPart.Position + Vector3.new(0, 10, 0))
                if getgenv().DinkzSettings.AutoHaki then
                    local haki = LocalPlayer.Character:FindFirstChild("HasBuso")
                    if not haki then
                        Remotes:FindFirstChild("Buso"):FireServer()
                    end
                end
                if getgenv().DinkzSettings.FastAttack then
                    attackTarget(enemy)
                end
            else
                takeQuest(target.quest)
            end
        end
    end
end)
