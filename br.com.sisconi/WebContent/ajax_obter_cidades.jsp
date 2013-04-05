<%@ page contentType="text/html" language="java" import="java.sql.*, java.util.*, model.Cidade"%>
 <jsp:useBean id="paciente" class="model.Paciente"/> 
<%
	String parametroCodigoEstado = request.getParameter("codigoEstado");	
	int codigoEstado = Integer.parseInt(parametroCodigoEstado);
%>
<select id="co_cidade" name="co_cidade" required>
<%      
   try {  
      List<Cidade> lci = paciente.getCidades(codigoEstado);    
        
      for (int i=0; i<lci.size(); i++) {
    	  Cidade cidade = lci.get(i);
%>
    	  <option value=<%=cidade.getCodigoCidade()%>><%=cidade.getNomeCidade()%></option>
<%
      }
   }catch (Exception e) {  
	      e.printStackTrace();  
	}
%>
</select>