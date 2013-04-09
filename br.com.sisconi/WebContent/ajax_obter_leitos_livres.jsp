<%@ page contentType="text/html" language="java" import="java.sql.*, java.util.*, model.Leito"%>
 <jsp:useBean id="leito" class="model.Leito"/> 
<%
	String parametroCoAla = request.getParameter("co_ala");	
	int coAla = Integer.parseInt(parametroCoAla);
%>
<select id="co_leito" name="co_leito" required>
<%      
   try {  
      List<Leito> lLeito = leito.getLeitosLivres();    
        
      for (int i=0; i<lLeito.size(); i++) {
    	  Leito l = lLeito.get(i);
%>
    	  <option value="<%=l.getCodigoLeito()%>"><%=l.getCodigoLeito()%></option>
<%
      }
   }catch (Exception e) {  
	      e.printStackTrace();  
	}
%>
</select>