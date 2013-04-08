<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Leito"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="leito" class="model.Leito"/> 
<%
	String pStringCoPatrimonio = request.getParameter("co_patrimonio");
	int pCoPatrimonio = Integer.parseInt(pStringCoPatrimonio);
	String pStringCoAla = request.getParameter("co_ala");
	int pCoAla = Integer.parseInt(pStringCoAla);
	
	leito.setCodigoPatrimonio(pCoPatrimonio);
	leito.setCodigoAla(pCoAla);
	
	boolean retorno = leito.cadastrarLeito();
	if (retorno == true){
		response.sendRedirect("leito_cadastrar.jsp?msg='Leito " + pCoPatrimonio + " cadastrado com sucesso.'");
	}
	else{
		response.sendRedirect("leito_cadastrar.jsp?msg='Erro ao cadastrar o leito.'");
	}
%>