package model;

public class Main {

	public static void main(String[] args) {
		int teste = 0;
		for (int i=0; i<10; i++) {
			long ini = System.currentTimeMillis();
			Paciente p = new Paciente();
			p.setNome("Maria");
			p.cadastrarPaciente();
			long end = System.currentTimeMillis();
			System.out.println(end-ini);
			if (i>0) {
				teste += (end-ini);
			}
		}
		System.out.println("Média SISCONI: "+teste/9);
	}
}