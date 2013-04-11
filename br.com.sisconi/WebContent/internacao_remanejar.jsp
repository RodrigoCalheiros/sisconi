<%@include file="inc_verifica_acesso_usuario.jsp"%>
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

function obterInternacaoNrSus(){
	$.ajax({
		  url: "ajax_obter_internacao_nr_sus.jsp?nr_sus=" + $('#nr_localizar_sus').val(),
		  async: false
		}).done(function(retornoSucesso) {
			if (retornoSucesso != 0){
				$('#span_dados_paciente').html(retornoSucesso);
				$('#spanLeito').show();
				$('#spanBtSalvar').show();
			}
			else{
				$('#span_dados_paciente').html("");
				alert("Não há internação para o paciente com número de SUS " + $('#nr_localizar_sus').val());
				$('#spanLeito').hide();
				$('#spanBtSalvar').hide();
				$('#nr_localizar_sus').focus();				
			}
		});
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
	var pCoPaciente = $('#hidden_co_paciente').val();
	if (pCoPaciente <= 0){
		alert("O Paciente deve ser preenchido.");
		$('#nr_localizar_sus').val("");
		$('#nr_localizar_sus').focus();
		return false;
	}
	var pCoLeito = $('#co_leito').val();
	if (pCoLeito <= 0){
		alert("O Leito deve ser preenchido.");
		$('#co_ala').focus();
		return false;
	}
	
	return true;
}

function salvarCadastro(){
	if (validarCadastro() == true){
		if (confirm("Você deseja cadastrar a internação?")){
			document.forms['frm_remanejar_internacao'].submit();	
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
	<td class="tblConteudoCorpo"><br><font color="#28166F">Internação > Remanejar Internação</font><hr>
		<form id="frm_remanejar_internacao" action="internacao_remanejar_processa.jsp" method="post">
		<table border="0" cellpadding="0" cellspacing="8" width="100%">
			<tr>
				<td align="right" width="40%">Número do SUS:</td>
				<td align="left" width="60%"><input type="text" id="nr_localizar_sus" name="nr_localizar_sus" maxlength="15" size="30" onBlur="onBlurNrSus();" onKeyPress="mascaraInteiro();" required><input type="button" id="bt_localizar_paciente" name="bt_localizar_paciente" value="Localizar" onclick="obterInternacaoNrSus()"></td>
			</tr>
			<tr>
				<td colspan="2">
					<span id="span_dados_paciente"></span>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<span id="spanLeito" style="display:none;">
						<table class="tbl" width="100%">
						<thead>
							<tr>
								<th colspan="2">Leito</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td align="right" width="180px">Ala:</td>
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
								<td align="right">Leito livre:</td>
								<td align="left"><span id="spanLeitosLivres">--</span></td>
							</tr>
						</tbody>
						</table>
					</span>
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