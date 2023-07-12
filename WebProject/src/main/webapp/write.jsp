<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/000621fd00.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<script language=JavaScript src="check.js"></script>
<link rel = "stylesheet" href="css/write.css" type="text/css" />
<title>Insert title here</title>

<style>

</style>
</head>
<body>
	<%@ page import = "Restaurant.*" %>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		String userid = "";
		String restaurant_name = "";
		String address = "";
		String bbsContent = "";
		String good_health_cindition = "";
		String photo_file = "";		
	
		String id = request.getParameter("id");
		
		if(id != null){
			int idnum = Integer.parseInt(id);
			BbsDAO bbsdb = new BbsDAO();
			RestaurantEntity brd = bbsdb.getBoard(idnum);
			userid = brd.getUserid();
			restaurant_name = brd.getRestaurant_name();
			address = brd.getAddress();
			bbsContent = brd.getBbsContent();
			good_health_cindition = brd.getGood_health_condition();
			photo_file = brd.getPhoto_file();
			
		};
	%>
	<jsp:include page="header.jsp"></jsp:include>
	
	<div class = "container"> 
		<div class="row">
			<form name = "boardform" method = "post" action = "write_process.jsp" 
				enctype="multipart/form-data" >
			<input type=hidden name="menu" value="insert">
			<input type=hidden name="id" value=<%= id %>>
				<table style="text-align: center; border:1px solid #dddddd; width : 800px;">
					<thead>
						<tr  style = "height : 40px;">
							<th  colspan = "2" style = "background-color : #eeeeee; text-align: center; font-size : 25px; ">음식점 추가하기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>음식점명</td>
							<td><input type = "text" name = "restaurant_name" value = "<%= restaurant_name %>" style = "color : gray; width : 100%; height : 50px; font-size : 12px; "  ></td>
						</tr>
						<tr>
							<td>주소</td>
							<td><input type = "text" name = "address" value = "<%= address %>" style = "color : gray; width : 100%; height : 50px; font-size : 12px; " ></td>
						
						</tr>
						<tr>
							<td>게시물 내용</td>
							<td><textarea cols="100" rows="10" name = "bbsContent"  style = "width: 100%; height: 6.25em; border: none; resize: none;" > <%= bbsContent %></textarea></td>
						</tr>
						<tr>
							<td>이미지 파일</td>
							<td><input type = "file" name = "photo_file"  style = "color : gray; font-size : 12px;"></td>
						</tr>
					</tbody>
				</table>
				<%
					if(id == null){
				%>
				<div class = "write-button-box">
					<input type = "button" class = "write-button" value = "등록" onClick="insertcheck()">	
				</div>		
				<%
					}else{
				%>
					<div class = "change-delete">
						<div class = "change-button-box">
							<input type = "button" class = "write-button" value = "수정" onClick="updatecheck()">	
						</div>	
						<div class = "delete-button-box">
							<input type = "button" class = "write-button" value = "삭제" onClick="deletecheck()" style = "background-color: red; border: 0.5px solid red; ">	
						</div>				
					</div>
				<% 
					} 	
				
				%>	
				
			</form>
		</div>
	</div>
</body>
</html>