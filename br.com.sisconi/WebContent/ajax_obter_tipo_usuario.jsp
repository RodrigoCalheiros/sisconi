<%@ page contentType="text/html" language="java" import="java.util.*, model.Usuario"%>
 <jsp:useBean id="usuario" class="model.Usuario"/> 
<%
	String pNrCpf = request.getParameter("nrCpf");
	pNrCpf = pNrCpf.replace(".", "");
	pNrCpf = pNrCpf.replace("-", "");
	try {  
		List<String[]> listTipoUsuario = usuario.getTipoUsuario(pNrCpf); 
%>
<select id="co_tipo_usuario" name="co_tipo_usuario">
<%
	    for (int i=0; i<listTipoUsuario.size(); i++) {
%>
	   <option value=<%=listTipoUsuario.get(i)[0]%>><%=listTipoUsuario.get(i)[1]%></option>
<%
	    }
	   }catch (Exception e) {  
		      e.printStackTrace();  
		}
%>
</select>