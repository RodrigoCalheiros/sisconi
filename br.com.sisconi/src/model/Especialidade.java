package model;

import java.util.List;

import dao.UsuarioDAO;

public class Especialidade {
	private int codigoEspecialidade;
	private String descricaoEspecialidade;
	
	public int getCodigoEspecialidade() {
		return codigoEspecialidade;
	}
	public void setCodigoEspecialidade(int codigoEspecialidade) {
		this.codigoEspecialidade = codigoEspecialidade;
	}
	public String getDescricaoEspecialidade() {
		return descricaoEspecialidade;
	}
	public void setDescricaoEspecialidade(String descricaoEspecialidade) {
		this.descricaoEspecialidade = descricaoEspecialidade;
	}
	
	public List<Especialidade> getEspecialidades() {
		UsuarioDAO udao = new UsuarioDAO();
		return udao.getEspecialidades();
	}
}