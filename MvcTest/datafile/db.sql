USE [Teacher]
GO

/****** Object:  Table [dbo].[StudentTag]    Script Date: 2014/6/3 0:06:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[StudentTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NULL,
	[TeacherId] [int] NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_StudentTag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


