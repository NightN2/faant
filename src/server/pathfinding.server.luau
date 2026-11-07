local Ants = require(script.Parent.Parent.modules.ants)
local HouseHealth = require(script.Parent.Parent.modules.house_health)

local destination = Vector3.new(-50.5, 8, 9.5)

Ants.Pathfind(Ants.SpawnAnt(), destination)

local players: Players = game:GetService("Players"):GetPlayers()

for _, player in pairs(players) do
    HouseHealth.Modifyhealth(
        player,
        -1
    )
end
