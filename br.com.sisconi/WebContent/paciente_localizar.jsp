<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Estado, model.Paciente"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="paciente" class="model.Paciente"/>
<html>
<%@include file="inc_head.jsp"%>
<script>

var pMsg = <%=request.getParameter("msg")%>
var pNrSus = <%=request.getParameter("nr_sus")%>

$(function(){
	if (pNrSus != '' && pNrSus != null){
		$("#nr_localizar_sus").val(pNrSus);
		obterDadosPaciente();
	}
});

function mostrarMsg(){
	if (pMsg != '' && pMsg != null){
		alert(pMsg);
	}
}	

function getPaciente(){
	$.ajax({
		url: "ajax_obter_paciente.jsp?nr_sus=" + $('#nr_localizar_sus').val(),
		}).done(function(retornoSucesso) {
			if (retornoSucesso != 0){
				$('#span_dados_paciente').html(retornoSucesso);
				$('#span_botoes_localizar_paciente').show();
				$('#span_bt_salvar').show();
			}else{
				$('#span_dados_paciente').html("");
				$('#span_botoes_localizar_paciente').slideUp();
				alert("Paciente n�o cadastrado.");
			}
	});	
}

function getPacienteBloqueandoCampos(){
	$.ajax({
		url: "ajax_obter_paciente.jsp?nr_sus=" + $('#nr_localizar_sus').val(),
		}).done(function(retornoSucesso) {
			if (retornoSucesso != 0){
				$('#span_dados_paciente').html(retornoSucesso);
				$('#span_botoes_localizar_paciente').show();
				desabilitarCamposPaciente();
				$('#span_bt_salvar').slideUp();
			}else{
				$('#span_dados_paciente').html("");
				$('#span_botoes_localizar_paciente').slideUp();
				alert("Paciente n�o cadastrado.");
			}
	});	
}

function obterDadosPaciente(){
	getPacienteBloqueandoCampos();
}

function obterDadosPacienteAtualizar(){
	getPaciente();
}

function desabilitarCamposPaciente(){
	$('#nm_paciente').attr("disabled", true);
	$('#nm_mae').attr("disabled", true);
	$('#nr_cpf').attr("disabled", true);
	$('#nr_sus').attr("disabled", true);
	$('#nr_telefone').attr("disabled", true);
	$('#datepicker').attr("disabled", true);
	$('#ds_rua').attr("disabled", true);
	$('#ds_numero').attr("disabled", true);
	$('#ds_complemento').attr("disabled", true);
	$('#ds_bairro').attr("disabled", true);
	$('#ds_cep').attr("disabled", true);
	$('#co_estado').attr("disabled", true);
}

function getExisteCpfPaciente(pCpf){
	if (pCpf!= ""){
		$.ajax({
			url: "ajax_existe_cpf_paciente.jsp?nr_cpf=" + pCpf,
			}).done(function(retornoSucesso) {
			var retorno = retornoSucesso;
			if (retorno == 1){
				alert("CPF " + pCpf + " j� cadastrado.");
				$('#nr_cpf').focus();
			}
		});	
	}
}

function getExisteNrSusPaciente(pNrSus){
	if (pNrSus != ""){
		$.ajax({
			url: "ajax_existe_numero_sus_paciente.jsp?nr_sus=" + pNrSus,
			}).done(function(retornoSucesso) {
			var retorno = retornoSucesso;
			if (retorno == 1){
				alert("N�mero do SUS " + pNrSus + " j� cadastrado.");
				$('#nr_sus').focus();
			}
		});	
	}
}

function getCidades(){
	var codigoEstado = 	$('#co_estado').val();
	$.ajax({
	  url: "ajax_obter_cidades.jsp?codigoEstado=" + codigoEstado,
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
		alert("O nome da M�e deve ser preenchido.");
		$('#nm_mae').val("");
		$('#nm_mae').focus();
		return false;
	}
	var pNrCpf = remover($('#nr_cpf').val(), ' ');
	if (pNrCpf == ""){
		$('#nr_cpf').val("");
	}
	else if (ValidarCPF($('#nr_cpf').val(), 'nr_cpf') == false){
		alert("O CPF " + $('#nr_cpf').val() + " � inv�lido.");
		$('#nr_cpf').focus();
		return false;
	}
	var pNrSus = remover($('#nr_sus').val(), ' ');
	if (pNrSus == ""){
		alert("O n�mero do SUS deve ser preenchido.");
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
		alert("O n�mero do Endere�o deve ser preenchido.");
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
	if ($('#co_cidade').val() != null){
		$('#hidden_co_cidade').val($('#co_cidade').val());
	}
	return true;
}

function salvarCadastro(){
	if (validarCadastro() == true){
		if (confirm("Voc� deseja atualizar os dados do paciente?")){
			document.forms['frm_paciente'].submit();	
		}	
	} 
}

function onBlurNrCpf(){
	if ($('#hidden_nr_cpf').val() != $('#nr_cpf').val()){
		ValidarCPF(document.getElementById('nr_cpf').value, 'nr_cpf');
		getExisteCpfPaciente(document.getElementById('nr_cpf').value);
	}
}

function onBlurNrSus(){
	if ($('#hidden_nr_sus').val() != $('#nr_sus').val()){
		getExisteNrSusPaciente(document.getElementById('nr_sus').value);
	}
}
</script>
<body onload="mostrarMsg()">
<table class="tblConteudo">
<tr>
	<td class="tblConteudoTitulo"><%@include file="inc_titulo.jsp"%></td>
</tr>
<tr>
	<td class="tblConteudoCorpo"><br><font color="#28166F">Paciente > Localizar Paciente</font><hr>
		<table border="0" cellpadding="0" cellspacing="8" width="100%">
			<tr>
				<td align="right" width="40%">N�mero do SUS:</td>
				<td align="left" width="60%"><input type="text" id="nr_localizar_sus" name="nr_localizar_sus" maxlength="15" size="50" placeholder="Insira o n�mero do SUS do paciente" onBlur="onBlurNrSus();" onKeyPress="mascaraInteiro();" required><input type="button" id="bt_localizar_paciente" name="bt_localizar_paciente" value="Localizar" onclick="obterDadosPaciente()"></td>
			</tr>
			<tr>
				<td colspan="2"><span id="span_botoes_localizar_paciente" style="display: none;"><input type="button" id="bt_dados_paciente" name="bt_dados_paciente" value="Dados do Paciente" onclick="obterDadosPaciente()"><input type="button" id="bt_atualizar_dados_paciente" name="bt_atualizar_dados_paciente" value="Atualizar Dados do Paciente" onclick="obterDadosPacienteAtualizar()"><input type="button" id="bt_localizar_historico" name="bt_localizar_historico" value="Localizar Hist�rico" onclick=""></span></td>
			</tr>
			<tr>
				<td colspan="2">
					<form id="frm_paciente" action="paciente_atualizar_processa.jsp" method="post">
						<span id="span_dados_paciente"></span>
					</form>
				</td>
			</tr>		
		</table>
	</td>
</tr>
<tr>
	<td class="tblConteudoRodape"><hr><%@include file="inc_rodape.jsp"%></td>
</tr>
</table>
</body>
</html>