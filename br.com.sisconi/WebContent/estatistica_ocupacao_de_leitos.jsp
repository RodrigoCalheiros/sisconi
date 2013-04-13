<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%
if (session.getAttribute("co_tipo_usuario") != null){
	if (!(session.getAttribute("co_tipo_usuario").equals(2))){
		response.sendRedirect("acesso_negado.jsp");
	}
%>
<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Ala"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="ala" class="model.Ala"/>
<html>
<%@include file="inc_head.jsp"%>
<script>
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

function obterEstatisticaOcupacaoLeitos(){
	var pDtInicial = $('#dt_inicial').val();
	var pDtFinal = $('#dt_final').val();
	$.ajax({
		url: "ajax_obter_estatistica_ocupacao_leitos.jsp?dt_inicial=" + pDtInicial + "&dt_final=" + pDtFinal
		}).done(function(retornoSucesso) {
			if (retornoSucesso != 0){
				$('#graph').html(retornoSucesso);	
			}
			else{
				$('#graph').html("");
				alert("Não existe estatísticas para esse período de tempo.");
			}
			
	});
}
</script>
<body>
<table class="tblConteudo">
<tr>
	<td class="tblConteudoTitulo"><%@include file="inc_titulo.jsp"%></td>
</tr>
<tr>
	<td class="tblConteudoCorpo"><br><font color="#28166F" style="font-weight: bold;">Estatísticas > Estatística de Ocupação de Leitos</font><hr>
		<form id="form_estatistica">
		<table border="0" cellpadding="0" cellspacing="8" width="100%">
			<tr>
				<td align="center">Período:<input type="text" class="datepicker" id="dt_inicial" name="dt_inicial" maxlength="10" size="20" onKeyPress="MascaraData(form.dt_inicial);" required>&nbsp;à&nbsp;<input type="text" class="datepicker" id="dt_final" name="dt_final" maxlength="10" size="20" onKeyPress="MascaraData(form.dt_final);" required>&nbsp;<input type="button" id="bt_localizar_paciente" name="bt_localizar_paciente" value="Localizar" onclick="obterEstatisticaOcupacaoLeitos()"></td>
			</tr>
			<tr>
				<td align="center">
					<span id="graph" style="z-index: 0;">
					
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
<%
}
%>