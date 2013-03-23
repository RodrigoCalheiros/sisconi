<table border="0" width="100%" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<a href="inicio.jsp"><img border="0" width="100px" height="98px" src="_imagens/logos/logo_sisconi.jpg"></a>
	</td>
	<td valign="middle" align="right">
		<table>
			<tr>
				<td align="right">Nome: Rodrigo Losano Fontes Calheiros</td>
			</tr>
			<tr>
				<td align="right">Usuário: RodrigoCalheiros</td>
			</tr>
			<tr>
				<td align="right">Horário: 05/06/2012 - 21:06</td>
			</tr>
		</table>
	</td>
<tr>
<tr>
	<td colspan="2">
	<br>
	<div dojoType="dijit.MenuBar" id="menuNavegacao">
	
	<div dojoType="dijit.PopupMenuBarItem">
	<span><img src="_imagens/icones/16X16/address-book.gif" align="absmiddle">&nbsp;Paciente</span>
	<div dojoType="dijit.Menu" id="pacienteMenu">
	    <div dojoType="dijit.MenuItem" onClick="location.href='paciente_cadastrar.asp';">Cadastrar Paciente</div>
   	    <div dojoType="dijit.MenuItem" onClick="location.href='paciente_localizar.asp';">Localizar Paciente</div>
	</div>
	</div>
	
	<div dojoType="dijit.PopupMenuBarItem">
	<span><img src="_imagens/icones/16X16/leito.png">&nbsp;Leito</span>
	<div dojoType="dijit.Menu" id="leitoMenu">
	    <div dojoType="dijit.MenuItem" onClick="location.href='leito_cadastrar.asp';">Cadastrar Leito</div>
	    <div dojoType="dijit.MenuItem" onClick="location.href='leito_monitorar.asp';">Monitorar Leitos</div>
	</div>
	</div>
	
	<div dojoType="dijit.PopupMenuBarItem">
	<span><img src="_imagens/icones/16X16/notepad.gif">&nbsp;Internação</span>
	<div dojoType="dijit.Menu" id="internacaoMenu">
	    <div dojoType="dijit.MenuItem" onClick="location.href='internacao_iniciar.asp';">Iniciar Internação</div>
	    <div dojoType="dijit.MenuItem" onClick="location.href='internacao_encerrar.asp';">Encerrar Internação</div>
	  	<div dojoType="dijit.MenuItem" onClick="location.href='internacao_dar_alta.asp';">Dar Alta</div>
	  	<div dojoType="dijit.MenuItem" onClick="location.href='internacao_agendar.asp';">Agendar Internação</div>
	  	<div dojoType="dijit.MenuItem" onClick="location.href='internacao_agenda_cancelar.asp';">Cancelar Agendamento</div>
	  	<div dojoType="dijit.MenuItem" onClick="location.href='internacao_remanejar.asp';">Remanejar Internação</div>
	</div>
	</div>

	<div dojoType="dijit.PopupMenuBarItem">
	<span><img src="_imagens/icones/16X16/calculator.gif">&nbsp;Estatísticas</span>
	<div dojoType="dijit.Menu" id="estatisticaMenu">
	    <div dojoType="dijit.MenuItem" onClick="location.href='estatistica_ocupacao_leitos.asp';">Estatística de Ocupação dos Leitos</div>
	</div>
	</div>
	
	<div dojoType="dijit.PopupMenuBarItem">
	<span><img src="_imagens/icones/16X16/configure.gif">&nbsp;Opções</span>
	<div dojoType="dijit.Menu" id="sairMenu">
	    <div dojoType="dijit.MenuItem" onClick="location.href='default.asp';">Sair do Sistema</div>
	</div>
	</div>
	
	</div>	
	</td>
</tr>
</table>