<%@page import="com.sun.xml.internal.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="purchase.PurchaseDAO" %>
<%@ page import="purchase.Purchase" %>
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
		
		User user = new User();
		UserDAO userDAO = new UserDAO();
		int userManager = 0;
		
		Purchase purchaes = new Purchase();
		PurchaseDAO purchaseDAO = new PurchaseDAO();
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
		
					<li class="active"><a href="purchase.jsp">제품구입</a></li>
	
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
			<div class="col-xs-15" style="background-color:white;">
				<%-- brand는 로고를 의미 --%>
				<a class="text-center" href="../main.jsp"><span style="color:black"><h1><font size="800sp" style= "font:bold 1.5em/1em Georgia, serif ;">Smart Bathroom</font></h1></span></a>
			</div>
		</div>
	</nav>

	<hr style="border: dashed 13px #bbb7b4;">
	
	<div class="container" style="border:2px solid #ffffff">
		<h4><b>제품구입</b></h4>
		<hr style="border: solid 1px black">
	</div>
	<%
	if(userID !=null){
	%>
	<div class="container" background-color:white-space;">
		<div class="row" style="width:100%; float:left; display:absolute; padding: 0px 0px 2px 0px;">
			<form method="post" action="purchaseAction.jsp">
				<table class="table" style="border: 1px solid #dddddd">
					<thead>
						<tr><td style="padding-left:20px"><h3><b>제품신청서</b></h3></td></tr>
						<tr>
							<th style="background-color: #eeeeee; padding-left:20px">가입자: &nbsp; <%= purchaseDAO.findUserName(userID) %></th>
							<th style="background-color: #eeeeee;"></th>
						</tr>
						<tr>
							<th style="background-color: #eeeeee; padding-left:20px">주　소: &nbsp; <%= purchaseDAO.findUserAddress(userID) %></th>
							<th style="background-color: #eeeeee;"></th>
						</tr>
						<tr>
							<th style="background-color: #eeeeee; padding-left:20px">휴대폰: &nbsp; <%= "0" + purchaseDAO.findUserfirPhone(userID) + '-' + purchaseDAO.findUsersecPhone(userID) + '-' + purchaseDAO.findUserthrPhone(userID)%> </th>
							<th style="background-color: #eeeeee;"></th>
						</tr>
						<tr>
							<th style="background-color: #eeeeee; padding-left:20px">이메일: &nbsp; <%= purchaseDAO.findUserEmail(userID) %></th>
							<th style="background-color: #eeeeee;"></th>
						</tr>
					</thead>
				
					<tbody>
						
						<tr><td style="padding-left:20px"><h3><b>제품 선택</b></h3></td></tr>
						<tr>
							<th style="width:40%; text-align:center">스마트 거울</th>
							
							<%
							if(purchaseDAO.findSmartMir(userID) == 1){
							%>
								<th style="width:60%; text-align:center"><input type="checkbox" name="smartMir" checked="checked"></th>
							<%
							}
							else{
							%>
								<th style="width:60%; text-align:center"><input type="checkbox" name="smartMir"></th>
							<%
							}
							%>
						</tr>
						<tr>
							<th style="width:40%; text-align:center">스마트 욕조</th>
							<%
							out.print(purchaseDAO.findSmartBath(userID));
							if(purchaseDAO.findSmartBath(userID) == 1){
							%>
								<th style="width:60%; text-align:center"><input type="checkbox" name="smartBath" checked="checked"></th>
							<%
							}
							else{
							%>
								<th style="width:60%; text-align:center"><input type="checkbox" name="smartBath"></th>
							<%
							}
							%>
						</tr>
						<tr>
							<th style="width:40%; text-align:center">디지털 샤워기</th>
							<%
							if(purchaseDAO.findDigitalShowerhead(userID) == 1){
							%>
								<th style="width:60%; text-align:center"><input type="checkbox" name="digitalShowerhead" checked="checked"></th>
							<%
							}
							else{
							%>
								<th style="width:60%; text-align:center"><input type="checkbox" name="digitalShowerhead"></th>
							<%
							}
							%>
						</tr>
						<tr>
							<th style="width:40%; text-align:center">자동 환풍기</th>
							<%
							if(purchaseDAO.findAutoVentilator(userID) == 1){
							%>
								<th style="width:60%; text-align:center"><input type="checkbox" name="autoVentilator" checked="checked"></th>
							<%
							}
							else{
							%>
								<th style="width:60%; text-align:center"><input type="checkbox" name="autoVentilator"></th>
							<%
							}
							%>
						</tr>
						<tr style="height:70px;">
							<th></th>
							<th style="vertical-align: middle; padding-right:50px"><input type="submit" class="btn btn-primary pull-right" value="신청"></th>
						</tr>
					
					</tbody>
				</table>
			</form>
		</div>
		<%
		}
		else{
		%>
		<script>
			location.href = '../login/login.jsp';
		</script>
		<%
		}
		%>
	</div>
	<%-- 애니메이션을 담당할 자바스크립트 --%>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>