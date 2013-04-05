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
		alert("O nome da M�e deve ser preenchido.");
		$('#nm_mae').val("");
		$('#nm_mae').focus();
		return false;
	}
	var pNrCpf = remover($('#nr_cpf').val(), ' ');
	if (pNrCpf == ""){
		$('#nr_cpf').val("");
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
	if ($('#co_cidade').val() == ""){
		alert("O nome da cidade deve ser preenchido.");
		$('#co_cidade').focus();
		return false;
	}
	return true;
}

function salvarCadastro(){
	if (validarCadastro()){
		if (confirm("Voc� deseja cadastrar o paciente?")){
			document.forms['frm_paciente'].submit();	
		}	
	} 
	
}
</script>
<body onload="mostrarMsg()">
<table border="0" cellpadding="0" cellspacing="10" width="100%">
<tr>
	<td><%@include file="inc_titulo.jsp"%></td>
</tr>
<tr>
	<td>Cadastrar Paciente<hr>
		<form id="frm_paciente" action="paciente_cadastrar_processa.jsp" method="post">
			<table border="0" cellpadding="0" cellspacing="8">
				<tr>
					<td align="right"></td>
					<td align="left">Dados Pessoais</td>
				</tr>
				<tr>
					<td align="right">Nome:</td>
					<td align="left"><input type="text" id="nm_paciente" name="nm_paciente" maxlength="70" size="50" placeholder="Insira o nome do paciente" required></td>
				</tr>
				<tr>
					<td align="right">Nome da M�e:</td>
					<td align="left"><input type="text" id="nm_mae" name="nm_mae" maxlength="70" size="50" placeholder="Insira o nome da m�e do paciente" required></td>
				</tr>
				<tr>
					<td align="right">CPF:</td>
					<td align="left"><input type="text" id="nr_cpf" name="nr_cpf" maxlength="14" size="50" placeholder="Insira o n�mero do CPF do paciente" onKeyPress="MascaraCPF(form.nr_cpf);" onBlur="ValidarCPF(document.getElementById('nr_cpf').value, 'nr_cpf');"></td>
				</tr>
				<tr>
					<td align="right">N�mero do SUS:</td>
					<td align="left"><input type="text" id="nr_sus" name="nr_sus" maxlength="15" size="50" placeholder="Insira o n�mero do SUS do paciente" required></td>
				</tr>
				<tr>
					<td align="right">Data de Nascimento:</td>
					<td align="left"><input type="text" id="datepicker" name="dt_nascimento" maxlength="10" size="50" placeholder="Insira a data de nascimento do paciente" onKeyPress="MascaraData(form.dt_nascimento);" required></td>
				</tr>
				<tr>
					<td align="right">Telefone:</td>
					<td align="left"><input type="text" id="nr_telefone" name="nr_telefone" maxlength="14" size="50" placeholder="Insira o n�mero do telefone do paciente" onKeyPress="MascaraTelefone(form.nr_telefone);"></td>
				</tr>
				<tr>
					<td align="right"></td>
					<td align="left">Endere�o</td>
				</tr>
				<tr>
					<td align="right">Rua:</td>
					<td align="left"><input type="text" id="ds_rua" name="ds_rua" maxlength="60" size="50" placeholder="Insira o nome da rua do endere�o do paciente" required></td>
				</tr>
				<tr>
					<td align="right">N�mero:</td>
					<td align="left"><input type="text" id="ds_numero" name="ds_numero" maxlength="10" size="50" placeholder="Insira o n�mero do endere�o do paciente" onKeyPress="mascaraInteiro();" required></td>
				</tr>
				<tr>
					<td align="right">Complemento:</td>
					<td align="left"><input type="text" id="ds_complemento" name="ds_complemento" maxlength="100" size="50" placeholder="Insira o complemento do endere�o do paciente" ></td>
				</tr>
				<tr>
					<td align="right">Bairro:</td>
					<td align="left"><input type="text" id="ds_bairro" name="ds_bairro" maxlength="40" size="50" placeholder="Insira o nome do bairro do endere�o do paciente" required></td>
				</tr>
				<tr>
					<td align="right">CEP:</td>
					<td align="left"><input type="text" id="ds_cep" name="ds_cep" maxlength="10" size="50" placeholder="Insira o CEP do endere�o do paciente" onKeyPress="MascaraCep(form.ds_cep);"></td>
				</tr>
				<tr>
					<td align="right">Estado:</td>
					<td align="left">
						<select name="co_estado" id="co_estado" onchange="getCidades()" required>
							<option value="0">--</option>
						<%      
						   try {  
						      List<Estado> les = paciente.getEstados();    
						        
						      for (int i=0; i<les.size(); i++) {
						    	  Estado e = les.get(i);
						%>
						    	  <option value=<%=e.getCodigoEstado()%>><%=e.getUF()%></option>
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
					<td align="right">Cidade:</td>
					<td align="left"><span id="spanCidade">-</span></td>
				</tr>
				<tr>
					<td></td>
					<td align="left"><input type="button" id="bt_salvar" name="bt_salvar" value="Salvar" onclick="salvarCadastro()"></td>
				</tr>
			</table>
		</form>	
	</td>
</tr>
<tr>
	<td align="center"><%@include file="inc_rodape.jsp"%></td>
</tr>
</table>
</body>
</html>