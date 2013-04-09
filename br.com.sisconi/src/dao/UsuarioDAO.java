package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Especialidade;
import model.Medico;
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
	
	public List<Especialidade> getEspecialidades() {
		try {
			List<Especialidade> les = new ArrayList<Especialidade>();
			Connection con = ConexaoBD.getInstancia().getConexao();
			Statement stm = con.createStatement();
			ResultSet res = stm.executeQuery("select co_especialidade, ds_especialidade from tb_especialidade order by ds_especialidade");
						
			while (res.next()){
				Especialidade es = new Especialidade();
				es.setCodigoEspecialidade(res.getInt("co_especialidade"));
				es.setDescricaoEspecialidade(res.getString("ds_especialidade"));
				les.add(es);
			}
			return les;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public List<Medico> getMedicos() {
		try {
			List<Medico> lme = new ArrayList<Medico>();
			Connection con = ConexaoBD.getInstancia().getConexao();
			Statement stm = con.createStatement();
			ResultSet res = stm.executeQuery("select tb_medico.co_usuario, tb_medico.nr_crm, tb_usuario.nm_usuario from tb_medico " +
					"join tb_usuario on tb_usuario.co_usuario = tb_medico.co_usuario " +					
					"order by tb_usuario.nm_usuario");
			
			while (res.next()){
				List<Especialidade> les = new ArrayList<Especialidade>();
				Medico m = new Medico();
				m.setCodigoUsuario(res.getInt("tb_medico.co_usuario"));
				m.setCrm(res.getInt("tb_medico.nr_crm"));
				m.setNome(res.getString("tb_usuario.nm_usuario"));
				String sqlListaEspecialidades = "select tb_especialidade.co_especialidade, tb_especialidade.ds_especialidade from tb_especialidade " +
						"join tb_especialidade_medico on tb_especialidade_medico.co_especialidade = tb_especialidade.co_especialidade " +
						"join tb_medico on tb_especialidade_medico.co_usuario = tb_medico.co_usuario " +
						"where tb_medico.co_usuario = "+m.getCodigoUsuario()+" order by tb_especialidade.ds_especialidade";
				ResultSet res2 = stm.executeQuery(sqlListaEspecialidades);
				while (res2.next()) {
					Especialidade e = new Especialidade();
					e.setCodigoEspecialidade(res.getInt("tb_especialidade.co_especialidade"));
					e.setDescricaoEspecialidade(res.getString("tb_especialidade.ds_especialidade"));
					les.add(e);
				}				
				m.setListaEspecialidade(les);				
				lme.add(m);
			}
			return lme;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}