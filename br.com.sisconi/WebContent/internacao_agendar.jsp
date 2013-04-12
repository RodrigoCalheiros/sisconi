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

function existeAgendamentoAtivoNrSus(pNrSus){
	var retorno = 1;
	$.ajax({
		  url: "ajax_existe_agendamento_ativo_nr_sus.jsp?nr_sus=" + pNrSus,
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
				alert("Paciente não localizado.")
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
		var nrSus = $('#nr_localizar_sus').val();
		existeNrSus = getExisteNrSusPaciente(nrSus);
		if (existeNrSus == 1){
			if (existeAgendamentoAtivoNrSus(nrSus) == 0){
				getPacienteBloqueandoCampos($('#nr_localizar_sus').val());	
			}
			else{
				alert("Já existe um agendamento ativo para esse paciente.");
			}
		}
		else{
			alert("Número do SUS " + nrSus + " não está cadastrado.");
			$('#nr_localizar_sus').focus();
		}
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
	var pCoPaciente = $('#hidden_co_paciente').val();
	if (pCoPaciente <= 0){
		alert("O Paciente deve ser preenchido.");
		$('#nr_localizar_sus').val("");
		$('#nr_localizar_sus').focus();
		return false;
	}
	var pCoLeito = $('#co_leito').val();
	if ((pCoLeito <= 0) || (pCoLeito == null)){
		alert("O Leito deve ser preenchido.");
		$('#co_ala').focus();
		return false;
	}
	var idRdMedico = "";
	var coMedico = "";
	var radiosMedico = $('input:radio[name=radio_medico]');
	for (i = 0; i < radiosMedico.length; i++){
		if ($('#' + radiosMedico[i].id).is(':checked')){
			coMedico = $('#' + radiosMedico[i].id).val();
			break;
		}	
	}
	$('#hidden_co_medico').val(coMedico);
	if ($('#hidden_co_medico').val() == ""){
		alert("Selecione pelo menos um médico responsável pela internação.");
		return false;
	}
	
	return true;
}

function salvarCadastro(){
	if (validarCadastro() == true){
		if (confirm("Você deseja cadastrar o agendamento da internação?")){
			document.forms['frm_agendamento_internacao'].submit();	
		}	
	} 
}
</script>
<script type="text/javascript">
	$(function(){
		$( ".datepicker" ).datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: "1900:<%=new java.util.Date()%>",
			dateFormat: 'dd/mm/yy',
	        dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'],
	        dayNamesMin: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
	        dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
	        monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
	        monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez']
		});
	});
</script>
<body onload="mostrarMsg()">
<table class="tblConteudo">
<tr>
	<td class="tblConteudoTitulo"><%@include file="inc_titulo.jsp"%></td>
</tr>
<tr>
	<td class="tblConteudoCorpo"><br><font color="#28166F">Internação > Agendar Internação</font><hr>
		<form id="frm_agendamento_internacao" action="internacao_agendar_processa.jsp" method="post">
		<input type="hidden" id="hidden_co_medico" name="hidden_co_medico" value="">
		<table border="0" cellpadding="0" cellspacing="8" width="100%">
			<tr>
				<td align="right" width="40%">Número do SUS:</td>
				<td align="left" width="60%"><input type="text" id="nr_localizar_sus" name="nr_localizar_sus" maxlength="15" size="30" onBlur="onBlurNrSus();" onKeyPress="mascaraInteiro();" required><input type="button" id="bt_localizar_paciente" name="bt_localizar_paciente" value="Localizar" onclick="obterDadosPaciente()"></td>
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
								<td align="right">Data Agendamento:</td>
								<td align="left"><input type="text" class="datepicker" id="dt_agendamento" name="dt_agendamento" maxlength="10" size="50" onKeyPress="MascaraData(form.dt_agendamento);" onchange="getLeitosLivresAgendamento()" required></td>
							</tr>
							<tr>
								<td align="right" width="180px">Ala:</td>
								<td align="left">
									<select id="co_ala" name="co_ala" onchange="getLeitosLivresAgendamento()"  required>
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
								<td align="right">Leito:</td>
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
								<th colspan="2">Médico</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="2" align="left">
									<div id="radio">
    								<%      
									 	List<Medico> lMedico = medico.getMedicos();
									   	for (int j=0; j<lMedico.size(); j++) {
									   		Medico m = lMedico.get(j);
									%>
	    									<input type="radio" id="radio_medico_<%=m.getCodigoUsuario()%>" name="radio_medico" value="<%=m.getCodigoUsuario()%>" />
	    									<label for="radio_medico_<%=m.getCodigoUsuario()%>">
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