

/*-- Retorna os alunos do cursos com total de 8 períodos --*/
SELECT 
	NE.RA,
	P.NOME 'Nome Aluno',
	CAST((SUM(NE.NOTAFALTA) / COUNT(NE.RA)) AS NUMERIC(10,2)) 'Média Global',
	C.NOME 'Nome do Curso'
FROM 
	SMATRICPL MP (NOLOCK)
	INNER JOIN SMATRICULA M (NOLOCK) ON M.RA =  MP.RA AND M.IDHABILITACAOFILIAL = MP.IDHABILITACAOFILIAL
	INNER JOIN SNOTAETAPA NE (NOLOCK) ON NE.CODCOLIGADA = M.CODCOLIGADA AND NE.RA = M.RA
		AND NE.IDTURMADISC = M.IDTURMADISC
	INNER JOIN SHABILITACAOFILIAL HF (NOLOCK) ON HF.IDHABILITACAOFILIAL IN (SELECT IDHABILITACAOFILIAL FROM SMATRICPL (NOLOCK) WHERE IDPERLET = (SELECT IDPERLET FROM SPLETIVO WHERE CODPERLET = :PERIODO_LETIVO) AND RA = MP.RA AND PERIODO = 8)
	INNER JOIN SCURSO C (NOLOCK) ON C.CODCURSO = HF.CODCURSO AND C.CODCURSO NOT IN (7,9)
	INNER JOIN SALUNO A (NOLOCK) ON A.RA = MP.RA
	INNER JOIN PPESSOA P (NOLOCK) ON P.CODIGO = A.CODPESSOA
WHERE
	M.CODSTATUS IN (11,22)
	AND NE.CODETAPA = 0
	AND NE.TIPOETAPA = 'N'
	AND MP.RA IN (
		SELECT 
			MP.RA
		FROM 
			SMATRICPL MP (NOLOCK)
			INNER JOIN SHABILITACAOFILIAL HF (NOLOCK) ON HF.IDHABILITACAOFILIAL = MP.IDHABILITACAOFILIAL
				AND HF.CODCOLIGADA = MP.CODCOLIGADA
		WHERE
			MP.IDPERLET = (SELECT IDPERLET FROM SPLETIVO WHERE CODPERLET = :PERIODO_LETIVO)
			AND MP.PERIODO = 8
			AND HF.CODCURSO IN (
					SELECT DISTINCT
						C.CODCURSO
					FROM 
						SCURSO C (NOLOCK)
						INNER JOIN SPERIODO P (NOLOCK) ON P.CODCOLIGADA = C.CODCOLIGADA AND P.CODCURSO = C.CODCURSO
							AND P.CODPERIODO = 8
					WHERE
						C.CODMODALIDADECURSO = 1
						AND C.CURPRESDIST = 'P'
						AND C.CODCURSO NOT IN (7,9, 25)
			)
	)
	AND MP.IDHABILITACAOFILIAL IN (
		SELECT IDHABILITACAOFILIAL FROM SMATRICPL WHERE IDPERLET IN (SELECT IDPERLET FROM SPLETIVO WHERE CODPERLET LIKE 'G%')
			AND RA = MP.RA
	)
GROUP BY 
	NE.RA, P.NOME, C.NOME

UNION

/*-- Retorna os alunos do cursos com total de 10 períodos --*/
SELECT 
	NE.RA,
	P.NOME 'Nome Aluno',
	CAST((SUM(NE.NOTAFALTA) / COUNT(NE.RA)) AS NUMERIC(10,2)) 'Média Global',
	C.NOME 'Nome do Curso'
FROM 
	SMATRICPL MP (NOLOCK)
	INNER JOIN SMATRICULA M (NOLOCK) ON M.RA =  MP.RA AND M.IDHABILITACAOFILIAL = MP.IDHABILITACAOFILIAL
	INNER JOIN SNOTAETAPA NE (NOLOCK) ON NE.CODCOLIGADA = M.CODCOLIGADA AND NE.RA = M.RA
		AND NE.IDTURMADISC = M.IDTURMADISC
	INNER JOIN SHABILITACAOFILIAL HF (NOLOCK) ON HF.IDHABILITACAOFILIAL IN (SELECT IDHABILITACAOFILIAL FROM SMATRICPL (NOLOCK) WHERE IDPERLET = (SELECT IDPERLET FROM SPLETIVO WHERE CODPERLET = :PERIODO_LETIVO) AND RA = MP.RA AND PERIODO = 10)
	INNER JOIN SCURSO C (NOLOCK) ON C.CODCURSO = HF.CODCURSO
	INNER JOIN SALUNO A (NOLOCK) ON A.RA = MP.RA
	INNER JOIN PPESSOA P (NOLOCK) ON P.CODIGO = A.CODPESSOA
WHERE
	M.CODSTATUS IN (11,22)
	AND NE.CODETAPA = 0
	AND NE.TIPOETAPA = 'N'
	AND MP.RA IN (
		SELECT 
			MP.RA
		FROM 
			SMATRICPL MP (NOLOCK)
			INNER JOIN SHABILITACAOFILIAL HF (NOLOCK) ON HF.IDHABILITACAOFILIAL = MP.IDHABILITACAOFILIAL
				AND HF.CODCOLIGADA = MP.CODCOLIGADA
		WHERE
			MP.IDPERLET = (SELECT IDPERLET FROM SPLETIVO WHERE CODPERLET = :PERIODO_LETIVO)
			AND MP.PERIODO = 10
	)
	AND MP.IDHABILITACAOFILIAL IN (
		SELECT IDHABILITACAOFILIAL FROM SMATRICPL WHERE IDPERLET IN (SELECT IDPERLET FROM SPLETIVO WHERE CODPERLET LIKE 'G%')
			AND RA = MP.RA
	)
GROUP BY 
	NE.RA, P.NOME, C.NOME
ORDER BY C.NOME ASC, 'Média Global' DESC
