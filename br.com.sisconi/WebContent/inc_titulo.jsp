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
				<td align="right">Usu�rio:<font style="font-weight: bold;"> <%=session.getAttribute("nm_usuario")%></font></td>
			</tr>
			<tr>
				<td align="right">Tipo de usu�rio:<font style="font-weight: bold;"> <%=session.getAttribute("ds_tipo_usuario")%></font></td>
			</tr>
			<tr>
				<td align="right">Hor�rio:<font style="font-weight: bold;"> <span id="spanRelogio"></span></font></td>
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
	            <li><a href="paciente_cadastrar.jsp">Cadastrar Paciente</a></li>
	            <li><a href="paciente_localizar.jsp">Localizar Paciente</a></li>
	        </ul>
	    </li>
	    <li>
	        <a href="#"><img src="_imagens/icones/16X16/leito.png">&nbsp;Leito</a>
	        <ul>
	            <li><a href="leito_cadastrar.jsp">Cadastrar Leito</a></li>
	            <li><a href="leito_monitorar.jsp">Monitorar Leitos</a></li>
	        </ul>
	    </li>
	    <li>
	        <a href="#"><img src="_imagens/icones/16X16/notepad.gif">&nbsp;Interna��o</a>
	        <ul>
	            <li><a href="internacao_iniciar.jsp">Iniciar Interna��o</a></li>
	            <li><a href="#">Encerrar Interna��o</a></li>
	            <li><a href="#">Dar Alta</a></li>
	            <li><a href="#">Agendar Interna��o</a></li>
	            <li><a href="#">Cancelar Agendamento</a></li>
	            <li><a href="#">Remanejar Interna��o</a></li>
	        </ul>
	    </li>
	    <li>
	        <a href="#"><img src="_imagens/icones/16X16/calculator.gif">&nbsp;Estat�sticas</a>
	        <ul>
	            <li><a href="#">Estat�stica de Ocupa��o dos Leitos</a></li>
	        </ul>
	    </li>
	    <li>
	        <a href="#"><img src="_imagens/icones/16X16/configure.gif">&nbsp;Op��es</a>
	        <ul>
	            <li><a href="logoff_processa.jsp">Sair do Sistema</a></li>
	        </ul>
	    </li>
	</ul>	
	</td>
</tr>
</table>