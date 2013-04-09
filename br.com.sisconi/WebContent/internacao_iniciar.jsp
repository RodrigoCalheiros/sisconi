<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Ala"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="ala" class="model.Ala"/>
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

function getPacienteBloqueandoCampos(pNrSus){
	$.ajax({
		url: "ajax_obter_paciente.jsp?nr_sus=" + pNrSus,
		}).done(function(retornoSucesso) {
			if (retornoSucesso != 0){
				$('#span_dados_paciente').html(retornoSucesso);
				desabilitarCamposPaciente();
				$('#spanLeito').show();
				$('#spanMedico').show();
			}else{
				$('#span_dados_paciente').html("");
				$('#spanLeito').hide();
				$('#spanMedico').hide();
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
	var coAla = 	$('#co_ala').val();
	$.ajax({
	  url: "ajax_obter_leitos_livres.jsp?co_ala=" + coAla,
	  context: document.body
	}).done(function(retornoSucesso) {
		$('#spanLeitosLivres').html(retornoSucesso);
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
</script>
<body onload="mostrarMsg()">
<table class="tblConteudo">
<tr>
	<td class="tblConteudoTitulo"><%@include file="inc_titulo.jsp"%></td>
</tr>
<tr>
	<td class="tblConteudoCorpo"><br><font color="#28166F">Internação > Iniciar Internação</font><hr>
		<form id="frm_paciente" action="paciente_atualizar_processa.jsp" method="post">
		<table border="0" cellpadding="0" cellspacing="8" width="100%">
			<tr>
				<td align="right" width="40%">Número do SUS:</td>
				<td align="left" width="60%"><input type="text" id="nr_localizar_sus" name="nr_localizar_sus" maxlength="15" size="50" placeholder="Insira o número do SUS do paciente" onBlur="onBlurNrSus();" onKeyPress="mascaraInteiro();" required><input type="button" id="bt_localizar_paciente" name="bt_localizar_paciente" value="Localizar" onclick="obterDadosPaciente()"></td>
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
								<th colspan="2">Médico</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td align="right" width="180px">Especialidade:</td>
								<td align="left">
									<select id="co_especialidade_medico" name="co_especialidade_medico" onchange="getMedicosEspecialidade()"  required>
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
								<td align="right">Médico:</td>
								<td align="left">
									<div id="format">
									  <input type="checkbox" id="check1" /><label for="check1">Rodrigo Calheiros<br>CRM:123</label>
									  <input type="checkbox" id="check2" /><label for="check2">João Silva<br>CRM:3454</label>
									  <input type="checkbox" id="check3" /><label for="check3">Luciana Maria<br>CRM:2334</label>
									</div>
								</td>
							</tr>
						</tbody>
						</table>
					</span>
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