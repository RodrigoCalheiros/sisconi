<%@ page contentType="text/html" language="java" import="java.util.*, model.Paciente"%>
 <jsp:useBean id="paciente" class="model.Paciente"/> 
<%
	String pNrCpf = request.getParameter("nr_cpf");	
	boolean existeCpfPaciente = paciente.existeCpfPaciente(pNrCpf);
%>
<%= existeCpfPaciente%>