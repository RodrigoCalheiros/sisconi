<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Medico, model.Agendamento"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="agendamento" class="model.Agendamento"/>
<%
	String pNrSus = request.getParameter("nr_sus");	

	Agendamento agend = agendamento.getAgendamento(pNrSus);
	if (agend.getCodigoAgendamento() > 0){
		Date dtAgendamento = null;
		String strDtAgendamento = "";
		java.text.DateFormat dateformat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		if(agend.getDataAgendamento() != null){
			dtAgendamento = agend.getDataAgendamento();
			strDtAgendamento = dateformat.format(dtAgendamento);
		}
%>
<script>
  $(function() {
	  $( "#radio" ).buttonset();
  });
</script>
<input type="hidden" id="hidden_co_agendamento" name="hidden_co_agendamento" value="<%=agend.getCodigoAgendamento()%>">
<table class="tbl" width="100%">
<thead>
	<tr>
		<th colspan="2">Informações do Agendamento</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td align="right" width="180px">Status:</td>
		<td align="left"><input type="text" id="ds_status_agendamento" name="ds_status_agendamento" maxlength="10" size="50" value="<%=agend.getStatusAgendamento()%>"></td>
	</tr>
	<tr>
		<td align="right" width="180px">Nome:</td>
		<td align="left"><input type="text" id="nm_paciente" name="nm_paciente" maxlength="50" size="50" value="<%=agend.getPaciente().getNome()%>"></td>
	</tr>
	<tr>
		<td align="right" width="180px">Nome da Mãe:</td>
		<td align="left"><input type="text" id="nm_mae" name="nm_mae" maxlength="50" size="50" value="<%=agend.getPaciente().getNomeMae()%>"></td>
	</tr>
	<tr>
		<td align="right" width="180px">Data Agendamento:</td>
		<td align="left"><input type="text" id="dt_agendamento" name="dt_agendamento" maxlength="10" size="50" value="<%=strDtAgendamento%>"></td>
	</tr>
	<tr>
		<td align="right">Ala:</td>
		<td align="left"><input type="text" id="ds_ala" name="ds_ala" maxlength="50" size="50" value="<%=agend.getLeito().getDescricaoAla()%>"></td>
	</tr>
	<tr>
		<td align="right" valign="top">Leito:</td>
		<td align="left"><input type="text" id="co_leito" name="co_leito" maxlength="50" size="50" value="<%=agend.getLeito().getCodigoLeito()%>"></td>
	</tr>
	<tr>
		<td align="right" valign="top">Médico:</td>
		<td align="left">
		<div id="radio">
			<input type="radio" class="radio" id="radio_medico" name="radio_medico" value="<%=agend.getMedico().getCodigoUsuario() %>" />
			<label for="radio_medico">
				<%=agend.getMedico().getNome() %><br>
				CRM:<%=agend.getMedico().getCrm() %><br>
			</label>
		</div>
		</td>
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






