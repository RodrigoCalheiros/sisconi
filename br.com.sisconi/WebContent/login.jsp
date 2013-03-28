<%@ page language="java" contentType="text/html; charset=windows-1252"
    pageEncoding="windows-1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="inc_head.jsp"%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#nr_cpf").mask("999.999.999-99");
	});
</script>
<body>
<table width="100%">
<tr>
	<td align="center">	
		<table border="0" cellpadding="0" cellspacing="0" width="100%" style="min-width:996px;">
		<tr>
			<td>
				<img border="0" width="100px" height="98px" src="_imagens/logos/logo_sisconi.jpg">
			</td>
			<td valign="bottom" align="right">
				<form id="frm_login" action="" method="get">
				<table border="0" cellpadding="0" cellspacing="10">
					<tr>
						<td align="right" valign="middle">CPF:</td>
						<td align="left" valign="middle"><input type="text" id="nr_cpf" name="nr_cpf" onBlur="ValidarCPF(form.cpf);" maxlength="14" size="20" placeholder="Insira CPF aqui" required></td>
					</tr>
					<tr>
						<td align="right" valign="middle">Senha:</td>
						<td align="left" valign="middle"><input type="password" id="ds_senha" name="ds_senha" size="20" placeholder="Insira a senha aqui" required></td>
					</tr>
					<tr>
						<td align="right" valign="middle">Tipo:</td>
						<td align="left" valign="middle"><span id="sp_tipousuario">-</span></td>
					</tr>
					<tr>
						<td></td>
						<td align="right" valign="middle"><input type="submit" id="bt_entrar" name="bt_entrar" value="Entrar"></td>
					</tr>
				</table>
				</form>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<hr width="100%"/>
	</td>
</tr>
<tr>
	<td align="center">Bem Vindo ao Sistema de Controle de Internação do Hospital Universitário - SISCONI</td>
</tr>
<tr>
	<td align="center"><%@include file="inc_rodape.jsp"%></td>
</tr>
</table>
</body>
</html>