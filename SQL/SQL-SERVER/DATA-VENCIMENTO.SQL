/*--

  O script abaixo pega a data atual e adiciona mais 3 dias úteis.

--*/

SELECT 
  CASE
    WHEN DATEPART(WEEKDAY, GETDATE()) != 7 THEN
      IIF(DATEPART(WEEKDAY, GETDATE()) IN (1,2,3), DATEADD(DAY, 3, GETDATE()), DATEADD(DAY, 5, GETDATE()))
    ELSE
      DATEADD(DAY, 4, GETDATE())
  END AS VCTO
