<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, java.text.SimpleDateFormat, model.Paciente"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="paciente" class="model.Paciente"/> 
<%
	String pNmPaciente = request.getParameter("nm_paciente");
	String pNmMae = request.getParameter("nm_mae");
	String pNrCpf = request.getParameter("nr_cpf");
	String pNrSus = request.getParameter("nr_sus");
	String pStringDtNascimento = request.getParameter("dt_nascimento");	
	Date pDtNascimento = new SimpleDateFormat("dd/MM/yyyy").parse(pStringDtNascimento);
	String pNrTelefone = request.getParameter("nr_telefone");
	String pDsRua = request.getParameter("ds_rua");
	String pStringDsNumero = request.getParameter("ds_numero");
	int pDsNumero = Integer.parseInt(pStringDsNumero);
	String pDsBairro = request.getParameter("ds_bairro");
	String pDsCep = request.getParameter("ds_cep");
	String pDsComplemento = request.getParameter("ds_complemento");
	String pStringCoCidade = request.getParameter("co_cidade");
	int pCoCidade = Integer.parseInt(pStringCoCidade);
	
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
	
	boolean retorno = paciente.cadastrarPaciente();
	if (retorno == true){
		response.sendRedirect("paciente_cadastrar.jsp?msg='Paciente " + pNmPaciente + " foi Cadastrado com sucesso.'");
	}
	else{
		response.sendRedirect("paciente_cadastrar.jsp?msg='Erro ao cadastrar o paciente.'");
	}
%>