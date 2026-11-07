local health = 10

local HouseHealth = {}

function HouseHealth.SetHealth(
    player: Player,
    value: number
)
    local healthLabel = player.PlayerGui.INGAME.TopHUD.Health
    local healthBar = player.PlayerGui.INGAME.TopHUD.HealthOn

    health = value
    healthLabel.Text = health
    healthBar.Size = UDim2.new(health * 0.03, 0, 0.29, 0)
end

function HouseHealth.GetHealth(): number
    return health
end

function HouseHealth.Modifyhealth(
    player: Player,
    increase: number
)
    local healthLabel = player.PlayerGui.INGAME.TopHUD.Health
    local healthBar = player.PlayerGui.INGAME.TopHUD.HealthOn

    health += increase
    healthLabel.Text = health
    healthBar.Size = UDim2.new(health * 0.03, 0, 0.29, 0)

end

return HouseHealth
