-- modules/redeemcodes.lua

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local redeemEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Code")

local codes = {
    "kittgaming", "Sub2Fer999", "Enyu_is_Pro", "Magicbus",
    "JCWK", "Starcodeheo", "Bluxxy", "fudd10", "fudd10_v2",
    "BIGNEWS", "THEGREATACE", "TantaiGaming", "StrawHatMaine",
    "Sub2Daigrock", "Axiore", "Sub2OfficialNoobie", "SUB2NOOBMASTER123",
    "Sub2UncleKizaru", "Sub2CaptainMaui", "KittReset", "AdminTroll",
    "DRAGONABUSE", "REWARDFUN", "UPD17", "UPDATE10", "2BILLION", "GAMERROBOT_YT"
}

local function redeemAllCodes()
    if not getgenv().DinkzSettings.AutoRedeemCodes then return end

    for _, code in ipairs(codes) do
        pcall(function()
            redeemEvent:InvokeServer(code)
        end)
        task.wait(0.2)
    end
end

redeemAllCodes()
