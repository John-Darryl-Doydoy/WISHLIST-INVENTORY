﻿/*
Deployment script for SantaDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "SantaDB"
:setvar DefaultFilePrefix "SantaDB"
:setvar DefaultDataPath "C:\Users\John Darryl Doydoy\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\John Darryl Doydoy\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
The type for column FirstName in table [dbo].[Users] is currently  NVARCHAR (60) NOT NULL but is being changed to  NVARCHAR (50) NULL. Data loss could occur and deployment may fail if the column contains data that is incompatible with type  NVARCHAR (50) NULL.

The type for column LastName in table [dbo].[Users] is currently  NVARCHAR (60) NOT NULL but is being changed to  NVARCHAR (50) NULL. Data loss could occur and deployment may fail if the column contains data that is incompatible with type  NVARCHAR (50) NULL.
*/

IF EXISTS (select top 1 1 from [dbo].[Users])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Rename refactoring operation with key c7b29f8f-3e49-4af0-9089-63f54120f9f0 is skipped, element [dbo].[Item].[bran] (SqlSimpleColumn) will not be renamed to brand';


GO
PRINT N'Altering Table [dbo].[Users]...';


GO
ALTER TABLE [dbo].[Users] ALTER COLUMN [FirstName] NVARCHAR (50) NULL;

ALTER TABLE [dbo].[Users] ALTER COLUMN [LastName] NVARCHAR (50) NULL;

ALTER TABLE [dbo].[Users] ALTER COLUMN [Password] NVARCHAR (50) NULL;

ALTER TABLE [dbo].[Users] ALTER COLUMN [UserName] NVARCHAR (50) NULL;


GO
PRINT N'Creating Table [dbo].[Item]...';


GO
CREATE TABLE [dbo].[Item] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [name]     NVARCHAR (50) NOT NULL,
    [receiver] NVARCHAR (50) NOT NULL,
    [brand]    NVARCHAR (50) NOT NULL,
    [price]    INT           NOT NULL,
    [image]    NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
-- Refactoring step to update target server with deployed transaction logs
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c7b29f8f-3e49-4af0-9089-63f54120f9f0')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c7b29f8f-3e49-4af0-9089-63f54120f9f0')

GO

GO
PRINT N'Update complete.';


GO
