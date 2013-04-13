<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html" language="java" import="java.util.*, java.text.SimpleDateFormat, model.Leito"%>
 <jsp:useBean id="leito" class="model.Leito"/>
<%	
	String pStringDtInicial = request.getParameter("dt_inicial");
	Date pDtInicial = new SimpleDateFormat("dd/MM/yyyy").parse(pStringDtInicial);
	String pStringDtFinal = request.getParameter("dt_final");	
	Date pDtFinal = new SimpleDateFormat("dd/MM/yyyy").parse(pStringDtFinal);
	int[][] vOcupacaoLeitos = leito.getEstatistica(pDtInicial, pDtFinal);        
	String dadosGrafico = "";
	String coresGrafico = "[";
	String tituloGrafico = "Ocupação de leitos no período de " + pStringDtInicial + " à " + pStringDtFinal;
	int contador = 0;
	if (vOcupacaoLeitos.length > 0){
	    for (int i=0; i < vOcupacaoLeitos.length; i++) {
	    	if (i>0){
	    		dadosGrafico = dadosGrafico + ", ";
	    		coresGrafico = coresGrafico + ", ";
	    	}
	    	contador++;
	    	dadosGrafico = dadosGrafico + "['" + vOcupacaoLeitos[i][0] + "', " + vOcupacaoLeitos[i][1] + "]";
	    	if (contador == 1){
	    		coresGrafico = coresGrafico + "'#FA5E1F'";	
	    	}
	    	else if (contador == 2){
	    		coresGrafico = coresGrafico + "'#FDCB3F'";	
	    	}
	    	else if (contador == 3){
	    		coresGrafico = coresGrafico + "'#71D743'";	
	    	}
	    	else if (contador == 4){
	    		coresGrafico = coresGrafico + "'#D23333'";	
	    	}
	    	else if (contador == 5){
	    		coresGrafico = coresGrafico + "'#BAE73F'";	
	    	}
	    	else if (contador == 6){
	    		coresGrafico = coresGrafico + "'#AB7B55'";	
	    	}
	    	else{
	    		coresGrafico = coresGrafico + "'#B381C9'";
	    		contador = 0;
	    	}
	    }
	    coresGrafico = coresGrafico + "]";
%>
<script type="text/javascript">
	var myData = new Array(<%=dadosGrafico%>);
	var colors = <%=coresGrafico%>;
	var myChart = new JSChart('graph', 'bar');
	myChart.setDataArray(myData);
	myChart.colorizeBars(colors);
	myChart.setTitle('<%=tituloGrafico%>');
	myChart.setTitleColor('#8E8E8E');
	myChart.setAxisNameX('Leitos');
	myChart.setAxisNameY('');
	myChart.setAxisColor('#c6c6c6');
	myChart.setAxisWidth(1);
	myChart.setAxisNameColor('#9a9a9a');
	myChart.setAxisValuesColor('#939393');
	myChart.setAxisPaddingTop(60);
	myChart.setAxisPaddingLeft(50);
	myChart.setAxisPaddingBottom(60);
	myChart.setTextPaddingBottom(20);
	myChart.setTextPaddingLeft(15);
	myChart.setTitleFontSize(14);
	myChart.setBarBorderWidth(0);
	myChart.setBarSpacingRatio(50);
	myChart.setBarValuesColor('#737373');
	myChart.setGrid(true);
	myChart.setSize(720, 400);
	myChart.setBackgroundImage('chart_bg.jpg');
	myChart.draw();
</script>
<%
	}
	else{
%>
<%=0 %>
<%
	}
%>