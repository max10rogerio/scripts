<?
if (($_SERVER['REMOTE_ADDR'] == '177.125.218.146') || (substr($_SERVER['REMOTE_ADDR'],0,10) == '192.168.0.') || (substr($_SERVER['REMOTE_ADDR'],0,9) == '127.0.0.1'))  {
	$action = 'http://portal.unifamma.edu.br/PortalCorporeRm/Login.aspx?NewWindow=0';
} else {
	//$action = 'http://www2.unifamma.edu.br:8080/PortalCorporeRm/Login.aspx?NewWindow=0';
	$action = 'http://portal.unifamma.edu.br/PortalCorporeRm/Login.aspx?NewWindow=0';
}
?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<head>
	<title>Famma - Faculdade Metropolitana de Maringá</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<link href="/npd/cpa/css/bootstrap.min.css" rel="stylesheet" media="screen">
</head>
<body>
<div class="container">
	<div class="row-fluid">
		<div class="span10">
			</br></br>
			<img width="400px" src="img/portal-2.jpg">
			</br></br></br></br></br>
			<font style="font-size: 18px;">A Faculdade Metropolitana de Maringá apresenta o projeto "Inverno Solidário FAMMA”.
				Aceitamos doações de cobertores novos, a serem entregues às entidades assistenciais de Maringá.
				Você pode entregar  sua doação na Secretaria da Faculdade, até dia 20 de junho de 2017.</br>
				Cada doação equivalerá a 10 h de atividades, que podem ser validadas para o Programa FAMMA AÇÃO,
				Pró-bolsas ou como Atividade Acadêmica Complementar.</br></br>
				Atenção, alunos FAMMA AÇÃO!
			</font><br>
			<h3>
				</font>
				</br>
		</div>
	</div>
	<div>
	</div>
	<div class="span10">
		<form id="portal" method="post" action="<?=$action?>" >
			<input type="hidden" name="tbUser" value="<?= $_REQUEST['tbUser']?>"/>
			<input type="hidden" name="tbPass" value="<?= $_REQUEST['tbPass']?>"/>
			<input type="hidden" name="btEntrar" value="Entrar"/>
			<input type="hidden" name="testcookies" value="1" />
			<?php
			/*Atualizar este campo quando houver erro de _viewstate
            - O campo viewstate deve ser atualizado conforme página de login do RM;
            - Para isso basta acessar a URL de login:
                http://portal.famma.br/portalcorporerm/login.aspx
            - Abrir o modo debug e buscar em Form1 o campo hidden com name=__viewstate e
            o valor da chave atualizado;
            - Copiar e colar no campo abaixo.
            */
			?>
			<input type="hidden" name="__VIEWSTATE" value="dDw2MzE5NDY3MzI7Oz41gEf7vejbpzxyGrUTilEhGvH/0Q==" />
			<input style="width: 30px" outline: none; type="checkbox" name="vehicle" value="" required> <span style="font-size: 18px">Declaro que li todos os avisos importantes acima.</span></br></br>
			<input type="submit" class="btn btn-large btn-success pull-left" value="Prosseguir >"/>
		</form></br></br>
	</div></br>
</div>
<script src="/npd/cpa/js/jquery-1.7.2.min.js"></script>
<script src="/npd/cpa/js/bootstrap.min.js"></script>
</body>
</html>
