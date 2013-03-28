package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Usuario;

public class UsuarioDAO {
	
	public List<String[]> getTipoUsuario(String cpf) {
		try{
			List<String[]> retorno = new ArrayList<String[]>();
			String[] tipo = new String[2];
			Connection con = ConexaoBD.getInstancia().getConexao();
			Statement stm = con.createStatement();
			ResultSet res = stm.executeQuery("select tbdesc.co_tipo_usuario, tbdesc.ds_tipo_usuario " +
					"from tb_usuario as usu " +
					"join tb_tipo_usuario as tpusu on usu.co_usuario = tpusu.co_usuario " +
					"join tb_descricao_tipo_usuario tbdesc on tpusu.co_tipo_usuario = tbdesc.co_tipo_usuario " +
					"where usu.nr_cpf="+cpf);
			
			while (res.next()) {
				tipo[0] = Integer.toString(res.getInt("tbdesc.co_tipo_usuario"));
				tipo[1] = res.getString("tbdesc.ds_tipo_usuario");
				retorno.add(tipo);
			}
			ConexaoBD.getInstancia().fecharConexao();
			return retorno;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	public Usuario select(String cpf, String senha, int tipoUsuario) {
		try {
			Connection con = ConexaoBD.getInstancia().getConexao();
			Statement stm = con.createStatement();
			ResultSet res = stm.executeQuery("select usu.co_usuario, usu.nr_cpf, usu.nm_usuario, tpusu.co_tipo_usuario, tdesc.ds_tipo_usuario "+
					"from tb_usuario as usu " +
					"inner join tb_tipo_usuario as tpusu on (usu.co_usuario = tpusu.co_usuario) " +
					"inner join tb_descricao_tipo_usuario as tdesc on (tpusu.co_tipo_usuario = tdesc.co_tipo_usuario) " +
					"where usu.nr_cpf =\""+cpf+"\" " +
					"and usu.ds_senha =\""+senha+"\" " +
					"and tpusu.co_tipo_usuario ="+tipoUsuario);
			
			Usuario usu = new Usuario();
			res.next();
			usu.setCodigoUsuario(res.getInt("usu.co_usuario"));
			usu.setCpf(res.getString("usu.nr_cpf"));
			usu.setNome(res.getString("usu.nm_usuario"));
			usu.setTipoUsuario(res.getInt("tpusu.co_tipo_usuario"));			
			
			ConexaoBD.getInstancia().fecharConexao();
			return usu;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
	}

}
