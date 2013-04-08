package model;

public class Medico extends Usuario {
	private String crm;
	private int codigoEspecialidade;
	
	public String getCrm() {
		return crm;
	}
	public void setCrm(String crm) {
		this.crm = crm;
	}
	public int getCodigoEspecialidade() {
		return codigoEspecialidade;
	}
	public void setCodigoEspecialidade(int codigoEspecialidade) {
		this.codigoEspecialidade = codigoEspecialidade;
	}
	
//	public Medico localizarMedico() {
//		UsuarioDAO udao = new UsuarioDAO();
//		return null;
//		
//	}

}
