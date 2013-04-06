<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html" language="java" import="java.util.*, model.Paciente"%>
 <jsp:useBean id="paciente" class="model.Paciente"/> 
<%
	String pNrSus = request.getParameter("nr_sus");	
	paciente.setNumeroSus(pNrSus);
	paciente = paciente.localizarPaciente();
	Date dtNascimento = paciente.getDataNascimento();
	java.text.DateFormat dateformat = new java.text.SimpleDateFormat("dd/MM/yyyy");
%>
<table class="tbl">
	<thead>
		<tr>
			<th colspan="2">Dados Pessoais</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td align="right" width="180px">Nome:</td>
			<td align="left"><font style="font-weight: bold;"><%=paciente.getNome()%></font></td>
		</tr>
		<tr>
			<td align="right">Nome da Mãe:</td>
			<td align="left"><font style="font-weight: bold;"><%=paciente.getNomeMae()%></font></td>
		</tr>
		<tr>
			<td align="right">CPF:</td>
			<td align="left"><font style="font-weight: bold;"><%=paciente.getCpf()%></font></td>
		</tr>
		<tr>
			<td align="right">Número do SUS:</td>
			<td align="left"><font style="font-weight: bold;"><%=paciente.getNumeroSus()%></font></td>
		</tr>
		<tr>
			<td align="right">Telefone:</td>
			<td align="left"><font style="font-weight: bold;"><%=paciente.getNumeroTelefone()%></font></td>
		</tr>
		<tr>
			<td align="right">Data de Nascimento:</td>
			<td align="left"><font style="font-weight: bold;"><%=dateformat.format(dtNascimento)%></font></td>
		</tr>
	</tbody>
</table>
<br>
<table class="tbl">
	<thead>
		<tr>
			<th colspan="2">Endereço</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td align="right" width="180px">Rua:</td>
			<td align="left"><font style="font-weight: bold;"><%=paciente.getEnderecoRua()%></font></td>
		</tr>
		<tr>
			<td align="right">Número:</td>
			<td align="left"><font style="font-weight: bold;"><%=paciente.getEnderecoNumero()%></font></td>
		</tr>
		<tr>
			<td align="right">Complemento:</td>
			<td align="left"><font style="font-weight: bold;"><%=paciente.getEnderecoComplemento()%></font></td>
		</tr>
		<tr>
			<td align="right">Bairro:</td>
			<td align="left"><font style="font-weight: bold;"><%=paciente.getEnderecoBairro()%></font></td>
		</tr>
		<tr>
			<td align="right">CEP:</td>
			<td align="left"><font style="font-weight: bold;"><%=paciente.getEnderecoCEP()%></font></td>
		</tr>
		<tr>
			<td align="right">Estado:</td>
			<td align="left"><font style="font-weight: bold;"><%=paciente.getEnderecoEstado()%></font></td>
		</tr>
		<tr>
			<td align="right">Cidade:</td>
			<td align="left"><font style="font-weight: bold;"><%=paciente.getEnderecoCidade()%></font></td>
		</tr>
	</tbody>
</table>