<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Ala"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="ala" class="model.Ala"/>
<html>
<%@include file="inc_head.jsp"%>
<script>
var pMsg = <%=request.getParameter("msg")%>

function mostrarMsg(){
	if (pMsg != '' && pMsg != null){
		alert(pMsg);
	}
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
<table class="tblConteudo">
<tr>
	<td class="tblConteudoTitulo"><%@include file="inc_titulo.jsp"%></td>
</tr>
<tr>
	<td class="tblConteudoCorpo"><br><font color="#28166F">Leito > Cadastrar Leito</font><hr>
		<form id="frm_leito" action="leito_cadastrar_processa.jsp" method="post">
			<table class="tbl">
				<thead>
					<tr>
						<th colspan="2">Dados do Leito</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td align="right" width="180px">Código do Patrimônio:</td>
						<td align="left"><input type="text" id="co_patrimonio" name="co_patrimonio" maxlength="70" size="50" placeholder="Insira o código do patrimônio do leito" required></td>
					</tr>
					<tr>
						<td align="right">Ala:</td>
						<td align="left">
							<select name="co_ala" id="co_ala" required>
							<%      
							   try {  
							      List<Ala> listAla = ala.getAlas();    
							        
							      for (int i=0; i<listAla.size(); i++) {
							    	   Ala ala = listAla.get(i);
							%>
							    	  <option value=<%=ala.getCodigoAla()%>><%=ala.getNomeAla()%></option>
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
						<td></td>
						<td align="left"><input type="button" id="bt_salvar" name="bt_salvar" value="Salvar" onclick="salvarCadastro()"></td>
					</tr>
				</tbody>
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