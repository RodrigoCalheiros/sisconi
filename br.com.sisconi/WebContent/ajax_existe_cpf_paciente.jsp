<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html" language="java" import="java.util.*, model.Paciente"%>
 <jsp:useBean id="paciente" class="model.Paciente"/> 
<%
	int retorno = 0;
	String pNrCpf = request.getParameter("nr_cpf");	
	boolean existeCpfPaciente = paciente.existeCpfPaciente(pNrCpf);
	if (existeCpfPaciente){
		retorno = 1;
	}
%>
<%=retorno%>