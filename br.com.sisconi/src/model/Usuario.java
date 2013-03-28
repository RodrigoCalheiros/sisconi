package model;

import dao.UsuarioDAO;

public class Usuario {
	protected int codigoUsuario;
	protected String nome;
	protected String cpf;
	protected String senha;
	protected int tipoUsuario;
	
	public int getCodigoUsuario() {
		return codigoUsuario;
	}
	public void setCodigoUsuario(int codigoUsuario) {
		this.codigoUsuario = codigoUsuario;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getCpf() {
		return cpf;
	}
	public void setCpf(String cpf) {
		this.cpf = cpf;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}	
	public int getTipoUsuario() {
		return tipoUsuario;
	}
	public void setTipoUsuario(int tipoUsuario) {
		this.tipoUsuario = tipoUsuario;
	}
	
	public boolean efetuarLogin(String cpf, String senha, int tipoUsuario) {
		UsuarioDAO udao = new UsuarioDAO();
		Usuario usu = udao.select(cpf, senha, tipoUsuario);
		return true;
		
	}

}
