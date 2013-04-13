<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*,  java.text.SimpleDateFormat, model.Agendamento, model.Leito, model.Paciente, model.Medico"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="agendamento" class="model.Agendamento"/>
<%
	String pNrSus = request.getParameter("hidden_nr_sus");

	String pStringCoPaciente = request.getParameter("hidden_co_paciente");
	int pCoPaciente = Integer.parseInt(pStringCoPaciente);

	String pStringCoLeito = request.getParameter("co_leito");
	int pCoLeito = Integer.parseInt(pStringCoLeito);
	
	String pStringCoMedico = request.getParameter("hidden_co_medico");
    int pCoMedico = Integer.parseInt(pStringCoMedico);
    
    String pStringDtAgendamento = request.getParameter("dt_agendamento");	
	Date pDtAgendamento = new SimpleDateFormat("dd/MM/yyyy").parse(pStringDtAgendamento);

	
    Paciente paciente = new Paciente();
	paciente.setCodigoPaciente(pCoPaciente);
	
	Leito leito = new Leito();
	leito.setCodigoLeito(pCoLeito);
	
	Medico medico = new Medico();
	medico.setCodigoUsuario(pCoMedico);
	
    agendamento.setPaciente(paciente);
    agendamento.setLeito(leito);
    agendamento.setMedico(medico);
    agendamento.setDataAgendamento(pDtAgendamento);
    
 	boolean retorno = agendamento.efetuarAgendamento();
 	if (retorno == true){
		response.sendRedirect("internacao_agendar.jsp?msg='Agendamento de internação do paciente com número de SUS " + pNrSus + " cadastrado com sucesso.'");
	}
	else{
		response.sendRedirect("internacao_agendar.jsp?msg='Erro ao cadastrar o agendamento da internação.'");
	}
 
%>