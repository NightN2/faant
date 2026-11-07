local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local DAMAGE = 5
local COOLDOWN = 0.5
local ANT_GROUP = "Ants"
local BOX_SIZE = Vector3.new(4, 5, 2)

local params = OverlapParams.new()
params.CollisionGroup = "PlayerSensor"

local lastHit: { [Player]: number } = {}

RunService.Heartbeat:Connect(function()
	local now = os.clock()

	for _, player in Players:GetPlayers() do
		local character = player.Character
		if not character then continue end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local root = character:FindFirstChild("HumanoidRootPart")
		if not humanoid or not root or humanoid.Health <= 0 then continue end

		if now - (lastHit[player] or 0) < COOLDOWN then continue end

		for _, part in workspace:GetPartBoundsInBox(root.CFrame, BOX_SIZE, params) do
			if part.CollisionGroup == ANT_GROUP then
				lastHit[player] = now
				humanoid:TakeDamage(DAMAGE)
				break
			end
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	lastHit[player] = nil
end)
