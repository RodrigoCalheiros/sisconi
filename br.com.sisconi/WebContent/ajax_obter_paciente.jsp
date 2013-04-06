<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html" language="java" import="java.util.*, model.Estado, model.Paciente"%>
 <jsp:useBean id="paciente" class="model.Paciente"/> 
<%
	String pNrSus = request.getParameter("nr_sus");	
	paciente.setNumeroSus(pNrSus);
	paciente = paciente.localizarPaciente();
	if (paciente.getCodigoPaciente() > 0){
		Date dtNascimento = paciente.getDataNascimento();
		java.text.DateFormat dateformat = new java.text.SimpleDateFormat("dd/MM/yyyy");
%>
<input type="hidden" id="hidden_co_paciente" name="hidden_co_paciente" value="<%=paciente.getCodigoPaciente()%>">
<input type="hidden" id="hidden_nr_sus" name="hidden_nr_sus" value="<%=paciente.getNumeroSus()%>">
<input type="hidden" id="hidden_nr_cpf" name="hidden_nr_cpf" value="<%=paciente.getCpf()%>">
<table class="tbl">
	<thead>
		<tr>
			<th colspan="2">Dados Pessoais</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td align="right" width="180px">Nome:</td>
			<td align="left"><input type="text" id="nm_paciente" name="nm_paciente" maxlength="70" size="50" value="<%=paciente.getNome()%>" required></td>
		</tr>
		<tr>
			<td align="right">Número do SUS:</td>
			<td align="left"><input type="text" id="nr_sus" name="nr_sus" maxlength="15" size="50" onBlur="onBlurNrSus();" onKeyPress="mascaraInteiro();" value="<%=paciente.getNumeroSus()%>" required></td>
		</tr>
		<tr>
			<td align="right">Nome da Mãe:</td>
			<td align="left"><input type="text" id="nm_mae" name="nm_mae" maxlength="70" size="50" value="<%=paciente.getNomeMae()%>" required></td>
		</tr>
		<tr>
			<td align="right">Data de Nascimento:</td>
			<td align="left"><input type="text" id="datepicker" name="dt_nascimento" maxlength="10" size="50" onKeyPress="MascaraData(form.dt_nascimento);" onblur="validaData(form.dt_nascimento, form.dt_nascimento.value)" value="<%=dateformat.format(dtNascimento)%>" required></td>
		</tr>
		<tr>
			<td align="right">CPF:</td>
			<td align="left"><input type="text" id="nr_cpf" name="nr_cpf" maxlength="14" size="50" onKeyPress="MascaraCPF(form.nr_cpf);" onBlur="onBlurNrCpf();" value="<%=paciente.getCpf()%>"></td>
		</tr>
		<tr>
			<td align="right">Telefone:</td>
			<td align="left"><input type="text" id="nr_telefone" name="nr_telefone" maxlength="14" size="50" onKeyPress="MascaraTelefone(form.nr_telefone);" value="<%=paciente.getNumeroTelefone()%>"></td>
		</tr>
	
	</tbody>
</table>
<br>
<input type="hidden" id="hidden_co_cidade" name="hidden_co_cidade" value="<%=paciente.getEnderecoCodigoCidade()%>">
<table class="tbl">
	<thead>
		<tr>
			<th colspan="2">Endereço</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td align="right" width="180px">Rua:</td>
			<td align="left"><input type="text" id="ds_rua" name="ds_rua" maxlength="60" size="50" value="<%=paciente.getEnderecoRua()%>" required></td>
		</tr>
		<tr>
			<td align="right">Número:</td>
			<td align="left"><input type="text" id="ds_numero" name="ds_numero" maxlength="10" size="50" onKeyPress="mascaraInteiro();" value="<%=paciente.getEnderecoNumero()%>" required></td>
		</tr>
		<tr>
			<td align="right">Complemento:</td>
			<td align="left"><input type="text" id="ds_complemento" name="ds_complemento" maxlength="100" size="50" value="<%=paciente.getEnderecoComplemento()%>"></td>
		</tr>
		<tr>
			<td align="right">Bairro:</td>
			<td align="left"><input type="text" id="ds_bairro" name="ds_bairro" maxlength="40" size="50" value="<%=paciente.getEnderecoBairro()%>" required></td>
		</tr>
		<tr>
			<td align="right">CEP:</td>
			<td align="left"><input type="text" id="ds_cep" name="ds_cep" maxlength="10" size="50" onKeyPress="MascaraCep(form.ds_cep);" value="<%=paciente.getEnderecoCEP()%>"></td>
		</tr>
		<tr>
			<td align="right">Estado:</td>
			<td align="left">
				<select name="co_estado" id="co_estado" onclick="getCidades()" required>
					<option value="0">--</option>
				<%      
				   try {  
				      List<Estado> les = paciente.getEstados();    
				        
				      for (int i=0; i<les.size(); i++) {
				    	  Estado e = les.get(i);
				%>
				    	  <option value=<%=e.getCodigoEstado()%> <%if (paciente.getEnderecoCodigoEstado() == e.getCodigoEstado()){%>selected<%}%>><%=e.getUF()%></option>
				<%
				      }
				   }catch (Exception e) {  
				      e.printStackTrace();  
					}
				%>
				      
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">Cidade:</td>
			<td align="left"><span id="spanCidade"><font style="font-weight: bold;"><%=paciente.getEnderecoCidade()%></font></span></td>
		</tr>
		<tr>
			<td></td>
			<td align="left"><span id="span_bt_salvar" style="display:none;"><input type="button" id="bt_salvar" name="bt_salvar" value="Salvar" onclick="salvarCadastro()"></span></td>
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