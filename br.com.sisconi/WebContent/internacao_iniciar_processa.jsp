<%@include file="inc_verifica_acesso_usuario.jsp"%>
<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Internacao, model.Medico"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="internacao" class="model.Internacao"/>
<jsp:useBean id="paciente" class="model.Paciente"/>
<jsp:useBean id="leito" class="model.Leito"/>
<%
	String pNrSus = request.getParameter("hidden_nr_sus");

	String pStringCoPaciente = request.getParameter("hidden_co_paciente");
	int pCoPaciente = Integer.parseInt(pStringCoPaciente);

	String pStringCoLeito = request.getParameter("co_leito");
	int pCoLeito = Integer.parseInt(pStringCoLeito);
	
	String pStringCoMedicos = request.getParameter("hidden_co_medicos");
    String[] pCoMedicos = pStringCoMedicos.split("_");
    String pStringCoMedico = "";
    int pCoMedico = 0;

    
    paciente.setCodigoPaciente(pCoPaciente);
    leito.setCodigoLeito(pCoLeito);
    List<Medico> listaMedico = new ArrayList();
    
    for(int i=0;i<pCoMedicos.length;i++)
    {
    	Medico m = new Medico();
    	pStringCoMedico = pCoMedicos[i];
    	pCoMedico = Integer.parseInt(pStringCoMedico);
    	m.setCodigoUsuario(pCoMedico);
    	listaMedico.add(i, m);
    }
    
    internacao.setPaciente(paciente);
    internacao.setLeito(leito);
    internacao.setListaMedico(listaMedico);
    
	boolean retorno = internacao.iniciarInternacao();
	if (retorno == true){
		response.sendRedirect("internacao_iniciar.jsp?msg='Internação do paciente com número do SUS " + pNrSus + " cadastrada com sucesso.'");
	}
	else{
		response.sendRedirect("internacao_iniciar.jsp?msg='Erro ao cadastrar a internação.'");
	}
 
%>