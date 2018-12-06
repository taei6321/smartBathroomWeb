<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="review.ReviewDAO" %>
<%@ page import="review.Review" %>
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
		
		int reviewID = 0;
		if(request.getParameter("reviewID") != null){
			reviewID = Integer.parseInt(request.getParameter("reviewID"));
		}
		
		if(reviewID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'review.jsp'");
			script.println("</script>");
		}

		Review review = new ReviewDAO().getReview(reviewID);
		
		if(!userID.equals(review.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'review.jsp'");
			script.println("</script>");
		}
		else{

			if (request.getParameter("reviewContent") == null  || request.getParameter("reviewContent").equals("")){
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); 
				script.println("</script>");
			}
			else {
				
				ReviewDAO reviewDAO = new ReviewDAO();
				int result = reviewDAO.update(reviewID,request.getParameter("reviewContent"));
				
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
					script.println("location.href = 'review.jsp'");
					script.println("</script>");
				}
			}
		}
	
	%>
	
</body>
</html>