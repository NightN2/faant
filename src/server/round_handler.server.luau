-- Round Handler: arranca la partida y lleva las rondas de Waves (25).
-- Estado que lee el HUD (atributos de ReplicatedStorage):
--   Round, TimeLeft, Hearts, MaxHearts (este último en Hearts) y GameResult ("Victory" / "Defeat") al terminar.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Waves = require(script.Waves)
local Mobs = require(script.Mobs)
local Hearts = require(script.Hearts)

local INITIAL_WAIT = 15         -- segundos de espera antes de la ronda 1
local ROUND_TIME = 120          -- segundos de cuenta atrás de cada ronda, una vez generadas todas sus hormigas
local CLEARED_TIME_MULT = 0.35  -- si se matan todas las hormigas, el tiempo restante baja a este % (-65%)...
local CLEARED_MIN_TIME = 10     -- ...sin pasar de este mínimo de segundos
local MAX_CONCURRENT_ANTS = 150 -- tope de hormigas vivas a la vez
local START_COINS = 10

local function setupPlayer(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"

	local coins = Instance.new("NumberValue")
	coins.Name = "Coins"
	coins.Value = START_COINS
	coins.Parent = leaderstats

	leaderstats.Parent = player
end

local function endGame(victory)
	ReplicatedStorage:SetAttribute("GameResult", victory and "Victory" or "Defeat")
	Mobs.Clear()
end

for _, player in Players:GetPlayers() do
	setupPlayer(player)
end
Players.PlayerAdded:Connect(setupPlayer)

ReplicatedStorage:SetAttribute("Round", 0)
for seconds = INITIAL_WAIT, 0, -1 do
	ReplicatedStorage:SetAttribute("TimeLeft", seconds)
	task.wait(1)
end

for round = 1, #Waves do
	ReplicatedStorage:SetAttribute("Round", round)

	-- Generar las hormigas de la ronda, una entrada tras otra.
	for _, entry in Waves[round] do
		local name, level, amount, spawnTime = table.unpack(entry)
		for _ = 1, amount do
			while Mobs.Count() >= MAX_CONCURRENT_ANTS do
				task.wait(0.25)
			end
			if not Hearts.State() then
				return endGame(false)
			end
			Mobs.new(name, level)
			task.wait(spawnTime)
		end
	end

	-- Cuenta atrás de la ronda.
	local timeLeft, cleared = ROUND_TIME, false
	while timeLeft >= 0 do
		if not Hearts.State() then
			return endGame(false)
		end
		if not cleared and Mobs.Count() == 0 then
			cleared = true
			timeLeft = math.max(math.floor(timeLeft * CLEARED_TIME_MULT), CLEARED_MIN_TIME)
		end
		ReplicatedStorage:SetAttribute("TimeLeft", timeLeft)
		timeLeft -= 1
		task.wait(1)
	end
end

endGame(Hearts.State())
