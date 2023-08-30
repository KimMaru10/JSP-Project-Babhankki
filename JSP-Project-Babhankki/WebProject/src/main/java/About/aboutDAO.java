package About;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class aboutDAO {
	private Connection con;
	private DataSource ds = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs;
    public aboutDAO() {
        try {
			InitialContext ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
			String dbURL = "jdbc:mysql://localhost:3306/WebPro";
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }    
    }
    
    public void connect() {
		try {
			con = ds.getConnection();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	public aboutEntity getDate(int id) {
		connect();
		String SQL = "SELECT * FROM Disease where id = ?";
		aboutEntity ab = new aboutEntity();
		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				ab.setId(rs.getInt("id"));
				ab.setName(rs.getString("name"));
				ab.setImage_url(rs.getString("image_url"));
				ab.setDefinition(rs.getString("definition"));
				ab.setCauses(rs.getString("causes"));
				ab.setSymptoms(rs.getString("symptoms"));
				ab.setPrecautions(rs.getString("precautions"));
				ab.setDiet_management(rs.getString("diet_management"));
			}
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			disconnect();
		}
		return ab;
	}
	
}
