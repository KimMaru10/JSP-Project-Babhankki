<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="User.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Arrays" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id = "user" class="User.UserEntity" scope = "page"/>
<jsp:setProperty name = "user" property = "name"/>
<jsp:setProperty name = "user" property = "userid"/>
<jsp:setProperty name = "user" property = "email"/>
<jsp:setProperty name = "user" property = "password"/>
<jsp:setProperty name = "user" property = "disease"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 프로세스</title>
</head>
<body>
	<%
		if(user.getUserid() == null || user.getPassword() == null ||user.getName()==null 
		|| user.getEmail()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입이 완료되었습니다.')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
		}
		}
	%>
</body>
</html>

