
local Players = game:GetService("Players")

local function addOutline(character)
	local highlight = Instance.new("Highlight")

	highlight.Name = "PlayerOutline"
	highlight.FillTransparency = 1
	highlight.OutlineTransparency = 0
	highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
	highlight.DepthMode = Enum.HighlightDepthMode.Occluded

	highlight.Parent = character
end

local function onPlayerAdded(player)
	player.CharacterAdded:Connect(addOutline)

	if player.Character then
		addOutline(player.Character)
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)

for _, player in ipairs(Players:GetPlayers()) do
	onPlayerAdded(player)
end
