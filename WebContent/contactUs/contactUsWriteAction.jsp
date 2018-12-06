<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="contactUs.ContactUsDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="contactUs" class="contactUs.ContactUs" scope="page"/>
<jsp:setProperty name="contactUs" property="contactUsTitle"/>
<jsp:setProperty name="contactUs" property="contactUsContent"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Smart Bathroom</title>
</head>
<body>
	
	<%
		String userID = null;
	
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = '../login/login.jsp'");
			script.println("</script>");
		}
		else{

			if (contactUs.getContactUsTitle() == null || contactUs.getContactUsContent() == null){
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); // 사용자를 이전페이지로 돌려 보내는 것
				script.println("</script>");
			}
			else {
				
				ContactUsDAO contactUsDAO = new ContactUsDAO();
				int result = contactUsDAO.write(contactUs.getContactUsTitle(), userID, contactUs.getContactUsContent());
				
				if (result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()"); 
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'contactUs.jsp'");
					script.println("</script>");
				}
			}
		}
	
	%>
	
</body>
</html>