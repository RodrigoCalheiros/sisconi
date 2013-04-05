<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Estado, model.Paciente"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="paciente" class="model.Paciente"/>
<html>
<%@include file="inc_head.jsp"%>
<script>
var pMsg = <%=request.getParameter("msg")%>

function mostrarMsg(){
	if (pMsg != '' && pMsg != null){
		alert(pMsg);
	}
}	

function getPaciente(){
	$.ajax({
		url: "ajax_obter_paciente.jsp?nr_sus=" + $('#nr_sus').val(),
		}).done(function(retornoSucesso) {
			$('#span_dados_paciente').html(retornoSucesso);
	});	
}

function getExisteCpfPaciente(pCpf){
	if (pCpf!= ""){
		$.ajax({
			url: "ajax_existe_cpf_paciente.jsp?nr_cpf=" + pCpf,
			}).done(function(retornoSucesso) {
			var retorno = retornoSucesso;
			if (retorno == 1){
				alert("CPF " + pCpf + " já cadastrado.");
				$('#nr_cpf').focus();
			}
		});	
	}
}

function getCidades(){
	var codigoEstado = 	$('#co_estado').val();
	$.ajax({
	  url: "ajax_get_cidades.jsp?codigoEstado=" + codigoEstado,
	  context: document.body
	}).done(function(retornoSucesso) {
		$('#spanCidade').html(retornoSucesso);
	});	
}

function remover(pValor,caractere){  
	var texto = pValor;  
	var novo_texto='';  
	for(i = 0; i < texto.length; i++) 
	{
		if (texto.charAt(i) != caractere)
		{
			novo_texto += texto.charAt(i);  
		}
	}
	return novo_texto;
}

function validarCadastro(){
	var pNmPaciente = remover($('#nm_paciente').val(), ' ');
	if (pNmPaciente == ""){
		alert("O nome do Paciente deve ser preenchido.");
		$('#nm_paciente').val("");
		$('#nm_paciente').focus();
		return false;
	}
	var pNmMae = remover($('#nm_mae').val(), ' ');
	if (pNmMae == ""){
		alert("O nome da Mãe deve ser preenchido.");
		$('#nm_mae').val("");
		$('#nm_mae').focus();
		return false;
	}
	var pNrCpf = remover($('#nr_cpf').val(), ' ');
	if (pNrCpf == ""){
		$('#nr_cpf').val("");
	}
	else if (ValidarCPF($('#nr_cpf').val(), 'nr_cpf') == false){
		alert("O CPF " + $('#nr_cpf').val() + " é inválido.");
		$('#nr_cpf').focus();
		return false;
	}
	var pNrSus = remover($('#nr_sus').val(), ' ');
	if (pNrSus == ""){
		alert("O número do SUS deve ser preenchido.");
		$('#nr_sus').val("");
		$('#nr_sus').focus();
		return false;
	}
	var pDtNascimento = remover($("#datepicker").val(), ' ');
	if (pDtNascimento == ""){
		alert("A data Nascimento deve ser preenchida.");
		$('#datepicker').val("");
		$('#datepicker').focus();
		return false;
	}
	var pNrTelefone = remover($('#nr_telefone').val(), ' ');
	if (pNrTelefone == ""){
		$('#nr_telefone').val("");
	}
	var pDsRua = remover($('#ds_rua').val(), ' ');
	if (pDsRua == ""){
		alert("O nome da Rua deve ser preenchido.");
		$('#ds_rua').val("");
		$('#ds_rua').focus();
		return false;
	}
	var pDsNumero = remover($('#ds_numero').val(), ' ');
	if (pDsNumero == ""){
		alert("O número do Endereço deve ser preenchido.");
		$('#ds_numero').val("");
		$('#ds_numero').focus();
		return false;
	}
	var pDsComplemento = remover($('#ds_complemento').val(), ' ');
	if (pDsComplemento == ""){
		$('#ds_complemento').val("");
	}
	var pDsBairro = remover($('#ds_bairro').val(), ' ');
	if (pDsBairro == ""){
		alert("O nome do Bairro deve ser preenchido.");
		$('#ds_bairro').val("");
		$('#ds_bairro').focus();
		return false;
	}
	var pDsCep = remover($('#ds_cep').val(), ' ');
	if (pDsCep == ""){
		$('#ds_cep').val("");
	}
	if ($('#co_estado').val() == "0"){
		alert("O nome do Estado deve ser preenchido.");
		$('#co_estado').focus();
		return false;
	}
	if ($('#co_cidade').val() == ""){
		alert("O nome da cidade deve ser preenchido.");
		$('#co_cidade').focus();
		return false;
	}
	return true;
}

function salvarCadastro(){
	if (validarCadastro() == true){
		if (confirm("Você deseja cadastrar o paciente?")){
			document.forms['frm_paciente'].submit();	
		}	
	} 
}

function onBlurNrCpf(){
	ValidarCPF(document.getElementById('nr_cpf').value, 'nr_cpf');
	getExisteCpfPaciente(document.getElementById('nr_cpf').value);
}

function onBlurNrSus(){
	getExisteNrSusPaciente(document.getElementById('nr_sus').value);
}
</script>
<body onload="mostrarMsg()">
<table border="0" cellpadding="0" cellspacing="10" width="100%">
<tr>
	<td><%@include file="inc_titulo.jsp"%></td>
</tr>
<tr>
	<td>Localizar Paciente<hr>
		<table border="0" cellpadding="0" cellspacing="8" width="100%">
			<tr>
				<td align="right" width="40%">Número do SUS:</td>
				<td align="left" width="60%"><input type="text" id="nr_sus" name="nr_sus" maxlength="15" size="50" placeholder="Insira o número do SUS do paciente" onBlur="onBlurNrSus();" onKeyPress="mascaraInteiro();" required><input type="button" id="bt_localizar_paciente" name="bt_localizar_paciente" value="Localizar" onclick="getPaciente()"></td>
			</tr>			
		</table>
	</td>
</tr>
<tr>
	<td><input type="button" id="bt_dados_paciente" name="bt_dados_paciente" value="Dados do Paciente" onclick=""><input type="button" id="bt_atualizar_dados_paciente" name="bt_atualizar_dados_paciente" value="Atualizar Dados do Paciente" onclick=""><input type="button" id="bt_localizar_historico" name="bt_localizar_historico" value="Localizar Histórico" onclick=""></td>
</tr>
<tr>
	<td>
		<form id="frm_paciente" action="" method="post">
			<span id="span_dados_paciente"></span>
		</form>	
	</td>
</tr>
<tr>
	<td align="center"><%@include file="inc_rodape.jsp"%></td>
</tr>
</table>
</body>
</html>