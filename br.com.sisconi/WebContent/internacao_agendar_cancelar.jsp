<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%
if (!(session.getAttribute("co_tipo_usuario").equals(1))){
	response.sendRedirect("acesso_negado.jsp");
}
%>
<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Ala, model.Especialidade, model.Medico"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="ala" class="model.Ala"/>
<jsp:useBean id="medico" class="model.Medico"/>
<html>
<%@include file="inc_head.jsp"%>
<script>
var pMsg = <%=request.getParameter("msg")%>

function mostrarMsg(){
	if (pMsg != '' && pMsg != null){
		alert(pMsg);
	}
}

function existeAgendamentoAtivoNrSus(pNrSus){
	var retorno = 0;
	$.ajax({
		  url: "ajax_existe_agendamento_ativo_nr_sus.jsp?nr_sus=" + pNrSus,
		  async: false
		}).done(function(retornoSucesso) {
			if (retornoSucesso == 1){
				retorno =  1;
			}
		});
	return retorno;
}

function getExisteNrSusPaciente(pNrSus){
	var retorno = 0;
	$.ajax({
		url: "ajax_existe_numero_sus_paciente.jsp?nr_sus=" + pNrSus,
		async: false
		}).done(function(retornoSucesso) {
			if (retornoSucesso == 1){
				retorno =  1;
			}
	});	
	return retorno;
}

function getAgendamentoAtivoBloqueandoCampos(pNrSus){
	$.ajax({
		url: "ajax_obter_agendamento_ativo_nr_sus.jsp?nr_sus=" + pNrSus
		}).done(function(retornoSucesso) {
			if (retornoSucesso != 0){
				$('#span_dados_agendamento').html(retornoSucesso);
				desabilitarCamposAgendamento();
				$('#spanBtSalvar').show();
			}else{
				$('#span_dados_agendamento').html("");
				$('#spanBtSalvar').hide();
				alert("Agendamento não localizada.");
			}
	});	
}

function obterAgendamentoAtivoNrSus(){
	var pNrLocalizarSUS = remover($('#nr_localizar_sus').val(), ' ');
	if (pNrLocalizarSUS == ""){
		alert("O número do SUS do paciente deve ser preenchido.");
		$('#nr_localizar_sus').val("");
		$('#nr_localizar_sus').focus();
	}
	else{
		var nrSus = $('#nr_localizar_sus').val();
		existeNrSus = getExisteNrSusPaciente(nrSus);
		if (existeNrSus == 1){
			if (existeAgendamentoAtivoNrSus(nrSus) == 1){
				getAgendamentoAtivoBloqueandoCampos($('#nr_localizar_sus').val());	
			}
			else{
				alert("Não existe um agendamento ativo para esse paciente.");
			}
		}
		else{
			alert("Número do SUS " + nrSus + " não está cadastrado.");
			$('#nr_localizar_sus').focus();
		}
	}
}

function desabilitarCamposAgendamento(){
	$('#ds_status_agendamento').attr("disabled", true);
	$('#nm_paciente').attr("disabled", true);
	$('#nm_mae').attr("disabled", true);
	$('#dt_agendamento').attr("disabled", true);
	$('#ds_ala').attr("disabled", true);
	$('#co_leito').attr("disabled", true);
	$('.radio').attr({disabled: true});
}

function getLeitosLivresAgendamento(){
	var coAla = $('#co_ala').val();
	var dtAgendamento = $('#dt_agendamento').val();
	if ((coAla != 0) && (dtAgendamento != "")){
		$.ajax({
			  url: "ajax_obter_leitos_livres_agendamento.jsp?co_ala=" + coAla + "&dt_agendamento=" + dtAgendamento,
			  context: document.body
			}).done(function(retornoSucesso) {
				$('#spanLeitosLivres').html(retornoSucesso);
			});	
	}	
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
	return true;
}

function salvarCadastro(){
	if (validarCadastro() == true){
		if (confirm("Você deseja cancelar o agendamento da internação?")){
			document.forms['frm_internacao_cancelar'].submit();	
		}	
	} 
}
</script>
<body onload="mostrarMsg()">
<table class="tblConteudo">
<tr>
	<td class="tblConteudoTitulo"><%@include file="inc_titulo.jsp"%></td>
</tr>
<tr>
	<td class="tblConteudoCorpo"><br><font color="#28166F">Internação > Cancelar Agendamento</font><hr>
		<form id="frm_internacao_cancelar" action="internacao_agendar_cancelar_processa.jsp" method="post">
		<table border="0" cellpadding="0" cellspacing="8" width="100%">
			<tr>
				<td align="right" width="40%">Número do SUS:</td>
				<td align="left" width="60%"><input type="text" id="nr_localizar_sus" name="nr_localizar_sus" maxlength="15" size="30" onKeyPress="mascaraInteiro();" required><input type="button" id="bt_localizar_paciente" name="bt_localizar_paciente" value="Localizar" onclick="obterAgendamentoAtivoNrSus()"></td>
			</tr>
			<tr>
				<td colspan="2">
					<span id="span_dados_agendamento"></span>
				</td>
			</tr>
			<tr>
				<td align="left"></td>
				<td align="right">
					<span id="spanBtSalvar" style="display:none;">
						<input type="button" id="bt_salvar" name="bt_salvar" value="Salvar" onclick="salvarCadastro()">
					</td>
			</tr>
		</table>
		</form>
	</td>
</tr>
<tr>
	<td class="tblConteudoRodape"><hr><%@include file="inc_rodape.jsp"%></td>
</tr>
</table>
</body>
</html>