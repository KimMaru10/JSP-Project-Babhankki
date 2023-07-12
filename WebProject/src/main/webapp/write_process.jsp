

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="Restaurant.RestaurantEntity"%>
<%@ page import="Restaurant.BbsDAO"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<%@ page import="java.io.PrintWriter"%>
	<jsp:useBean id="brdDAO" class="Restaurant.BbsDAO" scope="page" />
	<jsp:useBean id="bbs" class="Restaurant.RestaurantEntity" scope="page" />
	<%
	request.setCharacterEncoding("UTF-8");
	int fileSize = 1024 * 1024 * 10;
	String realPath = "/Users/gimdaeseong/eclipse_webserver_workspace/WebProject/src/main/webapp/upload/image";
	MultipartRequest multi = multi = new MultipartRequest(request, realPath, fileSize, "UTF-8",new DefaultFileRenamePolicy());
	String originalFile = multi.getOriginalFileName("uploadfiles");
	String uploadFile = multi.getFilesystemName("uploadfiles");
	String menu = multi.getParameter("menu");
	
	if(menu.equals("delete") || menu.equals("update")){
		String id = multi.getParameter("id");
		int idnum = Integer.parseInt(id);
		if(menu.equals("delete")){
			brdDAO.deleteDB(idnum);
		}else if (menu.equals("update")){

			request.setCharacterEncoding("UTF-8");
			
			String restaurant_name = multi.getParameter("restaurant_name");
			String address = multi.getParameter("address");
			String bbsContent = multi.getParameter("bbsContent");
			String photo_file = multi.getFilesystemName("photo_file");
			
			
			bbs.setId(idnum);
			bbs.setRestaurant_name(restaurant_name);
			bbs.setAddress(address);
			bbs.setBbsContent(bbsContent);
			bbs.setPhoto_file(photo_file);
		
			
			String sessionID = (String) session.getAttribute("userID");
			brdDAO.updateDB(bbs , sessionID);
		}
		response.sendRedirect("boardlist.jsp");
	
	}else if(menu.equals("insert")){

		request.setCharacterEncoding("UTF-8");
		String restaurant_name = multi.getParameter("restaurant_name");
		String address = multi.getParameter("address");
		String bbsContent = multi.getParameter("bbsContent");
		String photo_file = multi.getFilesystemName("photo_file");

		bbs.setRestaurant_name(restaurant_name);
		bbs.setAddress(address);
		bbs.setBbsContent(bbsContent);
		bbs.setPhoto_file(photo_file);
	
		String sessionID = (String) session.getAttribute("userID");
		brdDAO.insertDB(bbs, sessionID);
		response.sendRedirect("boardlist.jsp");
	}
	%>
</body>
</html>
