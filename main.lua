-- main.lua
local repo = "https://raw.githubusercontent.com/YOUR_USERNAME/DinkzHub/main/"

local modules = {
    "ui/gui.lua",
    "modules/utils.lua",
    "modules/autofarm.lua",
    "modules/tp.lua",
    "modules/attack.lua",
    "modules/aura.lua",
    "modules/codes.lua",
    "modules/raids.lua",
    "modules/esp.lua"
}

for _, file in ipairs(modules) do
    local success, response = pcall(function()
        return game:HttpGet(repo .. file)
    end)

    if success then
        local loaded, err = loadstring(response)
        if loaded then
            task.spawn(loaded)
        else
            warn("Error loading module:", file, err)
        end
    else
        warn("Failed to fetch:", file)
    end
end
