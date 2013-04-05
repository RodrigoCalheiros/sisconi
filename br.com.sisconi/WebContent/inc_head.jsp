<head>
	<meta http-equiv="Content-Language" content="pt-br">
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
	<title>::: SISCONI :::</title>
	
	<!-- Css SISCONI -->
	<link href="css/sisconi.css" rel="stylesheet">
	
	<!-- Jquery -->
	<link href="css/south-street/jquery-ui-1.10.2.custom.css" rel="stylesheet">
	<script src="js/jquery/jquery-1.9.1.js" type="text/javascript"></script>
	<script src="js/jquery/jquery-ui-1.10.2.custom.js" type="text/javascript"></script>
	<script src="js/jquery/jquery.maskedinput.js" type="text/javascript"></script>	
	
	
	<!-- Js Validação -->
	<script type="text/javascript" src="js/MascaraValidacao.js"></script>
	
	<script type="text/javascript">
	$(function(){
		$( "#datepicker" ).datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: "1900:<%=new java.util.Date()%>",
			showOn: "both",
		    buttonImageOnly: true,
		    buttonImage: "_imagens/icones/calendar.gif",
		    buttonText: "Calendar",
			dateFormat: 'dd/mm/yy',
	        dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'],
	        dayNamesMin: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
	        dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
	        monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
	        monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez']
		});
		$( "input[type=submit], input[type=button], input[type=reset]" )
	      .button()
	      .click(function( event ) {
	        event.preventDefault();
	     });
	});
	</script>
</head>