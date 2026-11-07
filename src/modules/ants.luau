local PathFindingService = game:GetService("PathfindingService")
local antModel = game:GetService("ReplicatedStorage"):WaitForChild("Ant")

local Ants = {}

function Ants.SpawnAnt(): Model
	local antSpawn = antModel:Clone()
	antSpawn.Parent = game.Workspace

	local newPosition = Vector3.new(-160, 3, math.random(-16, 16))
	antSpawn:MoveTo(newPosition)

	return antSpawn
end

function Ants.Pathfind(
	ant: Model,
	destination: Vector3
)
	local path = PathFindingService:CreatePath({
		AgentHeight = 10,
		AgentCanJump = false,
		AgentCanClimb = false,
		WaypointSpacing = 0.1
		
	})

	path:ComputeAsync(
		ant:GetPivot().Position,
		destination
	)

	local waypoints = path:GetWaypoints()

	for _, waypoint in waypoints do
		ant:MoveTo(waypoint.Position)
		ant:PivotTo(
			CFrame.new(
				ant.PrimaryPart.Position,
				destination
			)
		)
		task.wait()
	end

	ant:Destroy()
end

return Ants
