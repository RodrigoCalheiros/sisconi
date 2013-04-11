<%@ page contentType="text/html; charset=windows-1252" pageEncoding="windows-1252" language="java" import="java.util.*, model.Ala, model.Medico, model.Paciente, model.Internacao"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="ala" class="model.Ala"/>
<jsp:useBean id="medico" class="model.Medico"/>
<jsp:useBean id="paciente" class="model.Paciente"/>
<jsp:useBean id="internacao" class="model.Internacao"/>
<%
	String pNrSus = request.getParameter("nr_sus");	
	Internacao inter = internacao.getInternacaoNrSus(pNrSus);
	Paciente pac = inter.getPaciente();
	Leito lei = inter.getLeito();
	List<Medico> lMed = inter.getListaMedico();
%>
<input type="hidden" id="hidden_co_internacao" name="hidden_co_internacao" value="">
<input type="hidden" id="hidden_co_paciente" name="hidden_co_paciente" value="">
<table class="tbl" width="100%">
	<thead>
		<tr>
			<th colspan="2">Dados Pessoais</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td align="right" width="180px">Nome:</td>
			<td align="left"><input type="text" id="nm_paciente" name="nm_paciente" maxlength="70" size="50" value="<%=paciente.getNome()%>" disabled="disabled" required></td>
		</tr>
		<tr>
			<td align="right">Número do SUS:</td>
			<td align="left"><input type="text" id="nr_sus" name="nr_sus" maxlength="15" size="50" onBlur="onBlurNrSus();" onKeyPress="mascaraInteiro();" value="<%=paciente.getNumeroSus()%>" disabled="disabled" required></td>
		</tr>
		<tr>
			<td align="right">Nome da Mãe:</td>
			<td align="left"><input type="text" id="nm_mae" name="nm_mae" maxlength="70" size="50" value="<%=paciente.getNomeMae()%>" disabled="disabled" required></td>
		</tr>
		<tr>
			<td align="right">Data de Nascimento:</td>
			<td align="left"><input type="text" id="datepicker" name="dt_nascimento" maxlength="10" size="50" onKeyPress="MascaraData(form.dt_nascimento);" onblur="validaData(form.dt_nascimento, form.dt_nascimento.value)" value="<%=dateformat.format(dtNascimento)%>" disabled="disabled" required></td>
		</tr>
		<tr>
			<td align="right">CPF:</td>
			<td align="left"><input type="text" id="nr_cpf" name="nr_cpf" maxlength="14" size="50" onKeyPress="MascaraCPF(form.nr_cpf);" onBlur="onBlurNrCpf();" value="<%=paciente.getCpf()%>" disabled="disabled"></td>
		</tr>
		<tr>
			<td align="right">Telefone:</td>
			<td align="left"><input type="text" id="nr_telefone" name="nr_telefone" maxlength="14" size="50" onKeyPress="MascaraTelefone(form.nr_telefone);" value="<%=paciente.getNumeroTelefone()%>" disabled="disabled"></td>
		</tr>
	
	</tbody>
</table><br>
<table class="tbl" width="100%">
	<thead>
		<tr>
			<th colspan="2">Endereço</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td align="right" width="180px">Rua:</td>
			<td align="left"><input type="text" id="ds_rua" name="ds_rua" maxlength="60" size="50" value="<%=paciente.getEnderecoRua()%>" disabled="disabled" required></td>
		</tr>
		<tr>
			<td align="right">Número:</td>
			<td align="left"><input type="text" id="ds_numero" name="ds_numero" maxlength="10" size="50" onKeyPress="mascaraInteiro();" value="<%=paciente.getEnderecoNumero()%>" disabled="disabled" required></td>
		</tr>
		<tr>
			<td align="right">Complemento:</td>
			<td align="left"><input type="text" id="ds_complemento" name="ds_complemento" maxlength="100" size="50" value="<%=paciente.getEnderecoComplemento()%>" disabled="disabled"></td>
		</tr>
		<tr>
			<td align="right">Bairro:</td>
			<td align="left"><input type="text" id="ds_bairro" name="ds_bairro" maxlength="40" size="50" value="<%=paciente.getEnderecoBairro()%>" disabled="disabled" required></td>
		</tr>
		<tr>
			<td align="right">CEP:</td>
			<td align="left"><input type="text" id="ds_cep" name="ds_cep" maxlength="10" size="50" onKeyPress="MascaraCep(form.ds_cep);" value="<%=paciente.getEnderecoCEP()%>" disabled="disabled"></td>
		</tr>
		<tr>
			<td align="right">Estado:</td>
			<td align="left"><input type="text" id="ds_estado" name="ds_estado" maxlength="50" size="50" value="<%=paciente.getEnderecoCEP()%>" disabled="disabled"></td>
		</tr>
		<tr>
			<td align="right">Cidade:</td>
			<td align="left"><input type="text" id="ds_cidade" name="ds_cidade" maxlength="50" size="50" value="<%=paciente.getEnderecoCEP()%>" disabled="disabled"></td>
		</tr>
	</tbody>
</table><br>
<table class="tbl" width="100%">
<thead>
	<tr>
		<th colspan="2">Leito Atual</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td align="right" width="180px">Ala:</td>
		<td align="left"><input type="text" id="ds_ala" name="ds_ala" maxlength="50" size="50" value="<%=paciente.getEnderecoCEP()%>" disabled="disabled"></td>
	</tr>
	<tr>
		<td align="right">Leito:</td>
		<td align="left"><input type="text" id="co_leito_atual" name="co_leito_atual" maxlength="50" size="50" value="<%=paciente.getEnderecoCEP()%>" disabled="disabled"></td>
	</tr>
</tbody>
</table><br>
<table class="tbl" width="100%">
<thead>
	<tr>
		<th colspan="2">Médico</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td colspan="2" align="left">
			<%      
			 	List<Medico> lMedico = medico.getMedicos();
			   	for (int j=0; j<lMedico.size(); j++) {
			   		Medico m = lMedico.get(j);
			%>
								<input type="checkbox" id="cb_medico_<%=m.getCodigoUsuario()%>" name="" />
								<label for="cb_medico_<%=m.getCodigoUsuario()%>">
									<%=m.getNome()%><br>
									CRM:<%=m.getCrm()%><br>
								</label>
					<%
				  }
			%>
		</td>
	</tr>
</tbody>
</table><br>
<table class="tbl" width="100%">
<thead>
	<tr>
		<th colspan="2">Informações Internação</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td align="right" width="180px">Data Inicial:</td>
		<td align="left"><input type="text" id="ds_ala" name="ds_ala" maxlength="50" size="50" value="<%=paciente.getEnderecoCEP()%>" disabled="disabled"></td>
	</tr>
	<tr>
		<td align="right">Data Final:</td>
		<td align="left"><input type="text" id="co_leito_atual" name="co_leito_atual" maxlength="50" size="50" value="<%=paciente.getEnderecoCEP()%>" disabled="disabled"></td>
	</tr>
	<tr>
		<td align="right">Alta:</td>
		<td align="left"><input type="text" id="co_leito_atual" name="co_leito_atual" maxlength="50" size="50" value="<%=paciente.getEnderecoCEP()%>" disabled="disabled"></td>
	</tr>
</tbody>
</table>






