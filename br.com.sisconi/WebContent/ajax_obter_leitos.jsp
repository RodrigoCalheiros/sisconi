<script>
  $(function() {
	  $( "#accordion" ).accordion();
  });
</script>
<%@ page contentType="text/html" language="java" import="java.sql.*, java.util.*, model.Leito"%>
 <jsp:useBean id="leito" class="model.Leito"/>
<div id="accordion">
<%
	String pStringCoAla = request.getParameter("co_ala");	
	int coAla = Integer.parseInt(pStringCoAla);
	
   	try {
   		List<Leito> lLeito = null;
   		if (coAla > 0){
   			lLeito = leito.getLeitos(coAla);	
   		}
   		else{
   			lLeito = leito.getLeitos();
   		}
        
   		int contador = 0;
   		coAla = 0;
   		String tbClass = "";
     	for (int i=0; i < lLeito.size(); i++) {
     		Leito l = lLeito.get(i);
     		switch (l.getCodigoStatusLeito()){
     			case 1: 
     				tbClass = "tbbloqueado";
     				break;
     			case 2: 
     				tbClass = "tbemhigienizacao";
     				break;
     			case 3: 
     				tbClass = "tblivre";
     				break;
     			case 4: 
     				tbClass = "tbocupado";
     				break;
     			case 5: 
     				tbClass = "tbreservado";
     				break;
     		}
     		if ((coAla != l.getCodigoAla()) && (coAla == 0)){
     			coAla = l.getCodigoAla();
     			contador = 0;
%>
<h3>Ala: <%=l.getDescricaoAla() %></h3>
<div>
	<table width="100%">
<%
     		}
     		else if ((coAla != l.getCodigoAla()) && (coAla > 0)){
     			coAla = l.getCodigoAla();
      			if ((contador < 5) && (contador > 0)){
      				for (int j = contador; j <= 4 ; j++) {
%>
		<td width="20%"></td>
<%
      				}
%>
	</tr>
<%
      			}
      		contador = 0;
%>
	</table>
</div>
<h3>Ala <%=l.getDescricaoAla() %></h3>
<div>
	<table width="100%">
<%			
     		}
     		contador = contador + 1;
   	  		if (contador == 1){
%>
	<tr>
<%
    	  	}
%>
		<td width="20%">
    		<table class="<%=tbClass%>">
				<thead>
					<tr>
						<th colspan="3">Leito: <%=l.getCodigoLeito() %></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td align="right">Status:</td>
						<td align="left"><font style="font-weight: bold;"><%=l.getDescricaoStatusLeito() %></font></td>
						<td align="right"><button onclick="liberarLeito(<%=l.getCodigoLeito() %>, <%=l.getCodigoStatusLeito() %>)" <%if (l.getCodigoStatusLeito() != 2){ %>disabled<%} %>><img src="_imagens/icones/16X16/apply.gif"><font style="font-weight: bold;">LIBERAR</font></button></td>
					</tr>
					<tr>
						<td align="right" colspan="3"><button onclick="desbloquearLeito(<%=l.getCodigoLeito() %>, <%=l.getCodigoStatusLeito() %>)" <%if (l.getCodigoStatusLeito() != 1){ %>disabled<%} %>><img src="_imagens/icones/16X16/unlock.gif"><font style="font-weight: bold;">DESBLOQUEAR</font></button>&nbsp;<button onclick="bloquearLeito(<%=l.getCodigoLeito() %>, <%=l.getCodigoStatusLeito() %>)" <%if ((l.getCodigoStatusLeito() == 1) || (l.getCodigoStatusLeito() == 4)){ %>disabled<%} %>><img src="_imagens/icones/16X16/lock.gif"><font style="font-weight: bold;">BLOQUEAR</font></button></td>
					</tr>
				</tbody>
			</table>
		</td>
<%
			if (contador == 5){
				contador = 0;
%>
	</tr>
<%
			}
      	}
		if ((contador < 5) && (contador > 0)){
			for (int j = contador; j <= 4 ; j++) {
%>
			<td width="20%"></td>
<%
			}
%>
	</tr>
<%
		}
%>
	</table>	
</div>
<%
   	}catch (Exception e) {  
	      e.printStackTrace();  
	}
%>
</div>