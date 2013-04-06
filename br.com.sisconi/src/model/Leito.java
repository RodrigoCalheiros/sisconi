package model;

import dao.LeitoDAO;

public class Leito {
	private int codigoLeito;
	private int codigoAla;
	private int codigoStatusLeito;
	private String descricaoStatusLeito;
	
	public int getCodigoLeito() {
		return codigoLeito;
	}

	public void setCodigoLeito(int codigoLeito) {
		this.codigoLeito = codigoLeito;
	}

	public int getCodigoAla() {
		return codigoAla;
	}

	public void setCodigoAla(int codigoAla) {
		this.codigoAla = codigoAla;
	}

	public int getCodigoStatusLeito() {
		return codigoStatusLeito;
	}

	public void setCodigoStatusLeito(int codigoStatusLeito) {
		this.codigoStatusLeito = codigoStatusLeito;
	}

	public String getDescricaoStatusLeito() {
		return descricaoStatusLeito;
	}

	public void setDescricaoStatusLeito(String descricaoStatusLeito) {
		this.descricaoStatusLeito = descricaoStatusLeito;
	}

	public boolean cadastrarLeito() {
		LeitoDAO ldao = new LeitoDAO();
		return ldao.insert(this);
	}
	
	public boolean desbloquearLeito() {
		LeitoDAO ldao = new LeitoDAO();
		return ldao.update(this);
	}
}