<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html" language="java" import="java.text.SimpleDateFormat, java.util.*, model.Leito"%>
 <jsp:useBean id="leito" class="model.Leito"/> 
<%
	String parametroCoAla = request.getParameter("co_ala");	
	int coAla = Integer.parseInt(parametroCoAla);
	String pStringDtAgendamento = request.getParameter("dt_agendamento");	
	Date pDtAgendamento = new SimpleDateFormat("dd/MM/yyyy").parse(pStringDtAgendamento);
%>
<select id="co_leito" name="co_leito" required>
<%      
   try {  
      List<Leito> lLeito = leito.getLeitosLivresAgendamento(pDtAgendamento, coAla);    
        
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