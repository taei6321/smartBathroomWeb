<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userfirPhone"/>
<jsp:setProperty name="user" property="usersecPhone"/>
<jsp:setProperty name="user" property="userthrPhone"/>
<jsp:setProperty name="user" property="userEmail"/>
<jsp:setProperty name="user" property="userAddress"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Smart Bathroom</title>
</head>
<body>
	
	<%
		
		String userID = null;
		String userPhone = "0"+ Integer.toString(user.getUserfirPhone()) + Integer.toString(user.getUsersecPhone()) + Integer.toString(user.getUserthrPhone());
		
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = '../main.jsp'");
			script.println("</script>");
		}
	
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
			|| user.getUserGender() == null || user.getUserEmail() == null || user.getUserAddress() == null){
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()"); // 사용자를 이전페이지로 돌려 보내는 것
			script.println("</script>");
		}
		else if(userPhone.length() != 11){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('휴대폰 번호가 잘못입력되었습니다.')");
			script.println("history.back()"); // 사용자를 이전페이지로 돌려 보내는 것
			script.println("</script>");
		}
		else {
			UserDAO userDAO = new UserDAO();
			int result = 0;
			
			if(request.getParameter("userPassword").equals(request.getParameter("confPassword"))){
				PrintWriter script = response.getWriter();
				
				result = userDAO.join(user);
				
				if (result == -1){
					script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 존재하는 아이디입니다.')");
					script.println("history.back()"); // 사용자를 이전페이지로 돌려 보내는 것
					script.println("</script>");
				}
				else {
					
					session.setAttribute("userID", user.getUserID());
					
					script = response.getWriter();
					script.println("<script>");
					script.println("location.href = '../main.jsp'");
					script.println("</script>");
				}
			}
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호가 일치하지 않습니다.')");
				script.println("history.back()"); // 사용자를 이전페이지로 돌려 보내는 것
				script.println("</script>");
			}
			
		}
	%>
	
</body>
</html>