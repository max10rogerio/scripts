/*
  Esse script vai excluir todas as tabelas do banco
  sem fazer o drop database
*/

USE yourdatabse


CREATE PROCEDURE DropAllTables
	AS
	-- Disable all referential integrity constraints
	EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
	GO

	-- Drop all PKs and FKs
	declare @sql nvarchar(max)
	SELECT @sql = STUFF((SELECT '; ' + 'ALTER TABLE ' + Table_Name  +'  drop constraint ' + Constraint_Name  from Information_Schema.CONSTRAINT_TABLE_USAGE ORDER BY Constraint_Name FOR XML PATH('')),1,1,'')
	EXECUTE (@sql)
	GO

	-- Drop all tables
	EXEC sp_MSforeachtable 'DROP TABLE ?'
	GO



/*
  Executando a procedure
*/
EXEC DropAllTables

