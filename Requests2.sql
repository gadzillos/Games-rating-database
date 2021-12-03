--1
SELECT Title_name, Genre, Id AS PlatformId FROM Game g
INNER JOIN  GameGenre
ON (
	GameGenre.Game = g.Title_name
	)
INNER JOIN  PlatformGame
ON (
	PlatformGame.Game = g.Title_name 
	)
WHERE (GameGenre.Genre = 1 OR GameGenre.Genre = 2) AND (PlatformGame.Id = 2 OR PlatformGame.Id = 4) AND (Title_Name LIKE N'%ro%');
GO

--2
SELECT  PlatformName, ESRB_rating, COUNT(Title_name) AS totalGames FROM Game g
INNER JOIN PlatformGame pg
ON g.Title_name = pg.Game
INNER JOIN [Platform] p
ON p.Id = pg.Id
INNER JOIN ESRB e
ON e.ESRB_Id = g.ESRB
GROUP BY PlatformName, ESRB_rating;
GO

--3
DECLARE @numberOfGames AS INT = 2;
SELECT TOP (CAST(@numberOfGames AS INT)) Title_name, GenreName FROM Game g
INNER JOIN PlatformGame pg
ON g.Title_name = pg.Game
INNER JOIN [Platform] p
ON p.Id = pg.Id
INNER JOIN Review r
ON r.Title = g.Title_name
INNER JOIN GameGenre gg
ON gg.Game = g.Title_name
INNER JOIN Genre
ON Genre.GenreId = gg.Genre
WHERE GenreName = N'RPG'
GROUP BY Title_name, GenreName
ORDER BY COUNT(Rating) ASC
GO

--4 Wrong query 
SELECT PlatformName AS [Platform], GenreName AS Genre, Title_name AS BestGame FROM Game g
INNER JOIN PlatformGame pg
ON g.Title_name = pg.Game
INNER JOIN [Platform] p
ON p.Id = pg.Id
INNER JOIN Review r
ON r.Title = g.Title_name
INNER JOIN GameGenre gg
ON gg.Game = g.Title_name
INNER JOIN Genre
ON Genre.GenreId = gg.Genre
GROUP BY PlatformName, GenreName, Title_name;


