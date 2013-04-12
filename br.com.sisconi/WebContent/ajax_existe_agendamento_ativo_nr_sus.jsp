<%@ page contentType="text/html" language="java" import="java.util.*, model.Agendamento"%>
 <jsp:useBean id="agendamento" class="model.Agendamento"/> 
<%
	int retorno = 0;
	String pNrSus = request.getParameter("nr_sus");	
	boolean existeAgendamentoNrSusPaciente = agendamento.verificaPacienteAgendado(pNrSus);
	if (existeAgendamentoNrSusPaciente){
		retorno = 1;
	}
%>
<%= retorno%>