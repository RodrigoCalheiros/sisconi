<%@ page contentType="text/html"%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
  
<html>  
<head>  
<title>Tabela Pessoa</title>  
  
  
<script>  
  
function enviar(par){  
     
   if (par == 'cadastrar'){  
     
      if (document.cadastro.nomeField.value == ''){  
         document.cadastro.statusField.value = 'Preencha o campo nome';  
      }else if (document.cadastro.idadeField.value == ''){  
         document.cadastro.statusField.value = 'Preencha o campo idade';  
      }else if (document.cadastro.sexoField.value == ''){  
         document.cadastro.statusField.value = 'Escolha o sexo da pessoa';  
      }else {  
         document.cadastro.action='cadastrar.jsp';  
         document.cadastro.submit();  
      }  
  
   } else if (par == 'consultar'){  
  
      if (document.cadastro.nomeField.value == ''){  
         document.cadastro.statusField.value = 'Preencha o campo nome';  
      }else {  
         document.cadastro.action='consultar.jsp';  
         document.cadastro.submit();  
      }  
  
   } else if (par == 'alterar'){  
  
      if (document.cadastro.nomeField.value == ''){  
         document.cadastro.statusField.value = 'Preencha o campo nome';  
      }else if (document.cadastro.idadeField.value == ''){  
         document.cadastro.statusField.value = 'Preencha o campo idade';        
      }else if (document.cadastro.sexoField.value == ''){  
         document.cadastro.statusField.value = 'Escolha o sexo da pessoa';  
      }else {  
         document.cadastro.action='alterar.jsp';  
         document.cadastro.submit();  
      }  
   } else if (par == 'excluir'){  
  
      if (document.cadastro.nomeField.value == ''){  
         document.cadastro.statusField.value = 'Preencha o campo nome';  
      }else {  
         document.cadastro.action='excluir.jsp';  
         document.cadastro.submit();  
      }  
   } else if (par == 'listar'){  
      document.cadastro.action='listar.jsp';  
      document.cadastro.submit();  
   }  
}  
  
</script>  
  
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">  
<style type="text/css">  
<!--  
.style3 {   font-size: 28px;  
   font-weight: bold;  
}  
-->  
</style>  
</head>  
  
<%  
String nome = request.getParameter("nome");  
String idade = request.getParameter("idade");  
String sexo = request.getParameter("sexo");  
String status = request.getParameter("status");  
%>  
  
<body>  
<form name="cadastro" method="get">  
  
<table width="472" border="0">  
  <tr>  
    <td width="458" height="70" bgcolor="#6699FF"><p align="left" class="style3"> Cadastro pessoa </p>  
    </td>  
  </tr>  
  <tr>  
    <td height="177" bgcolor="#6699FF"><p> <strong>Nome :</strong>  
       <input name="nomeField" type="text" id="nomeField" size="46" value="<%=(nome==null)?"":nome%>"> </p>  
         <p> <strong>Idade :</strong>  
       <input name="idadeField" type="text" id="idadeField" size="10" value="<%=(idade==null)?"":idade%>">  
               <strong>Sexo:</strong>   
  
        <input name="sexoField" type="text" id="sexoField" size="6" value="<%=(sexo==null)?"":sexo%>">  
          
  
         </p>      
   </td>  
  </tr>  
  <tr>  
    <td height="101" bgcolor="#6699FF"><p>   
        <input type="button" onClick="enviar('cadastrar')" name="btCadastar" value="cadastrar">  
          
      </p>  
      <p> <strong>Status:  
   <input name="statusField" disabled type="text" id="statusField" size="46" value="<%=(status==null)?"":status%>">  
      </strong></p>  
   </td>  
  </tr>  
</table>  
</form>  
</body>  
</html>