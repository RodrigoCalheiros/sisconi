<%@include file="inc_verifica_acesso_usuario.jsp"%>
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
</script>
<body>
<table class="tblConteudo">
<tr>
	<td class="tblConteudoTitulo"><%@include file="inc_titulo.jsp"%></td>
</tr>
<tr>
	<td class="tblConteudoCorpo"><br><font color="#28166F">Estatísticas > Estatística de Ocupação de Leitos</font><hr>
		<form id="form_estatistica">
		<table border="0" cellpadding="0" cellspacing="8" width="100%">
			<tr>
				<td align="center">Período:<input type="text" class="datepicker" id="dt_inicial" name="dt_inicial" maxlength="10" size="20" onKeyPress="MascaraData(form.dt_inicial);" required>&nbsp;à&nbsp;<input type="text" class="datepicker" id="dt_final" name="dt_final" maxlength="10" size="20" onKeyPress="MascaraData(form.dt_final);" required>&nbsp;<input type="button" id="bt_localizar_paciente" name="bt_localizar_paciente" value="Localizar" onclick="obterDadosPaciente()"></td>
			</tr>
			<tr>
				<td align="right">
					<span id="graph">
					<script type="text/javascript">
						var myData = new Array(['Asia', 437], ['Europe', 322], ['North America', 233], ['Latin America', 110], ['Africa', 34], ['Middle East', 20], ['Aus/Oceania', 19]);
						var colors = ['#2D6B96', '#327AAD', '#3E90C9', '#55A7E3', '#60B6F0', '#81C4F0', '#9CCEF0'];
						var myChart = new JSChart('graph', 'bar');
						myChart.setDataArray(myData);
						myChart.colorizeBars(colors);
						myChart.setTitle('Ocupação de leitos no período de ');
						myChart.setTitleColor('#8E8E8E');
						myChart.setAxisNameX('');
						myChart.setAxisNameY('');
						myChart.setAxisColor('#C4C4C4');
						myChart.setAxisNameFontSize(16);
						myChart.setAxisNameColor('#999');
						myChart.setAxisValuesColor('#777');
						myChart.setAxisColor('#B5B5B5');
						myChart.setAxisWidth(1);
						myChart.setBarValuesColor('#2F6D99');
						myChart.setBarOpacity(0.5);
						myChart.setAxisPaddingTop(60);
						myChart.setAxisPaddingBottom(40);
						myChart.setAxisPaddingLeft(45);
						myChart.setTitleFontSize(11);
						myChart.setBarBorderWidth(0);
						myChart.setBarSpacingRatio(50);
						myChart.setBarOpacity(0.9);
						myChart.setFlagRadius(6);
						myChart.setTooltip(['North America', 'U.S.A and Canada']);
						myChart.setTooltipPosition('nw');
						myChart.setTooltipOffset(3);
						myChart.setSize(616, 321);
						myChart.setBackgroundImage('chart_bg.jpg');
						myChart.draw();
					</script>
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