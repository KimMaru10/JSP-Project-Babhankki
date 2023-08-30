package Restaurant;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FavoritesDAO {
    private Connection con;
    private DataSource ds = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs;
    
    public FavoritesDAO() {
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
	
    public int addFavorites(String userID , int restaurantID) {
    	boolean success = false;
    	connect();
    	String SQL = "insert into Favorites(userid, restaurant_id) values(?,?)";
    	try {
    		PreparedStatement pstmt = con.prepareStatement(SQL);
    		pstmt.setString(1, userID);
    		pstmt.setInt(2, restaurantID);
    		return pstmt.executeUpdate();
    	}catch (Exception e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
    	return -1;
    }
    public boolean removeFavorites(String userID, int restaurantID) {
    	boolean success = false;
    	connect();
    	String SQL = "delete from Favorites where userid = ? AND restaurant_id = ?";
    	try {
    		pstmt = con.prepareStatement(SQL);
    		pstmt.setString(1, userID);
    		pstmt.setInt(2, restaurantID);
    		pstmt.executeUpdate();
    	}catch(SQLException e) {
    		e.printStackTrace();
    		return success;
    	}finally {
    		disconnect();
    	}
    	return success;
    }
    public boolean isRestaurantFavorite(String userID, int restaurantID) {
    	boolean isFavorite = false;
    	
    	try {
    	      connect();
    	      
    	      String query = "SELECT * FROM Favorites WHERE userid = ? AND restaurant_id = ?";
    	      pstmt = con.prepareStatement(query);
    	      pstmt.setString(1, userID);
    	      pstmt.setInt(2, restaurantID);
    	      
    	      rs = pstmt.executeQuery(); 

    	      if (rs.next()) {
    	        isFavorite = true;
    	      }
    	 } catch (SQLException e) {
    	      e.printStackTrace();
    	 } finally {
    		 disconnect();
    	 }
    	      
    	return isFavorite;
    }
    
    public ArrayList<FavoritesEntity> getFavoritesListByUserid(String userID) {
        connect();
        ArrayList<FavoritesEntity> favoritesList = new ArrayList<FavoritesEntity>();
        String SQL = "SELECT Favorites.restaurant_id, Restaurants.restaurant_name " +
                     "FROM Favorites " +
                     "JOIN Restaurants ON Favorites.restaurant_id = Restaurants.id " +
                     "WHERE Favorites.userid = ?";
        try {
            pstmt = con.prepareStatement(SQL);
            pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                FavoritesEntity favorite = new FavoritesEntity();
                favorite.setId(rs.getInt("restaurant_id"));
                favorite.setRestaurant_name(rs.getString("restaurant_name"));

                favoritesList.add(favorite);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            disconnect();
        }
        return favoritesList;
    }

}

