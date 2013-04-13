package model;

import java.util.List;

import javax.servlet.http.HttpSession;

import dao.UsuarioDAO;

public class Usuario {
	protected int codigoUsuario;
	protected String nome;
	protected String cpf;
	protected String senha;
	protected TipoUsuario tipoUsuario;
	
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
	public TipoUsuario getTipoUsuario() {
		return tipoUsuario;
	}
	public void setTipoUsuario(TipoUsuario tipoUsuario) {
		this.tipoUsuario = tipoUsuario;
	}
	
	public Usuario efetuarLogin(String cpf, String senha, int tipoUsuario) {
		UsuarioDAO udao = new UsuarioDAO();
		Usuario usu = udao.getDadosLogin(cpf, senha, tipoUsuario);
		return usu;
		
	}
	
	public List<TipoUsuario> getTipoUsuario(String cpf) {
		UsuarioDAO udao = new UsuarioDAO();
		List<TipoUsuario> listaTipoUsuario = udao.getTipoUsuario(cpf);
		return listaTipoUsuario;
	}
}