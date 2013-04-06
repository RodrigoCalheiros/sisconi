<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, java.text.SimpleDateFormat, model.Paciente"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="paciente" class="model.Paciente"/> 
<%
	String pStringCoPaciente = request.getParameter("hidden_co_paciente");
	int pCoPaciente = Integer.parseInt(pStringCoPaciente);
	String pNmPaciente = request.getParameter("nm_paciente");
	String pNrSus = request.getParameter("nr_sus");
	String pNmMae = request.getParameter("nm_mae");
	String pStringDtNascimento = request.getParameter("dt_nascimento");	
	String pNrCpf = request.getParameter("nr_cpf");
	Date pDtNascimento = new SimpleDateFormat("dd/MM/yyyy").parse(pStringDtNascimento);
	String pNrTelefone = request.getParameter("nr_telefone");
	String pDsRua = request.getParameter("ds_rua");
	String pStringDsNumero = request.getParameter("ds_numero");
	int pDsNumero = Integer.parseInt(pStringDsNumero);
	String pDsComplemento = request.getParameter("ds_complemento");
	String pDsBairro = request.getParameter("ds_bairro");
	String pDsCep = request.getParameter("ds_cep");
	int pCoCidade = 0;
	String pStringCoCidade = request.getParameter("hidden_co_cidade");
	pCoCidade = Integer.parseInt(pStringCoCidade);
	
	paciente.setCodigoPaciente(pCoPaciente);
	paciente.setNome(pNmPaciente);
	paciente.setNomeMae(pNmMae);
	paciente.setCpf(pNrCpf);
	paciente.setNumeroSus(pNrSus);
	paciente.setDataNascimento(pDtNascimento);
	paciente.setNumeroTelefone(pNrTelefone);
	paciente.setEnderecoRua(pDsRua);
	paciente.setEnderecoNumero(pDsNumero);
	paciente.setEnderecoBairro(pDsBairro);
	paciente.setEnderecoCEP(pDsCep);
	paciente.setEnderecoComplemento(pDsComplemento);
	paciente.setEnderecoCodigoCidade(pCoCidade);
	
	boolean retorno = paciente.atualizarPaciente();
	
	if (retorno == true){
		response.sendRedirect("paciente_localizar.jsp?msg='O Paciente " + pNmPaciente + " foi atualizado com sucesso.'");
	}
	else{
		response.sendRedirect("paciente_localizar.jsp?msg='Erro ao atualizar os dados do paciente.'");
	}
%>