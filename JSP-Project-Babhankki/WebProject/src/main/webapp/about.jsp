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

<link rel="stylesheet" href="css/about.css" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>Insert title here</title>
<script>
$(document).ready(function() {
	var $target = $('dt'),
	isClass = null;
	
	var initialId = <%= request.getParameter("id") %>;
	$('dt[data-id="' + initialId + '"]').addClass('on').next().slideDown();
    isClass = 'id-' + initialId;

	$target.on('click', function () {
		var _$self = $(this),
		oldClass = _$self.siblings('.' + isClass);

		if (oldClass.length > 0) {
			oldClass.removeClass(isClass).next().slideUp();
		}

		if (!_$self.is(isClass)) {
			_$self.addClass('on').next().slideDown();
			isClass = _$self.attr('class');
		} else {
			_$self.removeClass('on').next().slideUp();
			isClass = null;
		}
	});
});
</script>
<style>
html{
	scroll-behavior : smooth;
}
.container {
	margin-top: 100px;
	margin-left: 300px;
	margin-right: 300px;
	position: relative;
	display: flex;
	height: 180vh;
}

.sidemenu {
	position: fixed;
	width: 200px;
	height: 700px;
	top: 100px;
	left: 50px;
	border: solid #B4B4B4 1px;
}

.sidemenu .info {
	width: 100%;
	height: 100px;
	background-color: white;
	padding: 20px;
	display: flex;
	justify-content: flex-end;
	align-items: flex-end;
	border-bottom: solid #B4B4B4 1px;
}

.info .box {
	width: 100px;
	height: 35px;
	display: flex;
	justify-content: flex-end;
	align-items: flex-end;
	flex-direction: column;
}

.info .box .line {
	width: 50px;
	height: 1px;
	background-color: #B4B4B4;
	margin-bottom: 5px;
}

.info .box h3 {
	font-size: 24px;
	color: #50A8BC;
}

.content {
	flex: 1;
	display: block;
}

.content .title {
	width: 800px;
	height: 160px;
	display: flex;
	border-bottom: solid #B4B4B4 1px;
	margin: 0 auto;
}

.content .title .img {
	width: 180px;
	height: 140px; object-fit;
	border: solid #B4B4B4 0.7px;
}

.content .title p {
	font-size: 35px;
	font-weight: 500;
	margin-left: 30px;
	margin-top: 25px;
}

.content .box {
	widht: 800px;
	height: 200px;
	border-bottom: solid #B4B4B4 1px;
	width: 800px;
	padding-top: 20px;
	margin: 0 auto; /* 수평으로 가운데 정렬 */
}

.content .box h3 {
	color: #50A8BC;
	margin-bottom: 24px;
}

/* 아코디언 메뉴 */
dt {
	background-color: white;
	color: black;
	border-bottom: solid #B4B4B4 1px;
	height: 50px;
	text-align: right;
	line-height : 50px;
	padding : 0px 20px;
}

dt.on{
	background-color: #50A8BC;
	color: white;
}

dd {
	background-color: #D9D9D9;
	display: none;
	height: 200px;
	
	text-align: right;
	line-height : 40px;
	padding : 0px 20px;
}
dd a{
	display: block; 
	text-decoration : none;
	color : black;
	font-size : 15px;
}
</style>

</head>
<body>
	<%@ page import="java.util.ArrayList, Restaurant.RestaurantEntity, java.text.SimpleDateFormat"%>
	<%@ page import="java.util.ArrayList, Restaurant.FavoritesEntity, java.text.SimpleDateFormat"%>
	<jsp:useBean id="brddb1" class="Restaurant.BbsDAO" scope="page" />
	<jsp:useBean id="brddb2" class="Restaurant.FavoritesDAO" scope="page" />
	<%@ page import="About.*" %>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	
	String name = "";
	String image_url = "";
	String definition="";
	String causes = "";
	String symptoms="";
	String precautions="";
	String diet_management="";
	
	String id = request.getParameter("id");
	if(id != null){
		int idnum = Integer.parseInt(id);
		aboutDAO db = new aboutDAO();
		aboutEntity about = db.getDate(idnum);
		
		name = about.getName();
		image_url = "media/"+ about.getImage_url();
		definition = about.getDefinition();
		causes = about.getCauses();
		symptoms = about.getSymptoms();
		precautions = about.getPrecautions();
		diet_management = about.getDiet_management();
	}
	%>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="sidemenu">
			<div class="info">
				<div class="box">
					<div class="line"></div>
					<h3>건강정보</h3>
				</div>
			</div>
			<dl>
				<dt onclick="location.href='about.jsp?id=1'" data-id="1">크론병</dt>
					<dd>
					<a href = "#section1">정의</a>
					<a href = "#section2">원인</a>
					<a href = "#section3">증상</a>
					<a href = "#section4">주의사항</a>
					<a href = "#section5">식단관리</a>
					</dd>
				<dt onclick="location.href='about.jsp?id=2'" data-id="2">당뇨병</dt>
					<dd>
					<a href = "#section1">정의</a>
					<a href = "#section2">원인</a>
					<a href = "#section3">증상</a>
					<a href = "#section4">주의사항</a>
					<a href = "#section5">식단관리</a>
					</dd>
				<dt onclick="location.href='about.jsp?id=3'" data-id="3">고지혈증</dt>
					<dd>
					<a href = "#section1">정의</a>
					<a href = "#section2">원인</a>
					<a href = "#section3">증상</a>
					<a href = "#section4">주의사항</a>
					<a href = "#section5">식단관리</a>
					</dd>
				<dt onclick="location.href='about.jsp?id=4'" data-id="4">고혈압</dt>
					<dd>
					<a href = "#section1">정의</a>
					<a href = "#section2">원인</a>
					<a href = "#section3">증상</a>
					<a href = "#section4">주의사항</a>
					<a href = "#section5">식단관리</a>
					</dd>
			</dl>
		</div>
		<div class="content">
			<div class="title">
				<img src="<%=image_url%>" class="img">
				<p><%=name %></p>
			</div>
			<div class="box" id = "section1">
				<h3>정의</h3>
				<p><%=definition %></p>
			</div>
			<div class="box" id = "section2">
				<h3>원인</h3>
				<p><%=causes %></p>
			</div>
			<div class="box" id = "section3">
				<h3>증상</h3>
				<p><%=symptoms %></p>

			</div>
			<div class="box" id = "section4">
				<h3>주의사항</h3>
				<p><%=precautions %></p>
			</div>
			<div class="box" id = "section5">
				<h3>식단관리</h3>
				<p><%=diet_management %></p>
			</div>
		</div>

	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
