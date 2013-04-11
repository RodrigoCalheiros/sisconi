<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html" language="java" import="java.util.*, model.Internacao, model.Medico"%>
 <jsp:useBean id="internacao" class="model.Internacao"/> 
 <jsp:useBean id="paciente" class="model.Paciente"/> 
<%
	String pStringCoPaciente = request.getParameter("co_paciente");
	int pCoPaciente = Integer.parseInt(pStringCoPaciente);
	String pNrCpf = request.getParameter("nr_cpf");
	String pNrSus = request.getParameter("nr_sus");	
	
	List<Internacao> lInternacao = internacao.getHistoricoInternacao(pCoPaciente);
%>

<input type="hidden" id="hidden_co_paciente" name="hidden_co_paciente" value="<%=pCoPaciente%>">
<input type="hidden" id="hidden_nr_sus" name="hidden_nr_sus" value="<%=pNrSus%>">
<input type="hidden" id="hidden_nr_cpf" name="hidden_nr_cpf" value="<%=pNrCpf%>">
<div id="accordion">
<%
	for (int i=0; i < lInternacao.size(); i++) {
     		Internacao inter = lInternacao.get(i);
     		Date dtInicial = null;
     		Date dtFinal = null;
     		String strDtInicial = "";
     		String strDtFinal = "";
     		java.text.DateFormat dateformat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
     		if(inter.getDataInicial() != null){
     			dtInicial = inter.getDataInicial();
     			strDtInicial = dateformat.format(dtInicial);
     		}
     		if(inter.getDataFinal() != null){
     			dtFinal = inter.getDataFinal();
     			strDtFinal = dateformat.format(dtFinal);
     		}
     		String dsAlta = "";
     		if (inter.getDescricaoDaAlta() != null){
     			dsAlta = inter.getDescricaoDaAlta();
     		}
%>
<h3>Internação: <%=dateformat.format(dtInicial)%></h3>
<div>
<table class="tbl" width="100%">
<thead>
	<tr>
		<th colspan="2">Informações da Internação</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td align="right" width="180px">Data Inicial:</td>
		<td align="left"><input type="text" id="dt_inicial" name="dt_inicial" maxlength="10" size="50" value="<%=strDtInicial%>" disabled="disabled"></td>
	</tr>
	<tr>
		<td align="right">Data Final:</td>
		<td align="left"><input type="text" id="dt_final" name="dt_final" maxlength="10" size="50" value="<%=strDtFinal%>" disabled="disabled"></td>
	</tr>
	<tr>
		<td align="right">Ala:</td>
		<td align="left"><input type="text" id="co_leito" name="co_leito" maxlength="10" size="50" value="<%=inter.getLeito().getDescricaoAla()%>" disabled="disabled"></td>
	</tr>
	<tr>
		<td align="right" valign="top">Leito:</td>
		<td align="left"><input type="text" id="co_leito" name="co_leito" maxlength="10" size="50" value="<%=inter.getLeito().getCodigoLeito()%>" disabled="disabled"></td>
	</tr>
	<tr>
		<td align="right" valign="top">Médico:</td>
		<td align="left">
		<div class="checkbox">
		<%      
		 	List<Medico> lMedico = inter.getListaMedico();
		   	for (int j=0; j<lMedico.size(); j++) {
		   		Medico m = lMedico.get(j);
		%>
							<input type="checkbox" id="cb_medico_<%=m.getCodigoUsuario()%>_<%=inter.getCodigoInternacao() %>" disabled="disabled" />
							<label for="cb_medico_<%=m.getCodigoUsuario()%>_<%=inter.getCodigoInternacao() %>">
								<%=m.getNome()%><br>
								CRM:<%=m.getCrm()%><br>
							</label>
				<%
			  }
		%>
		</div>
		</td>
	</tr>
	<tr>
		<td align="right" valign="top">Alta:</td>
		<td align="left"><%if (dsAlta != ""){%><textarea id="ds_alta" name="ds_alta" maxlength="2000"  disabled="disabled"><%=dsAlta %></textarea><%}else{%>--<%}%></td>
	</tr>
</tbody>
</table>
</div>
<%
	}
%>
</div>








