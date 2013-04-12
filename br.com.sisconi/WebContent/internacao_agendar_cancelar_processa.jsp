<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Agendamento"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="agendamento" class="model.Agendamento"/>
<%
	String pStringCoAgendamento = request.getParameter("hidden_co_agendamento");
	int pCoAgendamento = Integer.parseInt(pStringCoAgendamento);
    
	agendamento.setCodigoAgendamento(pCoAgendamento);
    
	boolean retorno = agendamento.cancelarAgendamento();
	if (retorno == true){
		response.sendRedirect("internacao_agendar_cancelar.jsp?msg='Agendamento cancelado com sucesso.'");
	}
	else{
		response.sendRedirect("internacao_agendar_cancelar.jsp?msg='Erro ao cancelar o agendamento.'");
	}
%>