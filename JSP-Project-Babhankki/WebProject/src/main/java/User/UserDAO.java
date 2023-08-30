package User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public UserDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/WebPro";
            String dbID = "root";
            String dbPassword = "taisei1017";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int login(String userID, String userPassword) {
        String SQL = "SELECT password FROM User WHERE userid = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) {
                    return 1; // 로그인 성공
                } else {
                    return 0; // 비밀번호 불일치
                }
            }
            System.out.println(userID);
            return -1; // 아이디 불일치
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // DB 오류
    }
    
    public int join(UserEntity user) {
    	String SQL = "INSERT INTO User (name, userid, email, password, diseases) VALUES (?, ?, ?, ?, ?)";
    	try {
    		pstmt = conn.prepareStatement(SQL);
    		pstmt.setString(1, user.getName());
    	    pstmt.setString(2, user.getUserid());
    	    pstmt.setString(3, user.getEmail());
    	    pstmt.setString(4, user.getPassword());
    	    pstmt.setString(5, user.getDiseaseString());
    	    return pstmt.executeUpdate();
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    	return -1;
    }
    
    
}
