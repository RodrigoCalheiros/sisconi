package teste;

import java.util.List;

import dao.UsuarioDAO;

public class TesteUsuario {
	public static void main(String[] args) {
		UsuarioDAO udao = new UsuarioDAO();
		List<String[]> teste = udao.getTipoUsuario("99999999999");
		
	}

}
