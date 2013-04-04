<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<!-- Css SISCONI -->
	<link href="css/sisconi.css" rel="stylesheet">
	
	<!-- Jquery -->
	<link href="css/south-street/jquery-ui-1.10.2.custom.css" rel="stylesheet">
	<script src="js/jquery/jquery-1.9.1.js" type="text/javascript"></script>
	<script src="js/jquery/jquery-ui-1.10.2.custom.js" type="text/javascript"></script>
	<title>Insert title here</title>
</head>
<script>
$(function() {
	$( "#datepicker" ).datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'dd/mm/yy',
        dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'],
        dayNamesMin: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
        dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
        monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
        monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],changeMonth: true,
		changeYear: true,
		dateFormat: 'dd/mm/yy',
        dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'],
        dayNamesMin: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
        dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
        monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
        monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
	});
});
</script>
<body>
<input id="datepicker">
</body>
</html>