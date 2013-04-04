<% 
	if (session.getAttribute("co_usuario") == null){
		response.sendRedirect("login.jsp");
	}
%>