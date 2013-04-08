<%@ page contentType="text/html" language="java" import="java.sql.*, java.util.*, model.Leito"%>
 <jsp:useBean id="leito" class="model.Leito"/> 
<table width="100%">
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
      	for (int i=0; i < lLeito.size(); i++) {
    	  	Leito l = lLeito.get(i);
    	  	contador = contador + 1;
    	  	if (contador == 1){
%>
	<tr>
<%
    	  	}
%>
		<td>
    		<table class="tbl">
				<thead>
					<tr>
						<th colspan="2">Leito <%=l.getCodigoLeito() %></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td align="right">Nome:</td>
						<td align="left"><input type="text" id="nm_paciente" name="nm_paciente" maxlength="70" size="50" placeholder="Insira o nome do paciente" required></td>
					</tr>
				</tbody>
			</table>
		</td>
<%
			if (contador == 3){
				contador = 0;
%>
	</tr>
<%
			}
      	}
      	if ((contador < 3) && (contador > 0)){
      		for (int i=contador; i <= 3 ; i++) {
%>
	<tr>
		<td></td>
	</tr>
<%
      		}
      	}
   	}catch (Exception e) {  
	      e.printStackTrace();  
	}
%>
</table>