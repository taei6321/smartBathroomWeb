<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="review.ReviewDAO" %>
<%@ page import="review.Review" %>
<%@ page import="java.util.ArrayList" %>
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
<style type="text/css">
	a, a:hover{
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>

	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
					<li><a href="../notice/notice.jsp">공지사항</a></li>
	
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
		<h4><b>후기</b></h4>
		<hr style="border: solid 1px black">
	</div>
	
	<div class="container">
		<div class="row">
			<%-- table-striped는 홀수랑 짝수 끼리 색을 다르게 해서 게시글을 더 편하게 보기위한 설정 --%>
			<table class="table table-striped" style="float:left; border: 1px solid #dddddd;">
				<%-- thead : 테이블의 제목 --%>
				<%
						ReviewDAO reviewDAO = new ReviewDAO();
						ArrayList<Review> list = reviewDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++){
					%>
				
					
					<tr>
						<td><h4><b><a href="reviewView.jsp?reviewID=<%= list.get(i).getReviewID()%>" style="padding-left: 10px"><%= list.get(i).getReviewContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></b></h4></td>
					</tr>

					<tr>
						<td><h6> &nbsp; <%= list.get(i).getUserID() %> &nbsp; <%= list.get(i).getReviewDate().substring(0, 11) + list.get(i).getReviewDate().substring(11, 13) + "시 " +  list.get(i).getReviewDate().substring(14, 16) + "분 "%></h6></td>
					</tr>
					<%
						}
					%>
				
			</table>
			
			<%
				if(pageNumber != 1){
			%>
					<a href="review.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arraw-left">이전</a>
			<%
				}
				if(reviewDAO.nextPage(pageNumber + 1)){
			%>
					<a href="review.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
			
				<a href="reviewWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
			
		</div>
	</div>
	
	<%-- 애니메이션을 담당할 자바스크립트 --%>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>