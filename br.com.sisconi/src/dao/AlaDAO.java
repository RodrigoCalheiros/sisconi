package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Ala;

public class AlaDAO {
	
	public List<Ala> select() {
		try{
			List<Ala> lal = new ArrayList<Ala>();
			Connection con = ConexaoBD.getInstancia().getConexao();
			Statement stm = con.createStatement();
			ResultSet res = stm.executeQuery("select co_ala, ds_ala from tb_ala order by ds_ala");
			while (res.next()) {
				Ala al = new Ala();
				al.setCodigoAla(res.getInt("co_ala"));
				al.setNomeAla(res.getString("ds_ala"));
				lal.add(al);				
			}
			return lal;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}