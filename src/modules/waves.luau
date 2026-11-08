-- Waves: las 25 rondas de la partida.
-- Cada ronda es una lista de entradas {Tipo, Nivel, Cantidad, SpawnTime} que se generan en orden:
--   Tipo      = nombre de la hormiga (ver Mobs/Data y los modelos de ServerStorage.ANTS)
--   Nivel     = multiplicador de vida y de daño de esa hormiga
--   Cantidad  = cuántas hormigas se generan
--   SpawnTime = segundos entre una hormiga y la siguiente
-- El Round Handler recorre todas las rondas que existan: para alargar la partida basta con añadir [26] = {...}.
return {
	[1] = { {"Normal", 1, 1, 0.1} },
	[2] = { {"Tiny", 1, 1, 0.1}, {"Normal", 1, 2, 0.1} },
	[3] = { {"Tiny", 1, 2, 0.1}, {"Normal", 2, 3, 0.1} },
	[4] = { {"Tiny", 2, 4, 0.1}, {"Normal", 1, 2, 0.1}, {"Hidden", 1, 1, 0.1}, {"Metalized", 2, 1, 0.1} },
	[5] = { {"Tiny", 2, 8, 0.1}, {"Normal", 2, 8, 0.1}, {"Speedy", 1, 2, 0.1}, {"Metalized", 1, 1, 0.1}, {"Metalized", 2, 1, 0.1} },
	[6] = { {"Normal", 1, 7, 0.1}, {"Speedy", 2, 1, 0.1}, {"Slow", 2, 2, 0.1}, {"Skeleton", 1, 1, 0.1} },
	[7] = { {"Speedy", 2, 4, 0.1}, {"Slow", 1, 2, 0.1}, {"Metalized", 2, 3, 0.1} },
	[8] = { {"Normal", 2, 47, 0.1}, {"Normal", 3, 3, 0.1}, {"Metalized", 4, 1, 5} },
	[9] = { {"Normal", 1, 3, 0.1}, {"Normal", 2, 8, 0.1}, {"Normal", 3, 4, 0.1}, {"Speedy", 2, 1, 0.1}, {"Speedy", 3, 2, 0.1}, {"Slow", 2, 7, 0.1}, {"Metalized", 1, 2, 0.1}, {"Metalized", 4, 1, 0.1} },
	[10] = { {"Tiny", 1, 23, 0.1}, {"Normal", 2, 15, 0.1}, {"Normal", 4, 2, 0.1}, {"Speedy", 3, 3, 0.1}, {"Slow", 5, 1, 0.1}, {"Metalized", 2, 2, 0.1}, {"Metalized", 4, 4, 0.1}, {"Giant", 1, 1, 0.1} },
	[11] = { {"Normal", 1, 10, 0.1}, {"Normal", 2, 8, 0.1}, {"Normal", 9, 5, 0.1}, {"Slow", 4, 12, 0.1}, {"Slow", 25, 2, 0.1} },
	[12] = { {"Normal", 2, 23, 0.1}, {"Normal", 3, 6, 0.1} },
	[13] = { {"Normal", 4, 7, 0.1}, {"Hidden", 2, 9, 0.1}, {"Metalized", 4, 4, 0.1}, {"Metalized", 24, 2, 0.1}, {"Skeleton", 1, 3, 0.1}, {"Giant", 1, 1, 0.1} },
	[14] = { {"Tiny", 1, 12, 0.1}, {"Tiny", 3, 8, 0.1}, {"Tiny", 4, 20, 0.1}, {"Tiny", 5, 8, 0.1}, {"Speedy", 10, 4, 0.1}, {"Slow", 25, 9, 0.1}, {"Slow", 50, 2, 0.1}, {"Metalized", 15, 1, 0.1} },
	[15] = { {"Normal", 4, 14, 0.1}, {"Normal", 5, 5, 0.1}, {"Speedy", 9, 2, 0.1}, {"Hidden", 83, 6, 0.1}, {"Slow", 4, 20, 0.1}, {"Metalized", 8, 2, 0.1}, {"Metalized", 12, 2, 0.1}, {"Skeleton", 4, 2, 0.1}, {"Giant", 2, 1, 0.1} },
	[16] = { {"Tiny", 100, 1, 0.1}, {"Normal", 25, 1, 0.1}, {"Normal", 250, 1, 0.1} },
	[17] = { {"Tiny", 6, 70, 0.1}, {"Speedy", 9, 7, 0.1}, {"Speedy", 14, 2, 0.1}, {"Slow", 10, 7, 0.1}, {"Metalized", 12, 2, 0.1}, {"Metalized", 64, 2, 0.1} },
	[18] = { {"Tiny", 28, 15, 0.1}, {"Normal", 8, 35, 0.1}, {"Speedy", 1, 10, 0.1}, {"Speedy", 35, 3, 0.1}, {"Slow", 6, 10, 0.1}, {"Slow", 10, 13, 0.1}, {"Slow", 25, 45, 0.01}, {"Slow", 50, 7, 0.1}, {"Metalized", 8, 4, 0.1}, {"Metalized", 15, 18, 0.1}, {"Skeleton", 8, 1, 0.1}, {"Skeleton", 15, 5, 0.1} },
	[19] = { {"Tiny", 2, 15, 0.1}, {"Normal", 2, 80, 0.1}, {"Speedy", 50, 15, 0.1}, {"Hidden", 6, 13, 0.1}, {"Metalized", 16, 45, 0.1}, {"Skeleton", 4, 5, 0.1}, {"Giant", 2, 2, 0.1} },
	[20] = { {"Tiny", 45, 90, 0.08}, {"Normal", 9, 20, 0.1}, {"Normal", 150, 2, 0.1}, {"Hidden", 40, 10, 0.1}, {"Slow", 18, 3, 0.1}, {"Slow", 25, 13, 0.1}, {"Metalized", 12, 5, 0.1}, {"Skeleton", 4, 5, 0.1}, {"Giant", 1, 2, 3}, {"Giant", 3, 2, 0.1} },
	[21] = { {"Tiny", 9, 18, 0.1}, {"Tiny", 45, 37, 0.1}, {"Normal", 3, 20, 0.1}, {"Speedy", 10, 40, 0.1}, {"Speedy", 20, 4, 0.1}, {"Slow", 6, 20, 0.1}, {"Slow", 50, 3, 0.1}, {"Metalized", 36, 40, 0.1}, {"Metalized", 80, 30, 0.1}, {"Skeleton", 4, 1, 0.1} },
	[22] = { {"Tiny", 38, 3, 0.1}, {"Normal", 25, 100, 0.1}, {"Slow", 17, 25, 0.1}, {"Metalized", 12, 50, 0.2}, {"Metalized", 54, 40, 0.2}, {"Skeleton", 4, 1, 0.1}, {"Skeleton", 6, 1, 0.1} },
	[23] = { {"Tiny", 8, 20, 0.1}, {"Tiny", 9, 15, 0.1}, {"Tiny", 200, 5, 0.1}, {"Normal", 10, 96, 0.1}, {"Slow", 100, 1, 0.1}, {"Metalized", 12, 5, 0.1}, {"Metalized", 40, 20, 0.1}, {"Metalized", 60, 20, 0.1}, {"Skeleton", 4, 1, 0.1} },
	[24] = { {"Tiny", 63, 8, 0.1}, {"Speedy", 163, 1, 0.1}, {"Metalized", 76, 60, 0.2}, {"Metalized", 144, 5, 0.3}, {"Skeleton", 4, 1, 0.1}, {"Skeleton", 60, 1, 0.1} },
	[25] = { {"Tiny", 14, 54, 0.1}, {"Normal", 17, 45, 0.1}, {"Normal", 34, 3, 0.1}, {"Normal", 45, 130, 0.1}, {"Normal", 60, 25, 0.1}, {"Speedy", 30, 5, 0.1}, {"Speedy", 83, 1, 0.1}, {"Metalized", 12, 2, 0.1}, {"Metalized", 53, 7, 0.1}, {"Metalized", 88, 7, 0.1}, {"Metalized", 100, 10, 0.1}, {"Skeleton", 4, 85, 0.1}, {"Skeleton", 6, 2, 0.1}, {"Giant", 15, 1, 0.1} },
}
