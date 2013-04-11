<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Ala"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="ala" class="model.Ala"/>
<html>
<%@include file="inc_head.jsp"%>
<script>	

function obterStatusLeito(pCoLeito){
	$.ajax({
		url: "ajax_obter_status_leito.jsp?co_leito=" + pCoLeito + "&co_status_leito=" + $('#co_leito_status_' + pCoLeito).val(),
		}).done(function(retornoSucesso) {
			if(retornoSucesso != 0){
				$('#spanLeito' + pCoLeito).html(retornoSucesso);
			}
		});
	setTimeout("obterStatusLeito(" + pCoLeito + "," + "'spanLeito" + pCoLeito + "')",5000);
}

function obterClasseTbLeito(pCoStatusLeito){
	var retorno = "";
	switch (pCoStatusLeito){
		case 1: 
			retorno = "tbbloqueado";
			break;
		case 2: 
			retorno = "tbemhigienizacao";
			break;
		case 3: 
			retorno = "tblivre";
			break;
		case 4: 
			retorno = "tbocupado";
			break;
		case 5: 
			retorno = "tbreservado";
			break;
	}
	return retorno;
}

function obterLeitos(){
	$.ajax({
		url: "ajax_obter_leitos.jsp?co_ala=" + $('#co_ala').val(),
		}).done(function(retornoSucesso) {
			$('#span_Leitos').html(retornoSucesso);
		});
}

function desbloquearLeito(pCoLeito, pCoStatus){
	$.ajax({
		url: "ajax_desbloquear_leito.jsp?co_leito=" + pCoLeito + "&co_status=" + pCoStatus,
		}).done(function(retornoSucesso) {
			obterStatusLeito(pCoLeito);
		});
}

function liberarLeito(pCoLeito, pCoStatus){
	$.ajax({
		url: "ajax_liberar_leito.jsp?co_leito=" + pCoLeito + "&co_status=" + pCoStatus,
		}).done(function(retornoSucesso) {
			obterStatusLeito(pCoLeito);
		});
}

function bloquearLeito(pCoLeito, pCoStatus){
	$.ajax({
		url: "ajax_bloquear_leito.jsp?co_leito=" + pCoLeito + "&co_status=" + pCoStatus,
		}).done(function(retornoSucesso) {
			obterStatusLeito(pCoLeito);
		
		});
}

</script>
<body>
<table class="tblConteudo">
<tr>
	<td class="tblConteudoTitulo"><%@include file="inc_titulo.jsp"%></td>
</tr>
<tr>
	<td class="tblConteudoCorpo"><br><font color="#28166F">Leito > Monitorar Leito</font><hr>
		<table border="0" cellpadding="0" cellspacing="8" width="100%">
			<tr>
				<td align="right" width="40%">Ala:</td>
				<td align="left" width="60%">
					<select name="co_ala" id="co_ala" required>
						<option value="0">% Todas %</option>
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
					</select><input type="button" id="bt_localizar_leitos" name="bt_localizar_leitos" value="Localizar" onclick="obterLeitos()">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<span id="span_Leitos"></span>
				</td>
			</tr>
			<tr>
				<td>
					<table class="tblegenda">
						<thead>
							<tr>
								<th>Cor</th>
								<th>Status do Leito</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td align="center"><img src="_imagens/qd_green.png"></td>
								<td align="left">Livre</td>
							</tr>
							<tr>
								<td align="center"><img src="_imagens/qd_red.png"></td>
								<td align="left">Ocupado</td>
							</tr>
							<tr>
								<td align="center"><img src="_imagens/qd_gray.png"></td>
								<td align="left">Bloqueado</td>
							</tr>
							<tr>
								<td align="center"><img src="_imagens/qd_blue.png"></td>
								<td align="left">Em Higienização</td>
							</tr>
						</tbody>
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