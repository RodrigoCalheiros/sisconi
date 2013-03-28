<%@ page contentType="text/html" language="java" import="java.util.*, model.Usuario"%>
 <jsp:useBean id="usuario" class="model.Usuario"/> 
<%
	String pNrCpf = request.getParameter("nr_cpf");
	pNrCpf = pNrCpf.replace(".", "");
	pNrCpf = pNrCpf.replace("-", "");
	String pDsSenha = request.getParameter("ds_senha");
	String parametroCodigoTipoUsuario = request.getParameter("co_tipo_usuario");
	int pCoTipoUsuario = Integer.parseInt(parametroCodigoTipoUsuario);
	Usuario usu = usuario.efetuarLogin(pNrCpf, pDsSenha, pCoTipoUsuario);
	if (usu.getCodigoUsuario() > 0){
		session.setAttribute( "co_usuario", usu.getCodigoUsuario());
		session.setAttribute( "nr_cpf", usu.getCpf());
		session.setAttribute( "nm_usuario", usu.getNome());
		session.setAttribute( "co_tipo_usuario", usu.getTipoUsuario().getCodigoTipoUsuario());
		session.setAttribute( "ds_tipo_usuario", usu.getTipoUsuario().getDescricaoTipoUsuario());
		response.sendRedirect("inicio.jsp");  
	}
	else{
		response.sendRedirect("login.jsp");
	}
%>