local Ants = require(script.Parent.Parent.modules.ants)

local destination = Vector3.new(-60.5, 3, 10)

Ants.Pathfind(Ants.SpawnAnt(), destination)
