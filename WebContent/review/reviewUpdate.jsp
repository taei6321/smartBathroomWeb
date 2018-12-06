<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="review.ReviewDAO" %>
<%@ page import="review.Review" %>
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
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'review.jsp'");
			script.println("</script>");
		}
		
		Review review = new ReviewDAO().getReview(reviewID);
		if(!userID.equals(review.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'review.jsp'");
			script.println("</script>");
		}
		
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
					<<li><a href="../notice/notice.jsp">공지사항</a></li>
	
					<li><a href="../introduce/introduce.jsp">제품소개</a></li>

					<li><a href="../question/question.jsp">견적문의</a></li>
		
					<li><a href="../purchase/purchase.jsp">제품구입</a></li>
	
					<li class="active"><a href="review.jsp">후기</a></li>
					
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
		<h4><b>후기</b></h4>
		<hr style="border: solid 1px black">
	</div>
	
	<div class="container">
		<div class="row">
			<form method="post" action="reviewUpdateAction.jsp?reviewID=<%= reviewID %>">
				<%-- table-striped는 홀수랑 짝수 끼리 색을 다르게 해서 게시글을 더 편하게 보기위한 설정 --%>
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<%-- thead : 테이블의 제목 --%>
					<thead>
						<%-- 테이블의 하나의 행, 하나의 줄 --%>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">후기 글수정 양식</th>
						</tr>
					</thead>
					<%-- 예시 데이터 --%>
					<tbody>
						<tr>
							<td> 작성자 : <%= review.getUserID() %></td>
						</tr>
						<tr>
						
							<td><textarea class="form-control" placeholder="글 내용" name="reviewContent" maxlength="2048" style="height: 350px;"><%=review.getReviewContent()%></textarea></td>
						</tr>
					</tbody>
					
				</table>
								
				<input type="submit" class="btn btn-primary pull-right" value="글수정">
					
			</form>
			
		</div>
	</div>
	
	<%-- 애니메이션을 담당할 자바스크립트 --%>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>