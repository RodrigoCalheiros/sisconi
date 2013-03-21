<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Teste HTML5</title>
<script language="JavaScript" type="text/javascript" src="MascaraValidacao.js"></script>
<style type="text/css">
:invalid { 
  border-color: #e88;
  border: 2px solid #ff0000;
  -webkit-box-shadow: 0 0 5px rgba(255, 0, 0, .8);
  -moz-box-shadow: 0 0 5px rbba(255, 0, 0, .8);
  -o-box-shadow: 0 0 5px rbba(255, 0, 0, .8);
  -ms-box-shadow: 0 0 5px rbba(255, 0, 0, .8);
  box-shadow:0 0 5px rgba(255, 0, 0, .8);
}

:required {
  border-color: #88a;
  -webkit-box-shadow: 0 0 5px rgba(0, 0, 255, .5);
  -moz-box-shadow: 0 0 5px rgba(0, 0, 255, .5);
  -o-box-shadow: 0 0 5px rgba(0, 0, 255, .5);
  -ms-box-shadow: 0 0 5px rgba(0, 0, 255, .5);
  box-shadow: 0 0 5px rgba(0, 0, 255, .5);
}

form {
  width:500px;
  margin: 30px auto;
}

input {
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  border:1px solid #ccc;
  font-size:20px;
  width:300px;
  min-height:30px;
  display:block;
  margin-bottom:15px;
  margin-top:5px;
  outline: none;

  -webkit-border-radius:5px;
  -moz-border-radius:5px;
  -o-border-radius:5px;
  -ms-border-radius:5px;
  border-radius:5px;
  
  
}

input[type=submit] {
  background:none;
  padding:5px;
}
</style>
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