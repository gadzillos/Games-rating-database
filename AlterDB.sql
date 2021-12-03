
----Changes table's name to singular based on feedback recommendation
--EXEC sp_rename 'Reviews', 'Review';
--EXEC sp_rename 'Games', 'Game';
--EXEC sp_rename 'Users', 'User';
--GO

----Adds CHECK logic for game name
--ALTER TABLE Game
--ADD CONSTRAINT nameCheck CHECK ([Title_name] NOT LIKE N'%[^a-zA-Z0-9: ]%' AND LEN([Title_name]) >= 1);
--GO

----Changes value type to datetime2(7)
--ALTER TABLE Game 
--ALTER column PC_Release datetime2(7);

--ALTER TABLE Game 
--ALTER column PS4_Release datetime2(7);

--ALTER TABLE Game 
--ALTER column Switch_Release datetime2(7);
--GO

----Creates reference table for platform
--CREATE TABLE [dbo].[Platform](
--	[Id] [smallint] IDENTITY(1,1) PRIMARY KEY,
--	[PlatformName] [nvarchar](50) CHECK (LEN([PlatformName]) >= 1) NOT NULL UNIQUE
--);
--GO

----Adds platforms
--INSERT [Platform] (PlatformName) VALUES
--(N'PC'),
--(N'PS4'),
--(N'Switch');
--GO

----Creates empty PlatformGame table
--CREATE TABLE [dbo].[PlatformGame](
--[Id] [smallint] NOT NULL,
--FOREIGN KEY (Id) REFERENCES [Platform] (Id),
--[Game] [nvarchar](100) NOT NULL,
--FOREIGN KEY (Game) REFERENCES [Game] (Title_name),
--[Release] [datetime2] NOT NULL,
--PRIMARY KEY CLUSTERED 
--(
--	[Id] ASC,
--	[Game] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
--) ON [PRIMARY]
--GO

----adds foreign key for platform
--ALTER TABLE Review
--ADD [Platform] [smallint] NOT NULL DEFAULT 1;

--ALTER TABLE Review
--ADD FOREIGN KEY ([Platform]) REFERENCES [Platform] (Id);
--GO

----Assigns correct platform values
--UPDATE Review
--SET [Platform] = 2
--WHERE Title_Platform = N'PS4'; 

--UPDATE Review
--SET [Platform] = 3
--WHERE Title_Platform = N'Switch'; 
--GO

----Creates primary key for reviews to avoid multiple rating
--ALTER TABLE Review 
--ADD PRIMARY KEY (Username, Title, [Platform]);
--GO

----Adds time for reviews
--ALTER TABLE Review
--ADD [Date] [DateTime2](7) NOT NULL DEFAULT GETDATE() --CAST( GETDATE() AS Date ) could be used but time is useful for the timezones
--GO

----artificially adds review dates for old data
--UPDATE Review
--SET [Date] = '2007-11-11'
--WHERE Title = N'Wacraft III The frozen throne';
--UPDATE Review
--SET [Date] = '2017-12-12'
--WHERE Title = N'The Elder Scrolls V: Skyrim';
--UPDATE Review
--SET [Date] = '2020-02-16'
--WHERE Title = N'Warcraft III Refunded';
--UPDATE Review
--SET [Date] = '2019-12-20'
--WHERE Title = N'Oxygen Not Included';
--UPDATE Review
--SET [Date] = '2020-06-7'
--WHERE Title = N'Subnautica';
--UPDATE Review
--SET [Date] = '2021-02-12'
--WHERE Title = N'Subnautica: Below Zero';
--GO

----
--ALTER TABLE Review
--DROP COLUMN Title_Platform;
--GO

----Fills games platform and releases (not automated though)
--INSERT PlatformGame (Id, Game, Release) VALUES
--(1, N'Subnautica', '2014-12-16'),
--(2, N'Subnautica', '2018-12-04'),
--(3, N'Subnautica', '2021-05-14'),
--(1, N'Subnautica: Below Zero', '2021-05-14'),
--(2, N'Subnautica: Below Zero', '2021-05-14'),
--(3, N'Subnautica: Below Zero', '2021-05-14'),
--(1, N'Wacraft III The frozen throne', '2003-06-01'),
--(1, N'Warcraft III Refunded', '2020-01-28'),
--(1, N'Oxygen Not Included', '2019-06-30'),
--(1, N'The Elder Scrolls V: Skyrim', '2011-11-12'),
--(2, N'The Elder Scrolls V: Skyrim', '2016-08-28'),
--(3, N'The Elder Scrolls V: Skyrim', '2017-11-17');
--GO	

----drops redundant columns
--ALTER TABLE Game
--DROP CONSTRAINT DF__Games__PC__267ABA7A, COLUMN PC;
--ALTER TABLE Game
--DROP CONSTRAINT DF__Games__PS4__276EDEB3, COLUMN PS4;
--ALTER TABLE Game
--DROP CONSTRAINT DF__Games__Switch__286302EC, COLUMN Switch;

--ALTER TABLE Game
--DROP COLUMN PC_Release;
--ALTER TABLE Game
--DROP COLUMN PS4_Release;
--ALTER TABLE Game
--DROP COLUMN Switch_Release;
--GO

----Table with all genres
--CREATE TABLE [dbo].[Genre](
--[GenreId] [smallint] IDENTITY(1,1) PRIMARY KEY,
--[GenreName] [nvarchar](50) NOT NULL UNIQUE CHECK([GenreName] NOT LIKE N'%[^a-zA-Z0-9 ]%' AND LEN([GenreName]) >= 1),
--)
--INSERT Genre (GenreName) VALUES
--(N'Action'),
--(N'RPG'),
--(N'Strategy'),
--(N'Puzzle');
--GO

----Creates new table with multiple genres per game
--CREATE TABLE [dbo].[GameGenre](
--[Game] [nvarchar](100) FOREIGN KEY REFERENCES Game (Title_Name),
--[Genre] [smallint] FOREIGN KEY REFERENCES Genre (GenreId),
--PRIMARY KEY (Game, Genre)
--)
--GO

----
--CREATE TABLE [dbo].[ESRB](
--[ESRB_Id] [tinyint] IDENTITY(1,1) PRIMARY KEY,
--[ESRB_rating] [nvarchar](5) NOT NULL UNIQUE
--)

--INSERT ESRB (ESRB_rating) VALUES
--(N'E'),
--(N'E10+'),
--(N'T'),
--(N'M'),
--(N'AO'),
--(N'RP')
--GO

----
--ALTER TABLE Game
--ADD ESRB [tinyint] FOREIGN KEY REFERENCES ESRB (ESRB_Id) NOT NULL DEFAULT 1
--WITH VALUES
--GO

--CREATE TABLE [dbo].[Publisher](
--[PublisherID] [int] IDENTITY(1,1) PRIMARY KEY,
--[PublisherName] [nvarchar](100) NOT NULL UNIQUE
--)
--GO

----
--CREATE TABLE [dbo].[Critic](
--[CriticID] [int] IDENTITY(1,1) PRIMARY KEY,
--[Critic] [nvarchar](50) FOREIGN KEY REFERENCES [User] (Nickname),
--[Publisher] [int] FOREIGN KEY REFERENCES [Publisher] (PublisherID),
--CONSTRAINT Critic_Publisher UNIQUE (Critic, Publisher)
--)
--GO

--
--CREATE TABLE [dbo].[CriticReview](
--[CriticID] [int] FOREIGN KEY REFERENCES Critic (CriticID),
--[Title] [nvarchar](100) FOREIGN KEY REFERENCES Game (Title_name),
--[Platform] [smallint] FOREIGN KEY REFERENCES [Platform] (Id),
--[Metascore] [tinyint] CHECK ([Metascore] >= 0 AND [Metascore] <= 100) NOT NULL,
--[Date] [datetime2] (7) NOT NULL DEFAULT GETDATE(),
--CONSTRAINT [PK_CriticReview] PRIMARY KEY CLUSTERED 
--(
--	[CriticID] ASC,
--	[Title] ASC,
--	[Platform] ASC
--) ON [PRIMARY]
--)
--GO