package teste;

import java.util.Date;

import dao.PacienteDAO;

import model.Paciente;

public class Main {
	public static void main(String[] args) {
		/*Paciente p = new Paciente();
		p.setCpf("99999999999");
		p.setDataNascimento(new Date("12/12/1956"));
		p.setEnderecoBairro("Luzia");
		p.setEnderecoCEP("49000000");
		p.setEnderecoCidade("Aracaju");
		p.setEnderecoComplemento("Atrás do Posto Ipiranga");
		p.setEnderecoEstado("Sergipe");
		p.setEnderecoNumero(100);
		p.setEnderecoRua("Hermes Fontes");
		p.setNome("João dos Santos");
		p.setNomeMae("Maria dos Santos");
		p.setNumeroSus("999999999999999");
		p.setNumeroTelefone("7932222222");
		
		PacienteDAO pdao = new PacienteDAO();
		pdao.insert(p);*/
		
		Paciente p = new Paciente();
		p.setNumeroSus("999999999999999");		
		p = p.localizarPaciente();
		System.out.println(p.toString());
	}
	

}
