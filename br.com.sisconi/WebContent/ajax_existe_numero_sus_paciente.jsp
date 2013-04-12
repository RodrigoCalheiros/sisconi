<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html" language="java" import="java.util.*, model.Paciente"%>
 <jsp:useBean id="paciente" class="model.Paciente"/> 
<%
	int retorno = 0;
	String pNrSus = request.getParameter("nr_sus");	
	boolean existeNumeroSusPaciente = paciente.existeNumeroSusPaciente(pNrSus);
	if (existeNumeroSusPaciente == true){
		retorno = 1;
	}
%>
<%= retorno%>