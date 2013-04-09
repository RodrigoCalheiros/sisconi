<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Ala, model.Especialidade, model.Medico"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="ala" class="model.Ala"/>
<jsp:useBean id="medico" class="model.Medico"/>
<jsp:useBean id="especialidade" class="model.Especialidade"/>
<html>
<%@include file="inc_head.jsp"%>
<script>
function getPacienteBloqueandoCampos(pNrSus){
	$.ajax({
		url: "ajax_obter_paciente.jsp?nr_sus=" + pNrSus,
		}).done(function(retornoSucesso) {
			if (retornoSucesso != 0){
				$('#span_dados_paciente').html(retornoSucesso);
				desabilitarCamposPaciente();
				$('#spanLeito').show();
				$('#spanMedico').show();
				$('#spanBtSalvar').show();
			}else{
				$('#span_dados_paciente').html("");
				$('#spanLeito').hide();
				$('#spanMedico').hide();
				$('#spanBtSalvar').hide();
				alert("Paciente n�o cadastrado.");
			}
	});	
}

function obterDadosPaciente(){
	var pNrLocalizarSUS = remover($('#nr_localizar_sus').val(), ' ');
	if (pNrLocalizarSUS == ""){
		alert("O n�mero do SUS do paciente deve ser preenchido.");
		$('#nr_localizar_sus').val("");
		$('#nr_localizar_sus').focus();
	}
	else{
		getPacienteBloqueandoCampos($('#nr_localizar_sus').val());
	}
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

function getLeitosLivres(){
	var coAla = $('#co_ala').val();
	$.ajax({
	  url: "ajax_obter_leitos_livres.jsp?co_ala=" + coAla,
	  context: document.body
	}).done(function(retornoSucesso) {
		$('#spanLeitosLivres').html(retornoSucesso);
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
	var pCoPaciente = $('#hidden_co_paciente').val();
	if (pCoPaciente > 0){
		alert("O Paciente deve ser preenchido.");
		$('#nr_localizar_sus').val("");
		$('#nr_localizar_sus').focus();
		return false;
	}
	var pCoLeito = $('#co_leito').val();
	if (pCoLeito > 0){
		alert("O Leito deve ser preenchido.");
		$('#co_ala').focus();
		return false;
	}
	
	return true;
}

function salvarCadastro(){
	if (validarCadastro() == true){
		if (confirm("Voc� deseja cadastrar a interna��o?")){
			document.forms['frm_internacao'].submit();	
		}	
	} 
}
</script>
<body>
<table class="tblConteudo">
<tr>
	<td class="tblConteudoTitulo"><%@include file="inc_titulo.jsp"%></td>
</tr>
<tr>
	<td class="tblConteudoCorpo"><br><font color="#28166F">Interna��o > Iniciar Interna��o</font><hr>
		<form id="frm_internacao" action="internacao_iniciar_processa.jsp" method="post">
		<table border="0" cellpadding="0" cellspacing="8" width="100%">
			<tr>
				<td align="right" width="40%">N�mero do SUS:</td>
				<td align="left" width="60%"><input type="text" id="nr_localizar_sus" name="nr_localizar_sus" maxlength="15" size="50" placeholder="Insira o n�mero do SUS do paciente" onBlur="onBlurNrSus();" onKeyPress="mascaraInteiro();" required><input type="button" id="bt_localizar_paciente" name="bt_localizar_paciente" value="Localizar" onclick="obterDadosPaciente()"></td>
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
				<td colspan="2">
					<span id="spanMedico" style="display:none;">
						<table class="tbl" width="100%">
						<thead>
							<tr>
								<th colspan="2">M�dico</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="2" align="left">
									<div id="format">
    								<%      
									 	List<Medico> lMedico = medico.getMedicos();
									   	for (int j=0; j<lMedico.size(); j++) {
									   		Medico m = lMedico.get(j);
									%>
	    									<input type="checkbox" class="cbMedico" id="check_<%=m.getCodigoUsuario()%>" name="" />
	    									<label for="check_<%=m.getCodigoUsuario()%>">
	    										<%=m.getNome()%><br>
	    										CRM:<%=m.getCrm()%><br>
	    									</label>
  									<%
										  }
									%>
									</div>
								</td>
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