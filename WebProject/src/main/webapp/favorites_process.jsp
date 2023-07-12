<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Restaurant.FavoritesEntity"%>
<%@ page import="Restaurant.FavoritesDAO"%>
<%@ page import= "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
	<%
	String userID = (String) session.getAttribute("userID");
	int restaurantID = Integer.parseInt(request.getParameter("restaurantID"));
	
	FavoritesDAO favoritesDAO = new FavoritesDAO();
	boolean isFavorite = favoritesDAO.isRestaurantFavorite(userID, restaurantID);
	
	if (isFavorite) {
	    favoritesDAO.removeFavorites(userID, restaurantID);
	    isFavorite = false;
	} else {
	    favoritesDAO.addFavorites(userID, restaurantID);
	    isFavorite = true;
	}
	
	response.sendRedirect("restaurant_page.jsp?id=" + restaurantID);
	
	%>
</body>
</html>
