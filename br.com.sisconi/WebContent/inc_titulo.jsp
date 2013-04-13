<% 
	if (session.getAttribute("co_usuario") != null){
%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#menu").menu({
			position: {at: "left bottom"}
		});
		relogio();
	});
	
	function relogio(){
		$.ajax({
	  		url: "ajax_obter_horario.jsp",
	  		beforeSend: function () {
	  		}
		}).done(function (retornoSucesso) {
	    		$("#spanRelogio").html(retornoSucesso);
		});
		setTimeout('relogio()',1000);
	}
</script>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
	<td>
		<a href="inicio.jsp"><img border="0" width="100px" height="98px" src="_imagens/logos/logo_sisconi.jpg"></a>
	</td>
	<td valign="bottom" align="right">
		<table border="0" cellpadding="3" cellspacing="0" width="100%">
			<tr>
				<td align="right">Usuário:<font style="font-weight: bold;"> <%=session.getAttribute("nm_usuario")%></font></td>
			</tr>
			<tr>
				<td align="right">Tipo de usuário:<font style="font-weight: bold;"> <%=session.getAttribute("ds_tipo_usuario")%></font></td>
			</tr>
			<tr>
				<td align="right">Horário:<font style="font-weight: bold;"> <span id="spanRelogio"></span></font></td>
			</tr>
		</table>
	</td>
<tr>
<tr>
	<td colspan="2">
	<br>
	<ul id="menu">
	    <li>
	        <a href="#"><img src="_imagens/icones/16X16/address-book.gif">&nbsp;Paciente</a>
	        <ul>
	            <li <%if (!(session.getAttribute("co_tipo_usuario").equals(1))){ %>class="ui-state-disabled"<%}%>><a href="paciente_cadastrar.jsp">Cadastrar Paciente</a></li>
	            <li <%if (!(session.getAttribute("co_tipo_usuario").equals(1))){ %>class="ui-state-disabled"<%}%>><a href="paciente_localizar.jsp">Localizar Paciente</a></li>
	        </ul>
	    </li>
	    <li>
	        <a href="#"><img src="_imagens/icones/16X16/leito.png">&nbsp;Leito</a>
	        <ul>
	            <li <%if (!(session.getAttribute("co_tipo_usuario").equals(2))){ %>class="ui-state-disabled"<%}%>><a href="leito_cadastrar.jsp">Cadastrar Leito</a></li>
	            <li <%if (session.getAttribute("co_tipo_usuario").equals(3)){ %>class="ui-state-disabled"<%}%>><a href="leito_monitorar.jsp">Monitorar Leitos</a></li>
	        </ul>
	    </li>
	    <li>
	        <a href="#"><img src="_imagens/icones/16X16/notepad.gif">&nbsp;Internação</a>
	        <ul>
	            <li <%if (!(session.getAttribute("co_tipo_usuario").equals(1))){ %>class="ui-state-disabled"<%}%>><a href="internacao_iniciar.jsp">Iniciar Internação</a></li>
	            <li <%if (!(session.getAttribute("co_tipo_usuario").equals(1))){ %>class="ui-state-disabled"<%}%>><a href="internacao_encerrar.jsp">Encerrar Internação</a></li>
	            <li <%if (!(session.getAttribute("co_tipo_usuario").equals(3))){ %>class="ui-state-disabled"<%}%>><a href="internacao_dar_alta.jsp">Dar Alta</a></li>
	            <li <%if (!(session.getAttribute("co_tipo_usuario").equals(2))){ %>class="ui-state-disabled"<%}%>><a href="internacao_remanejar.jsp">Remanejar Internação</a></li>
	            <li <%if (!(session.getAttribute("co_tipo_usuario").equals(1))){ %>class="ui-state-disabled"<%}%>><a href="internacao_agendar.jsp">Agendar Internação</a></li>
	            <li <%if (!(session.getAttribute("co_tipo_usuario").equals(1))){ %>class="ui-state-disabled"<%}%>><a href="internacao_agendar_cancelar.jsp">Cancelar Agendamento</a></li>
	        </ul>
	    </li>
	    <li>
	        <a href="#"><img src="_imagens/icones/16X16/calculator.gif">&nbsp;Estatísticas</a>
	        <ul>
	            <li <%if (!(session.getAttribute("co_tipo_usuario").equals(2))){ %>class="ui-state-disabled"<%}%>><a href="estatistica_ocupacao_de_leitos.jsp">Estatística de Ocupação dos Leitos</a></li>
	        </ul>
	    </li>
	    <li>
	        <a href="logoff_processa.jsp"><img src="_imagens/icones/16X16/lock.gif">&nbsp;Sair do Sistema</a>
	    </li>
	</ul>	
	</td>
</tr>
</table>
<%
	}
%>