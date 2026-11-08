-- Hearts: vida de la casa. Cada hormiga que llega al objetivo le quita 1.
-- El HUD lee los atributos "Hearts" y "MaxHearts" de ReplicatedStorage.
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MAX_HEARTS = 10

ReplicatedStorage:SetAttribute("MaxHearts", MAX_HEARTS)
ReplicatedStorage:SetAttribute("Hearts", MAX_HEARTS)

local Hearts = {}

function Hearts.Damage()
	ReplicatedStorage:SetAttribute("Hearts", math.max(ReplicatedStorage:GetAttribute("Hearts") - 1, 0))
end

-- true mientras la casa siga en pie
function Hearts.State()
	return ReplicatedStorage:GetAttribute("Hearts") > 0
end

return Hearts
