<%@ page contentType="text/html" language="java" import="java.util.*, model.Paciente"%>
 <jsp:useBean id="paciente" class="model.Paciente"/> 
<%
	String pNrSus = request.getParameter("nr_sus");	
	paciente.setNumeroSus(pNrSus);
	paciente = paciente.localizarPaciente();
%>
<table border="0" cellpadding="0" cellspacing="8">
	<tr>
		<td align="left" colspan="2">Dados Pessoais</td>
	</tr>
	<tr>
		<td align="right">Nome:</td>
		<td align="left"><%=paciente.getNome()%></td>
	</tr>
	<tr>
		<td align="right">Nome da Mãe:</td>
		<td align="left"><%=paciente.getNomeMae()%></td>
	</tr>
	<tr>
		<td align="right">CPF:</td>
		<td align="left"><%=paciente.getCpf()%></td>
	</tr>
	<tr>
		<td align="right">Número do SUS:</td>
		<td align="left"><%=paciente.getNumeroSus()%></td>
	</tr>
	<tr>
		<td align="right">Telefone:</td>
		<td align="left"><%=paciente.getNumeroTelefone()%></td>
	</tr>
	<tr>
		<td align="right">Data de Nascimento:</td>
		<td align="left"><%=paciente.getDataNascimento()%></td>
	</tr>
	<tr>
		<td align="left" colspan="2">Endereço</td>
	</tr>
	<tr>
		<td align="right">Rua:</td>
		<td align="left"><%=paciente.getEnderecoRua()%></td>
	</tr>
	<tr>
		<td align="right">Número:</td>
		<td align="left"><%=paciente.getEnderecoNumero()%></td>
	</tr>
	<tr>
		<td align="right">Complemento:</td>
		<td align="left"><%=paciente.getEnderecoComplemento()%></td>
	</tr>
	<tr>
		<td align="right">Bairro:</td>
		<td align="left"><%=paciente.getEnderecoBairro()%></td>
	</tr>
	<tr>
		<td align="right">CEP:</td>
		<td align="left"><%=paciente.getEnderecoCEP()%></td>
	</tr>
	<tr>
		<td align="right">Estado:</td>
		<td align="left"><%=paciente.getEnderecoEstado()%></td>
	</tr>
	<tr>
		<td align="right">Cidade:</td>
		<td align="left"><%=paciente.getEnderecoCidade()%></td>
	</tr>
</table>