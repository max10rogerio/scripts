-- 01: Inicia transa��o
BEGIN TRANSACTION NOMEDATRANSACTION


-- 02: Altera registros
UPDATE FCFO
   SET EMAIL = 'marcos.minharo@unifamma.edu.br'
 WHERE PAGREC = 2


-- 03: Desfaz transa��o caso necess�rio
ROLLBACK TRANSACTION NOMEDATRANSACTION;

-- 04: Confirma transa��o
COMMIT TRANSACTION NOMEDATRASACTION
