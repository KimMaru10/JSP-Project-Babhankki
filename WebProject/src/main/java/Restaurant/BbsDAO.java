package Restaurant;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import User.UserEntity;

public class BbsDAO {
	
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private DataSource ds = null;
	private ResultSet rs;
	
	public BbsDAO(){
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

	public String getDate() {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    Date currentTime = new Date();
	    return dateFormat.format(currentTime);
	}
	public RestaurantEntity getBoard(int id) {
		connect();
		String SQL = "select * from Restaurants where id = ?";
		RestaurantEntity brd = new RestaurantEntity();
		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			brd.setId ( rs.getInt("id") );
			brd.setUserid ( rs.getString("userid") );
			brd.setRestaurant_name ( rs.getString("restaurant_name") );
			brd.setAddress ( rs.getString("address") );
			brd.setBbsContent ( rs.getString("bbsContent") );
			brd.setBbsAvailable ( rs.getInt("bbsAvailable") );
			brd.setBbsDate( rs.getString("bbsDate") );
			brd.setGood_health_condition( rs.getString("good_health_condition") );
			brd.setPhoto_file(rs.getString("photo_file"));
			
			int bbsCount = rs.getInt("bbsCount");
			brd.setBbsCount(bbsCount);
			bbsCount++;
			countUpdate(bbsCount, id);
			
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			disconnect();
		}
		return brd;
	}
	
	public int countUpdate(int bbsCount, int id) {
		connect();
		String SQL = "update Restaurants set bbsCount = ? where id = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1,  bbsCount);
			pstmt.setInt(2,  id);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	 
	public ArrayList<RestaurantEntity> getBoardList() {
	    connect();
	    ArrayList<RestaurantEntity> list = new ArrayList<RestaurantEntity>();
	    String SQL = "SELECT * FROM Restaurants WHERE deleted = 0";
	    try {
	        pstmt = con.prepareStatement(SQL);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            RestaurantEntity brd = new RestaurantEntity();
	            brd.setId(rs.getInt("id"));
	            brd.setUserid(rs.getString("userid"));
	            brd.setRestaurant_name(rs.getString("restaurant_name"));
	            brd.setAddress(rs.getString("address"));
	            brd.setBbsContent(rs.getString("bbsContent"));
	            brd.setBbsAvailable(rs.getInt("bbsAvailable"));
	            brd.setBbsDate(rs.getString("bbsDate"));
	            brd.setGood_health_condition(rs.getString("good_health_condition"));
	            brd.setPhoto_file(rs.getString("photo_file"));
	            brd.setBbsCount(rs.getInt("bbsCount"));

	            // 리스트에 추가
	            list.add(brd);
	        }
	        rs.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        disconnect();
	    }
	    return list;
	}
	
		public int insertDB(RestaurantEntity bbs, String sessionID) {
			boolean success = false;
			connect();
			String SQL = "INSERT INTO Restaurants(userid, restaurant_name, address, bbsContent,bbsAvailable, bbsDate, good_health_condition, photo_file,bbsCount) VALUES(?,?,?,?,?,?,?,?,?)";
			try {
				PreparedStatement pstmt = con.prepareStatement(SQL);
				pstmt.setString(1, sessionID);
				pstmt.setString(2, bbs.restaurant_name);
				pstmt.setString(3, bbs.address);
				pstmt.setString(4, bbs.bbsContent);
				pstmt.setInt(5, 1);
				pstmt.setString(6, getDate());
				
				String getHealthConditionSQL = "SELECT good_health_condition FROM Restaurants WHERE userid = ?";
				PreparedStatement getHealthConditionStmt = con.prepareStatement(getHealthConditionSQL);
				getHealthConditionStmt.setString(1, sessionID);
				ResultSet rs = getHealthConditionStmt.executeQuery();
				if (rs.next()) {
					String good_health_condition = rs.getString("good_health_condition");
					pstmt.setString(7, good_health_condition);
				} else {
					// 작성자의 지병명이 없는 경우 처리할 로직 추가
					pstmt.setString(7, "");
				}
				pstmt.setString(8, bbs.photo_file);
				pstmt.setInt(9, bbs.bbsCount);

				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				disconnect();
			}
			return -1;
		}
		
		public boolean updateDB(RestaurantEntity bbs , String sessionID) {
			 boolean success = false;
			 connect();
			 String SQL = "UPDATE Restaurants SET restaurant_name = ?,address = ?,bbsContent = ?,bbsDate = ?,photo_file = ?WHERE id = ?;";
			 	
			 try {
			     PreparedStatement pstmt = con.prepareStatement(SQL);
			     pstmt.setString(1, bbs.getRestaurant_name());
			     pstmt.setString(2, bbs.getAddress());
			     pstmt.setString(3, bbs.getBbsContent());
			     pstmt.setString(4, getDate());
			     pstmt.setString(5, bbs.getPhoto_file());
			     pstmt.setInt(6, bbs.getId());
				 int rowsUpdated = pstmt.executeUpdate();
				
				 if (rowsUpdated == 1) {
					 success = true;
				 }
				 
			 }catch(SQLException e) {
					e.printStackTrace();
					return success;
			 }finally {
				 disconnect();
			 }
			 return success;
		 }
	 

	 

		public boolean deleteDB(int id) {
		    boolean success = false;
		    connect();
		    String sql = "UPDATE Restaurants SET deleted = 1 WHERE id = ?";
		    try {
		        pstmt = con.prepareStatement(sql);
		        pstmt.setInt(1, id);
		        pstmt.executeUpdate();
		        success = true;
		    } catch (SQLException e) {
		        e.printStackTrace();
		        return success;
		    } finally {
		        disconnect();
		    }
		    return success;
		}
	 

	 public ArrayList<RestaurantEntity> searchBoardList(String searchKeyword, String disease) {
		    ArrayList<RestaurantEntity> resultList = new ArrayList<>();
		    try {
		        connect(); // DB 연결을 위한 Connection 객체를 얻어온다.
		        PreparedStatement pstmt = null;
		        ResultSet rs = null;
		        
		        
		        // address에서 searchKeyword를 포함하는 레코드 검색 쿼리
		        String addressQuery = "SELECT * FROM Restaurants WHERE address LIKE ?";
		        
		        // good_health_condition에서 region을 포함하는 레코드 검색 쿼리
		        String healthConditionQuery = "SELECT * FROM Restaurants WHERE good_health_condition LIKE ?";
		        
		        // address와 good_health_condition 두 가지 조건을 모두 만족하는 레코드 검색 쿼리
		        String dualConditionQuery = "SELECT * FROM Restaurants WHERE address LIKE ? AND good_health_condition LIKE ?";
		        
		        // 전체 검사 쿼리 
		        String allQuery = "SELECT * FROM Restaurants";
		        
		        if (searchKeyword != null && !searchKeyword.isEmpty()) {
		            if (disease != null && !disease.isEmpty()) {
		            	if(disease.equals("전체")) {
		            		pstmt = con.prepareStatement(addressQuery);
		            		pstmt.setString(1, "%" + searchKeyword + "%");
		            	}else {
		            		pstmt = con.prepareStatement(dualConditionQuery);
		                	pstmt.setString(1, "%" + searchKeyword + "%");
		                	pstmt.setString(2, "%" + disease + "%");
		            	}
		            }
		        } else if (disease != null && !disease.isEmpty()) {
		            if(disease.equals("전체")) {
		        		 pstmt = con.prepareStatement(allQuery);
		        	}else {
		        		pstmt = con.prepareStatement(healthConditionQuery);
		        		pstmt.setString(1, "%" + disease + "%");
		        		
		        	}
		        } 
		        
		        if (pstmt != null) {
		            rs = pstmt.executeQuery();
		            
		            while (rs.next()) {
		                RestaurantEntity restaurant = new RestaurantEntity();
		                restaurant.setId(rs.getInt("id"));
		                restaurant.setUserid(rs.getString("userid"));
		                restaurant.setBbsDate(rs.getString("bbsDate"));
		                restaurant.setRestaurant_name(rs.getString("restaurant_name"));
		                restaurant.setAddress(rs.getString("address"));
		                restaurant.setBbsContent(rs.getString("bbsContent"));
		                restaurant.setBbsAvailable(rs.getInt("bbsAvailable"));
		                restaurant.setGood_health_condition(rs.getString("good_health_condition"));
		                restaurant.setPhoto_file(rs.getString("photo_file"));
		                restaurant.setBbsCount(rs.getInt("bbsCount"));
		                resultList.add(restaurant);
		            }
		        } else {
		            return null;
		        }
		        
		        disconnect(); // DB 연결 관련 리소스 해제
		        
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    
		    return resultList;
		}

	 
	 public List<String> getRankingName() {
		    List<String> top3RestaurantNames = new ArrayList<>();
		    
		    connect();
		    
		    try {
		        String SQL = "SELECT restaurant_name FROM Restaurants ORDER BY bbsCount DESC LIMIT 3 ";
		        pstmt = con.prepareStatement(SQL);
		        rs = pstmt.executeQuery();
		        
		        while (rs.next()) {
		            String restaurantName = rs.getString("restaurant_name");
		            String rankingInfo = (top3RestaurantNames.size() + 1) + "위: " + restaurantName;
		            top3RestaurantNames.add(rankingInfo);
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        disconnect();
		    }
		    
		    return top3RestaurantNames;
		}
	 
	 public List<Integer>getRankingID(){
		 List<Integer> top3RestaurantID = new ArrayList<>();
		 connect();
		    
		    try {
		        String SQL = "SELECT id FROM Restaurants ORDER BY bbsCount DESC LIMIT 3";
		        pstmt = con.prepareStatement(SQL);
		        rs = pstmt.executeQuery();
		        
		        while (rs.next()) {
		            int id = rs.getInt("id");
		            int rankingInfo = id ;
		            top3RestaurantID.add(rankingInfo);
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        disconnect();
		    }
		    return top3RestaurantID;
	 }
	 
	 public ArrayList<RestaurantEntity> getBoardListByUserid(String userid) {
		    connect();
		    ArrayList<RestaurantEntity> list = new ArrayList<RestaurantEntity>();
		    String SQL = "SELECT * FROM Restaurants WHERE userid = ? AND deleted = 0";
		    try {
		        pstmt = con.prepareStatement(SQL);
		        pstmt.setString(1, userid);
		        ResultSet rs = pstmt.executeQuery();

		        while (rs.next()) {
		            RestaurantEntity brd = new RestaurantEntity();
		            brd.setId(rs.getInt("id"));
		            brd.setUserid(rs.getString("userid"));
		            brd.setRestaurant_name(rs.getString("restaurant_name"));
		            brd.setAddress(rs.getString("address"));
		            brd.setBbsContent(rs.getString("bbsContent"));
		            brd.setBbsAvailable(rs.getInt("bbsAvailable"));
		            brd.setBbsDate(rs.getString("bbsDate"));
		            brd.setGood_health_condition(rs.getString("good_health_condition"));
		            brd.setPhoto_file(rs.getString("photo_file"));
		            brd.setBbsCount(rs.getInt("bbsCount"));

		            // 리스트에 추가
		            list.add(brd);
		        }
		        rs.close();
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        disconnect();
		    }
		    return list;
		}

}


