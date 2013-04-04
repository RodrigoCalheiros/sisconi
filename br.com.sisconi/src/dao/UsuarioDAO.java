package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.ldap.HasControls;

import model.TipoUsuario;
import model.Usuario;

public class UsuarioDAO {
	
	public Usuario getDadosLogin(String cpf, String senha, int tipoUsuario) {
		try {
			Connection con = ConexaoBD.getInstancia().getConexao();
			Statement stm = con.createStatement();
			ResultSet res = stm.executeQuery("select usu.co_usuario, usu.nr_cpf, usu.nm_usuario, tpusu.co_tipo_usuario, tdesc.ds_tipo_usuario "+
					"from tb_usuario as usu " +
					"inner join tb_tipo_usuario as tpusu on (usu.co_usuario = tpusu.co_usuario) " +
					"inner join tb_descricao_tipo_usuario as tdesc on (tpusu.co_tipo_usuario = tdesc.co_tipo_usuario) " +
					"where usu.nr_cpf  like '"+cpf+"' " +
					"and usu.ds_senha like '"+senha+"' " +
					"and tpusu.co_tipo_usuario ="+tipoUsuario);
			
			Usuario usu = new Usuario();
			TipoUsuario tpUsu = new TipoUsuario();
			if (res.next()){
				usu.setCodigoUsuario(res.getInt("usu.co_usuario"));
				usu.setCpf(res.getString("usu.nr_cpf"));
				usu.setNome(res.getString("usu.nm_usuario"));
				
				tpUsu.setCodigoTipoUsuario(res.getInt("co_tipo_usuario"));
				tpUsu.setDescricaoTipoUsuario(res.getString("ds_tipo_usuario"));
				
				usu.setTipoUsuario(tpUsu);
			}
			return usu;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	public List<TipoUsuario> getTipoUsuario(String cpf) {
		List<TipoUsuario> retorno;
		try{
			retorno = new ArrayList<TipoUsuario>();
			Connection con = ConexaoBD.getInstancia().getConexao();
			Statement stm = con.createStatement();
			String sql = ("select tbdesc.co_tipo_usuario, tbdesc.ds_tipo_usuario " +
					"from tb_usuario as usu " +
					"join tb_tipo_usuario as tpusu on usu.co_usuario = tpusu.co_usuario " +
					"join tb_descricao_tipo_usuario tbdesc on tpusu.co_tipo_usuario = tbdesc.co_tipo_usuario " +
					"where usu.nr_cpf like '" + cpf + "'");
			ResultSet res = stm.executeQuery(sql);
			while (res.next()) {
				TipoUsuario tpUsu = new TipoUsuario();
				tpUsu.setCodigoTipoUsuario(res.getInt("co_tipo_usuario"));
				tpUsu.setDescricaoTipoUsuario(res.getString("ds_tipo_usuario"));
				retorno.add(tpUsu);
			}
			return retorno;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}
