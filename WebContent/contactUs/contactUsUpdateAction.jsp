<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="contactUs.ContactUsDAO" %>
<%@ page import="contactUs.ContactUs" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>

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
		
		int contactUsID = 0;
		if(request.getParameter("contactUsID") != null){
			contactUsID = Integer.parseInt(request.getParameter("contactUsID"));
		}
		
		if(contactUsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'contactUs.jsp'");
			script.println("</script>");
		}

		ContactUs contactUs = new ContactUsDAO().getContactUs(contactUsID);
		
		if(!userID.equals(contactUs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'contactUs.jsp'");
			script.println("</script>");
		}
		else{

			if (request.getParameter("contactUsTitle") == null || request.getParameter("contactUsContent") == null 
					|| request.getParameter("contactUsTitle").equals("") || request.getParameter("contactUsContent").equals("")){
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); 
				script.println("</script>");
			}
			else {
				
				ContactUsDAO contactUsDAO = new ContactUsDAO();
				int result = contactUsDAO.update(contactUsID, request.getParameter("contactUsTitle"), request.getParameter("contactUsContent"));
				
				if (result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
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