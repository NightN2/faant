-- Mobs: crea las hormigas (modelos de ServerStorage.ANTS), las lleva hasta la casa,
-- golpea a los jugadores cercanos y paga las monedas al morir.
local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

local Data = require(script.Data)
local Hearts = require(script.Parent.Hearts)

local MapMobs = workspace:WaitForChild("Map"):WaitForChild("Mobs")
local Container = MapMobs:WaitForChild("Container")
local Target = MapMobs:WaitForChild("Target") -- destino y zona donde la hormiga le quita 1 vida a la casa
local Spawns = MapMobs:WaitForChild("Spawns"):GetChildren()

local TICK = 0.25                      -- cada cuántos segundos decide una hormiga (moverse / golpear)
local CORPSE_TIME = 1.5                -- segundos que permanece el cuerpo tras morir
local FRONT_BOX = Vector3.new(5, 6, 7) -- zona de golpe delante de la hormiga (también golpea a quien esté encima)

-- Las hormigas no chocan entre sí (evita atascos en el camino).
pcall(PhysicsService.RegisterCollisionGroup, PhysicsService, "Ants")
PhysicsService:CollisionGroupSetCollidable("Ants", "Ants", false)

-- Los modelos de ANTS son solo visuales: se les añade un Humanoid y un tronco invisible (una vez, al cargar).
-- El modelo debe mirar hacia -Z.
local function buildTemplate(source)
	local model = source:Clone()
	local cf, size = model:GetBoundingBox()

	local parts = {}
	for _, descendant in model:GetDescendants() do
		if descendant:IsA("BasePart") then
			table.insert(parts, descendant)
		end
	end

	local root = Instance.new("Part")
	root.Name = "HumanoidRootPart"
	root.Size = Vector3.new(2, 2, 2)
	root.Transparency = 1
	root.CollisionGroup = "Ants"
	root.CFrame = cf
	root.Parent = model

	local head = Instance.new("Part") -- ancla del nombre y la barra de vida
	head.Name = "Head"
	head.Size = Vector3.one
	head.Transparency = 1
	head.CFrame = cf * CFrame.new(0, size.Y / 2, 0)
	head.Parent = model
	table.insert(parts, head)

	for _, part in parts do
		part.Anchored = false
		part.CanCollide = false
		part.Massless = true
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = root
		weld.Part1 = part
		weld.Parent = part
	end

	local humanoid = Instance.new("Humanoid")
	humanoid.HipHeight = size.Y / 2 - 1 -- el tronco (2 de alto) queda en el centro del modelo
	humanoid.RequiresNeck = false
	humanoid.BreakJointsOnDeath = false
	humanoid.AutomaticScalingEnabled = false
	humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOn
	humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
	humanoid.Parent = model

	model.PrimaryPart = root
	return model
end

local Templates = {}
local ants = ServerStorage:WaitForChild("ANTS")
for name in Data do
	local source = ants:FindFirstChild(name)
	if source then
		Templates[name] = buildTemplate(source)
	else
		warn(`[Mobs] Falta el modelo "{name}" en ServerStorage.ANTS`)
	end
end

local function reachedTarget(position)
	local relative = Target.CFrame:PointToObjectSpace(position)
	local half = Target.Size / 2
	return math.abs(relative.X) <= half.X and math.abs(relative.Y) <= half.Y and math.abs(relative.Z) <= half.Z
end

-- Posición del jugador vivo más cercano dentro de maxDistance (o nil).
local function nearestPlayerPosition(origin, maxDistance)
	local nearest, nearestDistance = nil, maxDistance
	for _, player in Players:GetPlayers() do
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if humanoid and humanoid.Health > 0 then
			local position = character:GetPivot().Position
			local distance = (position - origin).Magnitude
			if distance <= nearestDistance then
				nearest, nearestDistance = position, distance
			end
		end
	end
	return nearest
end

-- Daña a los jugadores que estén delante o encima de la hormiga.
local function attack(mob, damage)
	local characters = {}
	for _, player in Players:GetPlayers() do
		if player.Character then
			table.insert(characters, player.Character)
		end
	end
	local params = OverlapParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = characters

	local cf, size = mob:GetBoundingBox()
	local boxes = {
		{ cf * CFrame.new(0, 0, -(size.Z / 2 + FRONT_BOX.Z / 2)), FRONT_BOX },
		{ cf * CFrame.new(0, size.X / 1.5, 0), Vector3.new(size.X, 6, size.Z) },
	}

	local hit = {}
	for _, box in boxes do
		for _, part in workspace:GetPartBoundsInBox(box[1], box[2], params) do
			local character = part:FindFirstAncestorOfClass("Model")
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Health > 0 and not hit[humanoid] then
				hit[humanoid] = true
				humanoid:TakeDamage(damage)
			end
		end
	end
end

-- Monedas al killer (etiqueta "creator" del Humanoid); si no hay killer, se reparten entre todos.
local function payReward(humanoid, amount)
	local tag = humanoid:FindFirstChild("creator")
	local killer = tag and tag.Value
	local recipients = if typeof(killer) == "Instance" and killer:IsA("Player") then { killer } else Players:GetPlayers()
	for _, player in recipients do
		local leaderstats = player:FindFirstChild("leaderstats")
		local coins = leaderstats and leaderstats:FindFirstChild("Coins")
		if coins then
			coins.Value += amount / #recipients
		end
	end
end

local Mobs = {}

function Mobs.new(name, level)
	local data, template = Data[name], Templates[name]
	if not (data and template) then
		warn(`[Mobs] Hormiga desconocida: {name}`)
		return
	end

	local mob = template:Clone()
	local humanoid = mob.Humanoid
	local damage = data.Damage * level

	humanoid.MaxHealth = math.floor(data.BaseHealth * level)
	humanoid.Health = humanoid.MaxHealth
	humanoid.WalkSpeed = data.Speed
	humanoid.DisplayName = `{name} (Lvl {level})`

	-- Aparece en un punto al azar de un spawn, mirando hacia la casa.
	local spawn = Spawns[math.random(#Spawns)]
	local offset = CFrame.new((math.random() - 0.5) * spawn.Size.X, 0, (math.random() - 0.5) * spawn.Size.Z)
	local position = (spawn.CFrame * offset).Position + Vector3.new(0, humanoid.HipHeight + 2, 0)
	mob:PivotTo(CFrame.lookAt(position, Vector3.new(Target.Position.X, position.Y, Target.Position.Z)))
	mob.Parent = Container
	mob.PrimaryPart:SetNetworkOwner(nil)

	humanoid.Died:Connect(function()
		payReward(humanoid, data.Reward)
		task.delay(CORPSE_TIME, mob.Destroy, mob)
	end)

	task.spawn(function()
		local nextAttack = 0
		while mob.Parent and humanoid.Health > 0 do
			local position = mob:GetPivot().Position

			if reachedTarget(position) then
				Hearts.Damage()
				mob:Destroy()
				return
			end

			-- Persigue al jugador más cercano si puede; si no, va hacia la casa.
			local chase = data.CanAttack and data.FollowToAttack and nearestPlayerPosition(position, data.EngageDistance)
			humanoid:MoveTo(chase or Target.Position)

			if data.CanAttack and os.clock() >= nextAttack then
				nextAttack = os.clock() + data.AttackRate
				attack(mob, damage)
			end

			task.wait(TICK)
		end
	end)
end

function Mobs.Count()
	return #Container:GetChildren()
end

function Mobs.Clear()
	Container:ClearAllChildren()
end

return Mobs
