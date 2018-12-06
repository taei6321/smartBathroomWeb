<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%-- bootstrap에서 어느 해상도에서도 전부 맞출 수 있게 설정 --%>
<meta name="viewport" content="width=device-width", initial-scale="1">

<%-- 디자인 담당할 css --%>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title>Smart Bathroom</title>
</head>
<body>

	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
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
					<li><a href="notice/notice.jsp">공지사항</a></li>
	
					<li><a href="introduce/introduce.jsp">제품소개</a></li>

					<li><a href="question/question.jsp">견적문의</a></li>
		
					<li><a href="purchase/purchase.jsp">제품구입</a></li>
	
					<li><a href="review/review.jsp">후기</a></li>
					
					<li><a href="contactUs/contactUs.jsp">고객문의</a></li>
					<%
					userManager = userDAO.find(userID);
					if(userManager == 1){
						%>
							<li><a href="management/management.jsp">고객관리</a></li>
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
							<li><a href="login/login.jsp">로그인</a></li>
							<li><a href="join/join.jsp">회원가입</a></li>
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
							<li><a href="login/logoutAction.jsp">로그아웃</a></li>
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
			<div class="col-xs-15" style="background-color:white-space; width:100%">
				<%-- brand는 로고를 의미 --%>
				<a class="text-center" href="main.jsp"><span style="color:black"><h1><font size="800sp" style= "font:bold 1.5em/1em Georgia, serif ;">Smart Bathroom</font></h1></span></a>
			</div>
		</div>
	</nav>

	<hr style="border: dashed 13px #bbb7b4;">
	<div class="comtainer">
		
		<div class="container" style="width:$(window).wodth(); align:center">
			<div id="myCarousel" class="carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel" data-slide-to="1"></li>
					<li data-target="#myCarousel" data-slide-to="2"></li>
					<li data-target="#myCarousel" data-slide-to="3"></li>
					<li data-target="#myCarousel" data-slide-to="4"></li>
				</ol>
				<ol class="carousel-inner">
					<div class="item active">
						<img src="images/main_1.png" style="width:100%; height:600px; align:center">
					</div>
					<div class="item">
						<img src="images/main_2.png" style="width:100%; height:600px; align:center">
					</div>
					<div class="item">
						<img src="images/main_3.png" style="width:100%; height:600px; align:center">
					</div>
					<div class="item">
						<img src="images/main_4.png" style="width:100%; height:600px; align:center">
					</div>
					<div class="item">
						<img src="images/main_5.png" style="width:100%; height:600px; align:center">
					</div>
					<a class="left carousel-control" href="#myCarousel" data-slide="prev">
						<span class="glyphicon glyphicon-chevron-left"></span>
					</a>
					<a class="right carousel-control" href="#myCarousel" data-slide="next">
						<span class="glyphicon glyphicon-chevron-right"></span>
					</a>
				</ol>	
			</div>
		</div>
	</div>
	
	<div class="container" style="width:100%; text-align:center">
		<font size="6" style="padding-top:50px; padding-left:10px; letter-spacing: 2px;"><b>
		전화문의
		</b></font><br>
		<font size="4" style="padding-left:10px; padding-top:15px; letter-spacing: 2px;"><b>
		TEL.010-3974-8850</b></font>
	</div>
	
	<%-- 애니메이션을 담당할 자바스크립트 --%>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
</body>
</html>