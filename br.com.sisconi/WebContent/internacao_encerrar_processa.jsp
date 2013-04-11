<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Internacao"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="internacao" class="model.Internacao"/>
<%
	String pStringCoInternacao = request.getParameter("hidden_co_internacao");
	int pCoInternacao = Integer.parseInt(pStringCoInternacao);
    
	internacao.setCodigoInternacao(pCoInternacao);
    
	boolean retorno = internacao.encerrarInternacao();
	if (retorno == true){
		response.sendRedirect("internacao_encerrar.jsp?msg='Internação encerrada com sucesso.'");
	}
	else{
		response.sendRedirect("internacao_encerrar.jsp?msg='Erro ao encerrar a internação.'");
	}
%>