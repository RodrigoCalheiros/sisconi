<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Internacao"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="internacao" class="model.Internacao"/>
<%
	String pDsAlta = request.getParameter("ds_alta");
	String pStringCoInternacao = request.getParameter("hidden_co_internacao");
	int pCoInternacao = Integer.parseInt(pStringCoInternacao);
    
	internacao.setCodigoInternacao(pCoInternacao);
	internacao.setDescricaoDaAlta(pDsAlta);
    
	boolean retorno = internacao.darAlta();
	if (retorno == true){
		response.sendRedirect("internacao_dar_alta.jsp?msg='Alta cadastrada com sucesso.'");
	}
	else{
		response.sendRedirect("internacao_dar_alta.jsp?msg='Erro ao cadastrar a alta.'");
	}
%>