<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="question.QuestionDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="question" class="question.Question" scope="page"/>
<jsp:setProperty name="question" property="questionTitle"/>
<jsp:setProperty name="question" property="questionContent"/>

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

			if (question.getQuestionTitle() == null || question.getQuestionContent() == null){
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); // 사용자를 이전페이지로 돌려 보내는 것
				script.println("</script>");
			}
			else {
				
				QuestionDAO questionDAO = new QuestionDAO();
				int result = questionDAO.write(question.getQuestionTitle(), userID, question.getQuestionContent());
				
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
					script.println("location.href = 'question.jsp'");
					script.println("</script>");
				}
			}
		}
	
	%>
	
</body>
</html>