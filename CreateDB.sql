SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Users](
	[Nickname] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Nickname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Games](
	[Title_name] [nvarchar](100) NOT NULL,
	[Developer] [nvarchar](100) NOT NULL,
	[PC] [bit] DEFAULT 0 NOT NULL,
	[PS4] [bit] DEFAULT 0 NOT NULL,
	[Switch] [bit] DEFAULT 0 NOT NULL,
	[PC_Release] [date] NULL,
	[PS4_Release] [date] NULL,
	[Switch_Release] [date] NULL,
 CONSTRAINT [PK_Games] PRIMARY KEY CLUSTERED 
(
	[Title_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Reviews](
	Username nvarchar(50) DEFAULT N'Anonymous' NOT NULL,
	FOREIGN KEY (Username) REFERENCES Users (Nickname) ON DELETE SET DEFAULT, --for user account deleting logic
	Title nvarchar(100) NOT NULL,
	FOREIGN KEY (Title) REFERENCES Games(Title_name) ON DELETE CASCADE ON UPDATE CASCADE,
	Title_Platform nvarchar(10) NOT NULL,
	Rating int CHECK (Rating >= 0 AND Rating <= 10) NOT NULL, 
);