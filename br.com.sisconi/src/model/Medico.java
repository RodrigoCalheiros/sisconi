package model;

import java.util.List;

import dao.UsuarioDAO;

public class Medico extends Usuario {
	private int crm;
	private List<Especialidade> listaEspecialidade;
	
	public int getCrm() {
		return crm;
	}
	public void setCrm(int crm) {
		this.crm = crm;
	}
	public List<Especialidade> getListaEspecialidade() {
		return listaEspecialidade;
	}
	public void setListaEspecialidade(List<Especialidade> listaEspecialidade) {
		this.listaEspecialidade = listaEspecialidade;
	}
	
	public List<Medico> getMedicos() {
		UsuarioDAO udao = new UsuarioDAO();
		return udao.getMedicos();
	}
}