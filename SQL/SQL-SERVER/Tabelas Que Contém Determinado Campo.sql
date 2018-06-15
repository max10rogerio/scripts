  SELECT 
  	    TABLE_NAME  AS 'Tabela',
        COLUMN_NAME AS 'Coluna'
   FROM 
        INFORMATION_SCHEMA.COLUMNS
   WHERE 
        COLUMN_NAME LIKE '%NOMEMAE%'
