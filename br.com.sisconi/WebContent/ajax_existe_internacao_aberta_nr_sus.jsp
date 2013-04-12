<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html" language="java" import="java.util.*, model.Internacao"%>
 <jsp:useBean id="internacao" class="model.Internacao"/> 
<%
	int retorno = 0;
	String pNrSus = request.getParameter("nr_sus");	
	boolean existeInternacaoNrSusPaciente = internacao.verificaPacienteInternado(pNrSus);
	if (existeInternacaoNrSusPaciente){
		retorno = 1;
	}
%>
<%= retorno%>