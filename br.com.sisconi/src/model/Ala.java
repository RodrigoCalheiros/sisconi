package model;

import java.util.List;

import dao.AlaDAO;

public class Ala {
	private int codigoAla;
	private String nomeAla;
	
	
	public int getCodigoAla() {
		return codigoAla;
	}
	public void setCodigoAla(int codigoAla) {
		this.codigoAla = codigoAla;
	}
	public String getNomeAla() {
		return nomeAla;
	}
	public void setNomeAla(String nomeAla) {
		this.nomeAla = nomeAla;
	}
	
	public List<Ala> getAlas() {
		AlaDAO adao = new AlaDAO();
		return adao.select();		
	}
}