--Fills ESRB for games
UPDATE Game
   SET ESRB = CASE Title_name 
                      WHEN N'Subnautica: Below Zero' THEN 2
                      WHEN N'Subnautica' THEN 2 
					  WHEN N'Wacraft III The frozen throne' THEN 3 
					  WHEN N'Wacraft III Refunded' THEN 3 
					  WHEN N'Oxygen Not Included' THEN 6 
					  WHEN N'The Elder Scrolls V: Skyrim' THEN 4 
                      ELSE 6
                      END
 WHERE Title_name IN(N'Subnautica: Below Zero', N'Wacraft III The frozen throne', N'Wacraft III Refunded',
					 N'Subnautica', N'Oxygen Not Included', N'The Elder Scrolls V: Skyrim');
GO

INSERT Publisher (PublisherName) VALUES
(N'G.Review'),
(N'Cyber Oisters'),
(N'Honest Game Review');
GO

INSERT [User] (Nickname) VALUES
(N'Oister Bob'),
(N'Gloria Borger');
GO

INSERT Critic (Critic, Publisher) VALUES
(N'Pewdiepie', 1),
(N'Oister Bob', 2),
(N'Gloria Borger', 3);
GO

INSERT GameGenre (Game, Genre) VALUES
(N'Wacraft III The frozen throne', 2),
(N'Wacraft III The frozen throne', 3),
(N'Warcraft III Refunded', 2),
(N'Warcraft III Refunded', 3),
(N'Subnautica', 1),
(N'Subnautica: Below Zero', 1),
(N'Oxygen Not Included', 4), --let it be puzzle
(N'The Elder Scrolls V: Skyrim', 1),
(N'The Elder Scrolls V: Skyrim', 2);
GO

INSERT CriticReview (CriticID, Title, [Platform], Metascore) VALUES
(1, N'Subnautica', 1, 100),
(2, N'Oxygen Not Included', 1, 80),
(3, N'The Elder Scrolls V: Skyrim', 2, 75);
GO