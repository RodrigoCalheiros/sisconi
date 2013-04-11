<%@ page contentType="text/html" language="java" import="java.util.*, model.Internacao"%>
 <jsp:useBean id="internacao" class="model.Internacao"/> 
<%
	int retorno = 0;
	String pNrSus = request.getParameter("nr_sus");	
	boolean existeInternacaoNrSusPaciente = internacao.ver(pNrSus);
	if (existeInternacaoNrSusPaciente){
		retorno = 1;
	}
%>
<%= retorno%>