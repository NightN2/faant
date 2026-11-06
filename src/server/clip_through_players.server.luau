local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

PhysicsService:RegisterCollisionGroup("Players")
PhysicsService:RegisterCollisionGroup("Ants")
PhysicsService:CollisionGroupSetCollidable("Players", "Ants", false)

local function OnCharacterAdded(character: Model)
    for _, part in character:GetDescendants() do
        if part:IsA("BasePart") then
            part.CollisionGroup = "Players"
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(OnCharacterAdded)
end)
