<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="question.QuestionDAO" %>
<%@ page import="question.Question" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%-- bootstrap에서 어느 해상도에서도 전부 맞출 수 있게 설정 --%>
<meta name="viewport" content="width=device-width", initial-scale="1">

<%-- 디자인 담당할 css --%>
<link rel="stylesheet" href="../css/bootstrap.css"> 
<link rel="stylesheet" href="../css/custom.css"> 

<title>Smart Bathroom</title>
</head>
<body>

	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		int questionID = 0;
		if(request.getParameter("questionID") != null){
			questionID = Integer.parseInt(request.getParameter("questionID"));
		}
		if(questionID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'question.jsp'"); // 사용자를 이전페이지로 돌려 보내는 것
			script.println("</script>");
		}
		Question question = new QuestionDAO().getQuestion(questionID);
		
		UserDAO userDAO = new UserDAO();
		int userManager = 0;
	%>

	<%-- 네비게이션구현 : 하나의 웹사이트에 전반적인 구성을 보여주는 역할 --%>
	<nav class="navbar navbar-default">
	
		<%-- header 라는 구간은 홈페이지의 로고를 넣는 구간 --%>
		<div class="navbar-header">
		
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				</button>
				
		</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="../notice/notice.jsp">공지사항</a></li>
	
					<li><a href="../introduce/introduce.jsp">제품소개</a></li>

					<li class="active"><a href="question.jsp">견적문의</a></li>
		
					<li><a href="../purchase/purchase.jsp">제품구입</a></li>
	
					<li><a href="../review/review.jsp">후기</a></li>
					
					<li><a href="../contactUs/contactUs.jsp">고객문의</a></li>
					<%
					userManager = userDAO.find(userID);
					if(userManager == 1){
						%>
							<li><a href="../management/management.jsp">고객관리</a></li>
						<%
					}
					%>
				</ul>
			
		<%
			if(userID == null){
		%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
				
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
						
						<ul class="dropdown-menu">
							<%-- active 라는 건 현제 페이지가 선택 되었다는 의미 --%>
							<li><a href="../login/login.jsp">로그인</a></li>
							<li><a href="../join/join.jsp">회원가입</a></li>
						</ul>
					</li>
				</ul>
			<% 
				}
				else{
			%>
					<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
				
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">회원관리<span class="caret"></span></a>
						
						<ul class="dropdown-menu">
							<li><a href="../login/logoutAction.jsp">로그아웃</a></li>
						</ul>
					</li>
				</ul>
			<%
				}
			%>
		</div>
	</nav>
	<br>
	<nav>
		<div class="container">
			<div class="col-xs-15" style="background-color:white-space;">
				<%-- brand는 로고를 의미 --%>
				<a class="text-center" href="../main.jsp"><span style="color:black"><h1><font size="800sp" style= "font:bold 1.5em/1em Georgia, serif ;">Smart Bathroom</font></h1></span></a>
			</div>
		</div>
	</nav>

		<hr style="border: dashed 13px #bbb7b4;">
		
	<div class="container" style="border:2px solid #ffffff">
		<h4><b>견적문의</b></h4>
		<hr style="border: solid 1px black">
	</div>

	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">견적 문의글 보기</th>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= question.getQuestionTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td >작성자</td>
						<td colspan="2"><%= question.getUserID() %></td>
					</tr>
					<tr>
						<td >작성일자</td>
						<td colspan="2"><%= question.getQuestionDate().substring(0, 11) + question.getQuestionDate().substring(11, 13) + "시 " +  question.getQuestionDate().substring(14, 16) + "분 "%></td>
					
					</tr>
					<tr>
						<td >내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= question.getQuestionContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>

			</table>
			<a href="question.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(question.getUserID())){
			%>
					<a href="questionUpdate.jsp?questionID=<%=questionID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="questionDeleteAction.jsp?questionID=<%=questionID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>

		</div>
	</div>

	<%-- 애니메이션을 담당할 자바스크립트 --%>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>