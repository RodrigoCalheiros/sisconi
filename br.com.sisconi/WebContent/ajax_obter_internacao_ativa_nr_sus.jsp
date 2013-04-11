<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Medico, model.Internacao"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="internacao" class="model.Internacao"/>
<%
	String pNrSus = request.getParameter("nr_sus");	

	Internacao inter = internacao.getInternacaoAtiva(pNrSus);
	if (inter.getCodigoInternacao() > 0){
		List<Medico> lMedico = inter.getListaMedico();
		
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
<script>
  $(function() {
	  $( ".checkbox" ).buttonset();
  });
</script>
<input type="hidden" id="hidden_co_internacao" name="hidden_co_internacao" value="<%=inter.getCodigoInternacao()%>">
<table class="tbl" width="100%">
<thead>
	<tr>
		<th colspan="2">Informações da Internação</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td align="right" width="180px">Nome:</td>
		<td align="left"><input type="text" id="nm_paciente" name="nm_paciente" maxlength="10" size="50" value="<%=inter.getPaciente().getNome()%>"></td>
	</tr>
	<tr>
		<td align="right" width="180px">Nome da Mãe:</td>
		<td align="left"><input type="text" id="nm_mae" name="nm_mae" maxlength="10" size="50" value="<%=inter.getPaciente().getNomeMae()%>"></td>
	</tr>
	<tr>
		<td align="right" width="180px">Data Inicial:</td>
		<td align="left"><input type="text" id="dt_inicial" name="dt_inicial" maxlength="10" size="50" value="<%=strDtInicial%>"></td>
	</tr>
	<tr>
		<td align="right">Data Final:</td>
		<td align="left"><input type="text" id="dt_final" name="dt_final" maxlength="10" size="50" value="<%=strDtFinal%>"></td>
	</tr>
	<tr>
		<td align="right">Ala:</td>
		<td align="left"><input type="text" id="ds_ala_atual" name="ds_ala_atual" maxlength="10" size="50" value="<%=inter.getLeito().getDescricaoAla()%>"></td>
	</tr>
	<tr>
		<td align="right" valign="top">Leito:</td>
		<td align="left"><input type="text" id="co_leito_atual" name="co_leito_atual" maxlength="10" size="50" value="<%=inter.getLeito().getCodigoLeito()%>"></td>
	</tr>
	<tr>
		<td align="right" valign="top">Médico:</td>
		<td align="left">
		<div class="checkbox">
		<%      
		   	for (int j=0; j<lMedico.size(); j++) {
		   		Medico m = lMedico.get(j);
		%>
							<input type="checkbox" class="checkbox" id="cb_medico_<%=m.getCodigoUsuario()%>_<%=inter.getCodigoInternacao() %>"/>
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
		<td align="left"><textarea id="ds_alta" name="ds_alta" maxlength="2000"><%=dsAlta%></textarea></td>
	</tr>
</tbody>
</table>
<%
	}
	else{
%>
<%=0%>
<%
	}
%>






