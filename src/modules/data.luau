-- Estadísticas base de cada hormiga. El nombre debe coincidir con el modelo de ServerStorage.ANTS.
--   BaseHealth / Damage  se multiplican por el Nivel definido en Waves
--   Reward               monedas que da al morir (no depende del Nivel)
--   CanAttack            golpea a los jugadores cercanos cada AttackRate segundos
--   FollowToAttack       persigue al jugador más cercano si está a menos de EngageDistance
--
-- Sustituyen a las 40 hormigas antiguas de las rondas 1-25:
--   Tiny       Small, Blue, Red, Water, Green
--   Normal     Ant, Elegant, Cheese, Chocolate, Pancake, Cookie, Food, Drink, Ice Cream, Flower
--   Speedy     Speedy, Super Speed, Rainbow, CorroredMetal
--   Hidden     Invisible, Camouflage
--   Slow       Plant, Toxic, Shield, Cake, Scarlet
--   Metalized  Metal, Soldier, Invincible, Paper, Obby, Super, Fighter
--   Skeleton   Bullet, Fire, Ring Ring, Little Queen
--   Giant      Giant Metal, Neapolitan Ice Cream, Queen
return {
	Tiny      = { BaseHealth = 6,   Speed = 11, Damage = 2,  AttackRate = 0.6, Reward = 6,   CanAttack = true,  FollowToAttack = true,  EngageDistance = 20 },
	Normal    = { BaseHealth = 10,  Speed = 11, Damage = 2,  AttackRate = 1,   Reward = 11,  CanAttack = true,  FollowToAttack = true,  EngageDistance = 20 },
	Speedy    = { BaseHealth = 3,   Speed = 25, Damage = 1,  AttackRate = 1,   Reward = 17,  CanAttack = true,  FollowToAttack = false, EngageDistance = 10 },
	Hidden    = { BaseHealth = 3,   Speed = 13, Damage = 1,  AttackRate = 2,   Reward = 8,   CanAttack = false, FollowToAttack = false, EngageDistance = 15 },
	Slow      = { BaseHealth = 20,  Speed = 5,  Damage = 1,  AttackRate = 0.5, Reward = 10,  CanAttack = true,  FollowToAttack = true,  EngageDistance = 10 },
	Metalized = { BaseHealth = 25,  Speed = 10, Damage = 2,  AttackRate = 1.5, Reward = 28,  CanAttack = true,  FollowToAttack = true,  EngageDistance = 25 },
	Skeleton  = { BaseHealth = 50,  Speed = 20, Damage = 40, AttackRate = 3,   Reward = 100, CanAttack = true,  FollowToAttack = true,  EngageDistance = 80 },
	Giant     = { BaseHealth = 650, Speed = 8,  Damage = 10, AttackRate = 1,   Reward = 230, CanAttack = true,  FollowToAttack = true,  EngageDistance = 40 },
}
