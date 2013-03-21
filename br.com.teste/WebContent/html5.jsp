<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Teste HTML5</title>
<script language="JavaScript" type="text/javascript" src="MascaraValidacao.js"></script>

</head>
<body>
<form oninput="total.value = (nights.valueAsNumber * 99) + 
 ((guests.valueAsNumber - 1) * 10)">

  <label>Nome:</label>
  <input type="text" id="nome" name="nome" placeholder="Insira o nome completo aqui" required pattern="[A-Za-z]+" onkeypress="return naoNumeros();">

  <label>CPF:</label>
  <input type="text" id="cpf" name="cpf" onBlur="ValidarCPF(form.cpf);" onKeyPress="MascaraCPF(form.cpf);" maxlength="14">

  <label>Data de Nascimento:</label>
  <input type="date" id="dtNascimento" name="dtNascimento" required>
  
  <label>Number of nights (rooms are $99.00 per night):</label>
  <input type="number" id="nights" name="nights" value="1" min="1" max="30" required>

  <label>Number of guests (each additional guest adds $10.00 per night):</label>
  <input type="number" id="guests" name="guests" value="1" min="1" max="4" required>

  <label>Estimated total:</label>
  $<output id="total" name="total">99</output>.00
  <br><br>

  <label>Promo code:</label>
  <input type="text" id="promo" name="promo" pattern="[A-Za-z0-9]{6}" 
   title="Promo codes consist of 6 alphanumeric characters.">

  <input type="submit" value="Request Reservation" /> 
</form>

<script>
function check(input) {
  if (input.value != document.getElementById('email_addr').value) {
    input.setCustomValidity('The two email addresses must match.');
  } else {
    // input is valid -- reset the error message
    input.setCustomValidity('');
  }
}
</script>

</body>
</html>