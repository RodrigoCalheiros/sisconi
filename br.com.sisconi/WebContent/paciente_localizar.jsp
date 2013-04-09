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

function getPaciente(pNrSus){
	$.ajax({
		url: "ajax_obter_paciente.jsp?nr_sus=" + pNrSus,
		}).done(function(retornoSucesso) {
			if (retornoSucesso != 0){
				$('#span_dados_paciente').html(retornoSucesso);
				$('#span_botoes_localizar_paciente').show();
				$('#span_bt_salvar').show();
			}else{
				$('#span_botoes_localizar_paciente').hide();
				$('#span_dados_paciente').html("");
				alert("Paciente não cadastrado.");
			}
	});	
}

function getPacienteBloqueandoCampos(pNrSus){
	$.ajax({
		url: "ajax_obter_paciente.jsp?nr_sus=" + pNrSus,
		}).done(function(retornoSucesso) {
			if (retornoSucesso != 0){
				$('#span_dados_paciente').html(retornoSucesso);
				$('#span_botoes_localizar_paciente').show();
				desabilitarCamposPaciente();
				$('#span_bt_salvar').hide();
			}else{
				$('#span_botoes_localizar_paciente').hide();
				$('#span_dados_paciente').html("");
				alert("Paciente não cadastrado.");
			}
	});	
}

function obterDadosPaciente(){
	var pNrLocalizarSUS = remover($('#nr_localizar_sus').val(), ' ');
	if (pNrLocalizarSUS == ""){
		alert("O número do SUS do paciente deve ser preenchido.");
		$('#nr_localizar_sus').val("");
		$('#nr_localizar_sus').focus();
	}
	else{
		getPacienteBloqueandoCampos($('#nr_localizar_sus').val());
	}
}

function obterInformacoesPaciente(){
	var pNrLocalizarSUS = $('#hidden_nr_sus').val();
	getPacienteBloqueandoCampos(pNrLocalizarSUS);
}

function obterDadosPacienteAtualizar(){
	var pNrLocalizarSUS = $('#hidden_nr_sus').val();
	getPaciente(pNrLocalizarSUS);
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

function limparCamposPaciente(){
	$('#nm_paciente').val("");
	$('#nm_mae').val("");
	$('#nr_cpf').val("");
	$('#nr_sus').val("");
	$('#nr_telefone').val("");
	$('#datepicker').val("");
	$('#ds_rua').val("");
	$('#ds_numero').val("");
	$('#ds_complemento').val("");
	$('#ds_bairro').val("");
	$('#ds_cep').val("");
	$('#co_estado').val("");
	$('#spanCidade').html("");
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

function getExisteNrSusPaciente(pNrSus){
	if (pNrSus != ""){
		$.ajax({
			url: "ajax_existe_numero_sus_paciente.jsp?nr_sus=" + pNrSus,
			}).done(function(retornoSucesso) {
			var retorno = retornoSucesso;
			if (retorno == 1){
				alert("Número do SUS " + pNrSus + " já cadastrado.");
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
	if ($('#co_cidade').val() != null){
		$('#hidden_co_cidade').val($('#co_cidade').val());
	}
	return true;
}

function salvarCadastro(){
	if (validarCadastro() == true){
		if (confirm("Você deseja atualizar os dados do paciente?")){
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
				<td align="right" width="40%">Número do SUS:</td>
				<td align="left" width="60%"><input type="text" id="nr_localizar_sus" name="nr_localizar_sus" maxlength="15" size="50" placeholder="Insira o número do SUS do paciente" onBlur="onBlurNrSus();" onKeyPress="mascaraInteiro();" required><input type="button" id="bt_localizar_paciente" name="bt_localizar_paciente" value="Localizar" onclick="obterDadosPaciente()"></td>
			</tr>
			<tr>
				<td colspan="2">
					<span id="span_botoes_localizar_paciente" style="display: none;">
						<button onclick="obterInformacoesPaciente()"><img src="_imagens/icones/16X16/documents.gif">&nbsp;Dados do Paciente</button>
						<button onclick="obterDadosPacienteAtualizar()"><img src="_imagens/icones/16X16/edit.gif">&nbsp;Atualizar Dados do Paciente</button>
						<button onclick=""><img src="_imagens/icones/16X16/file_temp.gif">&nbsp;Localizar Histórico</button>
					</span>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<form id="frm_paciente" action="paciente_atualizar_processa.jsp" method="post">
						<span id="span_dados_paciente"></span>
					</form>
				</td>
			</tr>
			<tr>
				<td>
					<table width="100%">
						<tr>
							<td width="180px"></td>
							<td align="left"><span id="span_bt_salvar" style="display:none;"><input type="button" id="bt_reset" name="bt_reset" value="Limpar" onclick="limparCamposPaciente()">&nbsp;<input type="button" id="bt_cancelar" name="bt_cancelar" value="Cancelar" onclick="obterDadosPaciente()">&nbsp;<input type="button" id="bt_salvar" name="bt_salvar" value="Salvar" onclick="salvarCadastro()"></span></td>
						</tr>	
					</table>
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