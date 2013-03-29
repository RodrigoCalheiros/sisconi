<%@ page contentType="text/html" language="java" import="java.util.*"%>
<%	
	session.invalidate();
	//response.sendRedirect("login.jsp");
%>
<%=session.getAttribute("co_usuario")%>