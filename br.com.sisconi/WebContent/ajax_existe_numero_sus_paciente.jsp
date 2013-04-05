<%@ page contentType="text/html" language="java" import="java.util.*, model.Paciente"%>
 <jsp:useBean id="paciente" class="model.Paciente"/> 
<%
	String pNrSus = request.getParameter("nr_sus");	
	boolean existeNumeroSusPaciente = paciente.existeNumeroSusPaciente(pNrSus);
%>
<%= existeNumeroSusPaciente%>