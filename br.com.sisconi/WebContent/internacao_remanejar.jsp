<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%
if (session.getAttribute("co_tipo_usuario") != null){
	if (!(session.getAttribute("co_tipo_usuario").equals(2))){
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

function existeInternacaoAbertaNrSus(pNrSus){
	var retorno = 1;
	$.ajax({
		  url: "ajax_existe_internacao_aberta_nr_sus.jsp?nr_sus=" + pNrSus,
		  async: false
		}).done(function(retornoSucesso) {
			if (retornoSucesso == 0){
				retorno =  0;
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

function getInternacaoAtivaBloqueandoCampos(pNrSus){
	$.ajax({
		url: "ajax_obter_internacao_ativa_nr_sus.jsp?nr_sus=" + pNrSus,
		}).done(function(retornoSucesso) {
			if (retornoSucesso != 0){
				$('#span_dados_internacao').html(retornoSucesso);
				desabilitarCamposInternacao();
				$('#spanNovoLeito').show();
				$('#spanBtSalvar').show();
			}else{
				$('#span_dados_internacao').html("");
				$('#spanNovoLeito').hide();
				$('#spanBtSalvar').hide();
				alert("Internação não localizada.");
			}
	});	
}

function obterInternacaoAtivaNrSus(){
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
			if (existeInternacaoAbertaNrSus(nrSus) == 1){
				getInternacaoAtivaBloqueandoCampos($('#nr_localizar_sus').val());
			}
			else{
				alert("Não existe uma internação ativa para esse paciente.");
			}
		}
		else{
			alert("Número do SUS " + nrSus + " não está cadastrado.");
			$('#nr_localizar_sus').focus();
		}
	}
}

function desabilitarCamposInternacao(){
	$('#nm_paciente').attr("disabled", true);
	$('#nm_mae').attr("disabled", true);
	$('#dt_inicial').attr("disabled", true);
	$('#dt_final').attr("disabled", true);
	$('#ds_ala_atual').attr("disabled", true);
	$('#co_leito_atual').attr("disabled", true);
	$('.checkbox').attr("disabled", true);
	$('#ds_alta').attr("disabled", true);
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

function getLeitosLivres(){
	var coAla = $('#co_ala').val();
	$.ajax({
	  url: "ajax_obter_leitos_livres.jsp?co_ala=" + coAla,
	  context: document.body
	}).done(function(retornoSucesso) {
		$('#spanLeitosLivres').html(retornoSucesso);
	});	
}

function validarCadastro(){
	var pCoLeito = $('#co_leito').val();
	if ((pCoLeito <= 0) || (pCoLeito == null)){
		alert("O Novo Leito deve ser preenchido.");
		$('#co_ala').focus();
		return false;
	}
	return true;
}

function salvarCadastro(){
	if (validarCadastro() == true){
		if (confirm("Você deseja remanejar o paciente do leito " + $('#co_leito_atual').val() + " para o leito " + $('#co_leito').val() + "?")){
			document.forms['frm_internacao_remanejar'].submit();	
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
	<td class="tblConteudoCorpo"><br><font color="#28166F" style="font-weight: bold;">Internação > Remanejar Internação</font><hr>
		<form id="frm_internacao_remanejar" action="internacao_remanejar_processa.jsp" method="post">
		<table border="0" cellpadding="0" cellspacing="8" width="100%">
			<tr>
				<td align="right" width="40%">Número do SUS:</td>
				<td align="left" width="60%"><input type="text" id="nr_localizar_sus" name="nr_localizar_sus" maxlength="15" size="30" onKeyPress="mascaraInteiro();" required><input type="button" id="bt_localizar_paciente" name="bt_localizar_paciente" value="Localizar" onclick="obterInternacaoAtivaNrSus()"></td>
			</tr>
			<tr>
				<td colspan="2">
					<span id="span_dados_internacao"></span>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<span id="spanNovoLeito" style="display:none;">
						<table class="tbl" width="100%">
						<thead>
							<tr>
								<th colspan="2">Novo Leito</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td align="right" width="180px">Ala*:</td>
								<td align="left">
									<select id="co_ala" name="co_ala" onchange="getLeitosLivres()"  required>
									 	<option value="0">--</option>
									<%      
									   try {  
									      List<Ala> lAla = ala.getAlas();  
									      for (int i=0; i<lAla.size(); i++) {
									    	  Ala a = lAla.get(i);
									%>
									    <option value="<%=a.getCodigoAla()%>"><%=a.getNomeAla()%></option>
									<%
									      }
									   }catch (Exception e) {  
										      e.printStackTrace();  
										}
									%>
									</select>
								</td>
							</tr>
							<tr>
								<td align="right">Novo Leito livre*:</td>
								<td align="left"><span id="spanLeitosLivres">--</span></td>
							</tr>
							<tr>
								<td align="left">* Campo Obrigatório</td>
								<td align="left"></td>
							</tr>
						</tbody>
						</table>
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
<%
}
%>