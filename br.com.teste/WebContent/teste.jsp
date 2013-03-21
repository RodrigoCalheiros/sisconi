<%@ page contentType="text/html" language="java" import="java.sql.*, java.util.*, model.Estado"%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<jsp:useBean id="paciente" class="model.Paciente"/>  
<html>  
<head>  
<title>Untitled Document</title>  
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script language="JavaScript" type="text/javascript" src="MascaraValidacao.js"></script> 
</head>  
<script>
function getCidades(){
	var codigoEstado = 	$('#cbEstado').val();
	$.ajax({
	  url: "ajax_get_cidades.jsp?codigoEstado=" + codigoEstado,
	  context: document.body
	}).done(function(retornoSucesso) {
		$('#spCidade').html(retornoSucesso);
	});	
}
</script>

<!-- <script type="text/javascript">
$(document).ready(function(){
    $("input").blur(function(){
     if($(this).val() == "")
         {
             $(this).css({"border" : "1px solid #F00", "padding": "2px"});
         }
    });
    $("#botao").click(function(){
     var cont = 0;
     $("#form input").each(function(){
         if($(this).val() == "")
             {
                 $(this).css({"border" : "1px solid #F00", "padding": "2px"});
                 cont++;
             }
        });
     if(cont == 0)
         {
             $("#form").submit();
         }
    });
});
</script> -->

<body>  
<form id="form" name="form" method="post">
    <span style="display:inline-table; width:70px;">Nome:</span>
     <input type="text" id="nome" value="" size="85" maxlength="100"/>
    <br /><br />
    <span style="display:inline-table; width:70px;">CPF:</span>
    <input type="text" id="cpf" name="cpf" value="" onBlur="ValidarCPF(form.cpf);" onKeyPress="MascaraCPF(form.cpf);" maxlength="14" />
    <br /><br />
    <span style="display:inline-table; width:70px;">Telefone:</span>
    <input type="text" id="telefone" value="" />
    <br /><br />
   


<select name="cbEstado" id="cbEstado" onchange="getCidades()">
	<option value="0">--</option>
<%      
   try {  
      List<Estado> les = paciente.getEstados();    
        
      for (int i=0; i<les.size(); i++) {
    	  Estado e = les.get(i);
%>
    	  <option value=<%=e.getCodigoEstado()%>><%=e.getUF()%></option>
<%
      }
   }catch (Exception e) {  
	      e.printStackTrace();  
	}
%>
      
</select>
<span id="spCidade"></span> <br>

 <input type="button" id="botao" value="Cadastrar" /> 

</form>  
</body>  
</html>