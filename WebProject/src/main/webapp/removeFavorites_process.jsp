<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	favoritesDAO.removeFavorites(userID, restaurantID);
	
	response.sendRedirect("Mypage.jsp");

%>
</body>
</html>