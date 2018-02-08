
/*--


Relat�rio de notas e faltas para professores

Campos chaves da tabela STURMADISC(CODCOLIGADA, IDTURMADISC)

--*/


/*--  Criar fun��o para retorna nota e falta  --*/

/*-- 
	Fun��o ir� retorna a nota do aluno 
	parametros:
		 - IDTURMADISC -> tipo: inteiro
		 - CODETAPA	   -> tipo: inteiro
		 - RA		   -> tipo: inteiro	
--*/
ALTER FUNCTION RetornaNotaAluno(

	@IDTURMADISC INT,
	@CODETAPA    INT,
	@RA			 INT

) RETURNS NUMERIC(10,1)
BEGIN
	
	DECLARE @NOTA NUMERIC(10,1)

	SET @NOTA = ( SELECT 
					CAST(NOTAFALTA AS NUMERIC(10,1)) AS NOTA 
				  FROM 
					SNOTAETAPA (NOLOCK)
				  WHERE 
					IDTURMADISC = @IDTURMADISC 
					AND CODETAPA = @CODETAPA 
					AND TIPOETAPA = 'N' 
					AND RA = @RA
				)
	RETURN @NOTA
END


/*-- 
	Fun��o ir� retorna a nota do aluno 
	parametros:
		 - IDTURMADISC -> tipo: inteiro
		 - CODETAPA	   -> tipo: inteiro
		 - RA		   -> tipo: inteiro	
--*/
ALTER FUNCTION RetornaFaltaAluno(

	@IDTURMADISC INT,
	@CODETAPA    INT,
	@RA			 INT

) RETURNS NUMERIC(10,0)
BEGIN
	
	DECLARE @FALTA NUMERIC(10,0)

	SET @FALTA = ( SELECT 
					CAST(NOTAFALTA AS NUMERIC(10,0)) AS NOTA 
				  FROM 
					SNOTAETAPA (NOLOCK)
				  WHERE 
					IDTURMADISC = @IDTURMADISC 
					AND CODETAPA = @CODETAPA 
					AND TIPOETAPA = 'F' 
					AND RA = @RA
				)
	RETURN @FALTA
END


/*-- CABE�ALHO --*/
SELECT 
	TD.IDTURMADISC,
	TD.CODTURMA 'C�digo da Turma',
	PL.CODPERLET 'C�digo Per�odo Letivo',
	PT.CODPROF 'C�digo Professor',
	P.NOME 'Nome do Professor',
	C.NOME 'Nome do Curso',
	T.NOME 'Turno',
	H.NOME 'Habilita��o'
FROM 
	STURMADISC TD (NOLOCK)
	INNER JOIN SPROFESSORTURMA PT (NOLOCK) ON PT.IDTURMADISC = TD.IDTURMADISC
	INNER JOIN SPLETIVO PL (NOLOCK) ON PL.IDPERLET = TD.IDPERLET
	INNER JOIN SPROFESSOR SP (NOLOCK) ON SP.CODPROF = PT.CODPROF
	INNER JOIN PPESSOA P (NOLOCK) ON P.CODIGO = SP.CODPESSOA
	INNER JOIN SHABILITACAOFILIAL HF (NOLOCK) ON HF.IDHABILITACAOFILIAL = TD.IDHABILITACAOFILIAL
	INNER JOIN SCURSO C (NOLOCK) ON C.CODCURSO = HF.CODCURSO
	INNER JOIN STURNO T (NOLOCK) ON T.CODTURNO = HF.CODTURNO
	INNER JOIN SHABILITACAO H (NOLOCK) ON H.CODCURSO = HF.CODCURSO AND H.CODHABILITACAO = HF.CODHABILITACAO
WHERE
	TD.CODCOLIGADA = 1 /*:CODCOLIGADA*/
	/*AND TD.IDTURMADISC = :IDTURMADISC*/
	AND TD.IDPERLET = 41
	AND TD.IDTURMADISC = 9734



SELECT * FROM STURMADISC WHERE IDTURMADISC = '8860'
--GDIR02004 --GDIR01NA
/* Notas dos alunos */
SELECT
	A.RA 'RA',
	P.NOME 'Nome do Aluno',
	dbo.RetornaNotaAluno(M.IDTURMADISC, 1, M.RA)  '1� Bim. - Nota',
	dbo.RetornaNotaAluno(M.IDTURMADISC, 2, M.RA)  '1� Bim - 2� Chamada',
	dbo.RetornaFaltaAluno(M.IDTURMADISC, 1, M.RA) '1� Bim. - Faltas',
	dbo.RetornaNotaAluno(M.IDTURMADISC, 4, M.RA)  '2� Bim - Nota',
	dbo.RetornaNotaAluno(M.IDTURMADISC, 5, M.RA)  '2� Bim - 2� Chamada',
	dbo.RetornaFaltaAluno(M.IDTURMADISC, 4, M.RA) '2� Bim - Falta',
	dbo.RetornaNotaAluno(M.IDTURMADISC, 8, M.RA)  'Exame',
	dbo.RetornaNotaAluno(M.IDTURMADISC, 0, M.RA)  'M�dia de Notas',
	dbo.RetornaFaltaAluno(M.IDTURMADISC, 0, M.RA) 'M�dia de Faltas'  
FROM
	SMATRICULA M (NOLOCK)
	INNER JOIN SALUNO A (NOLOCK) ON A.RA = M.RA
	INNER JOIN PPESSOA P (NOLOCK) ON P.CODIGO = A.CODPESSOA
WHERE 
	M.IDTURMADISC = 8860



