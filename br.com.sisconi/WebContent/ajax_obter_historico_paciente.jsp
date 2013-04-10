<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html" language="java" import="java.util.*, model.Estado, model.Internacao, model.Paciente"%>
 <jsp:useBean id="internacao" class="model.Internacao"/> 
 <jsp:useBean id="paciente" class="model.Paciente"/> 
<%
	String pStringCoPaciente = request.getParameter("co_paciente");
	int pCoPaciente = Integer.parseInt(pStringCoPaciente);
	String pNrCpf = request.getParameter("nr_cpf");
	String pNrSus = request.getParameter("nr_sus");	
	
	paciente.setCodigoPaciente(pCoPaciente);
	paciente.setCpf(pNrCpf);
	paciente.setNumeroSus(pNrSus);
	
	List<Internacao> lInternacao = internacao.getHistoricoInternacao(paciente);
%>
<script>
  $(function() {
	  $( "#accordion" ).accordion();
	  obterStatusLeitos();
  });
</script>
<input type="hidden" id="hidden_co_paciente" name="hidden_co_paciente" value="<%=paciente.getCodigoPaciente()%>">
<input type="hidden" id="hidden_nr_sus" name="hidden_nr_sus" value="<%=paciente.getNumeroSus()%>">
<input type="hidden" id="hidden_nr_cpf" name="hidden_nr_cpf" value="<%=paciente.getCpf()%>">
<div id="accordion">
<%
	for (int i=0; i < lInternacao.size(); i++) {
     		Internacao inter = lInternacao.get(i);
%>
<h3>Internação: <%=inter.getDataInicial() %></h3>
<div>
<%=inter.getPaciente().getNome() %>
</div>
<%
	}
%>
</div>








