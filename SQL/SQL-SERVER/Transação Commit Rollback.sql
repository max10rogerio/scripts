-- 01: Inicia transação
BEGIN TRANSACTION NOMEDATRANSACTION


-- 02: Altera registros
UPDATE FCFO
   SET EMAIL = 'marcos.minharo@unifamma.edu.br'
 WHERE PAGREC = 2


-- 03: Desfaz transação caso necessário
ROLLBACK TRANSACTION NOMEDATRANSACTION;

-- 04: Confirma transação
COMMIT TRANSACTION NOMEDATRASACTION
