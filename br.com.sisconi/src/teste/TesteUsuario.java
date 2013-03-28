package teste;

import java.util.List;

import model.Usuario;

import dao.UsuarioDAO;

public class TesteUsuario {
	public static void main(String[] args) {
		Usuario udao = new Usuario();
		List<String[]> teste = udao.getTipoUsuario("78851599572");
		System.out.println(teste.size());
		for (int i = 0; i<teste.size(); i++) {
			System.out.println(teste.get(i)[0]);
			System.out.println(teste.get(i)[1]);
		}
		
	}

}
