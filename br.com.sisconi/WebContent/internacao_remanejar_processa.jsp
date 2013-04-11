<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Internacao"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="internacao" class="model.Internacao"/>
<jsp:useBean id="leito" class="model.Leito"/>
<%
	String pStringCoInternacao = request.getParameter("hidden_co_internacao");
	int pCoInternacao = Integer.parseInt(pStringCoInternacao);
	String pStringCoLeito = request.getParameter("co_leito");
	int pCoLeito = Integer.parseInt(pStringCoLeito);
	
	internacao.setCodigoInternacao(pCoInternacao);
    
	boolean retorno = internacao.remanejarInternacao(pCoLeito);
	if (retorno == true){
		response.sendRedirect("internacao_remanejar.jsp?msg='Internação remanejada com sucesso.'");
	}
	else{
		response.sendRedirect("internacao_remanejar.jsp?msg='Erro ao remanejar a internação.'");
	}
%>