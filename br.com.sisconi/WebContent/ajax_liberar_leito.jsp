<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html" language="java" import="java.sql.*, java.util.*, model.Leito"%>
<jsp:useBean id="leito" class="model.Leito"/>
<%
	String pStringCoLeito = request.getParameter("co_leito");	
	int coLeito = Integer.parseInt(pStringCoLeito);
	String pStringCoStatus = request.getParameter("co_status");	
	int coStatus = Integer.parseInt(pStringCoStatus);
	leito.setCodigoLeito(coLeito);
	leito.setCodigoStatusLeito(coStatus);
	boolean retorno = leito.liberarLeito();
%>
<%=retorno%>