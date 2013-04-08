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
	var pCoPatrimonio = remover($('#co_patrimonio').val(), ' ');
	if (pCoPatrimonio == ""){
		alert("O código do patrimônio deve ser preenchido.");
		$('#co_patrimonio').val("");
		$('#co_patrimonio').focus();
		return false;
	}
	return true;
}

function salvarCadastro(){
	if (validarCadastro() == true){
		if (confirm("Você deseja cadastrar o leito?")){
			document.forms['frm_leito'].submit();	
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
	<td class="tblConteudoCorpo"><br><font color="#28166F">Leito > Cadastrar Leito</font><hr>
		<form id="frm_leito" action="leito_cadastrar_processa.jsp" method="post">
			<table class="tbl" width="100%">
				<thead>
					<tr>
						<th colspan="2">Dados do Leito</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td align="right" width="180px">Código do Patrimônio:</td>
						<td align="left"><input type="text" id="co_patrimonio" name="co_patrimonio" maxlength="10" size="50" placeholder="Insira o código do patrimônio do leito" onKeyPress="mascaraInteiro();" required></td>
					</tr>
					<tr>
						<td align="right">Ala:</td>
						<td align="left">
							<select name="co_ala" id="co_ala" required>
							<%      
							   try {  
							      List<Ala> listAla = ala.getAlas();  
							      for (int i=0; i<listAla.size(); i++) {
							    	   Ala a = listAla.get(i);
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