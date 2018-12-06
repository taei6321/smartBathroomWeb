<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="purchase.PurchaseDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="purchase" class="purchase.Purchase" scope="page"/>
<jsp:setProperty name="purchase" property="smartMir"/>
<jsp:setProperty name="purchase" property="smartBath"/>
<jsp:setProperty name="purchase" property="digitalShowerhead"/>
<jsp:setProperty name="purchase" property="autoVentilator"/>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Smart Bathroom</title>
</head>
<body>
	
	<%
		
		String userID = null;
		String purchaseID = null;
		String smartMir = null;
		String smartBath = null;
		String digitalShowerhead = null;
		String autoVentilator = null;
		
		PurchaseDAO purchaseDAO = new PurchaseDAO();
		
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		int result = 0;
		if(purchaseDAO.findPurchaseAvailable(userID) == 1){
			result = purchaseDAO.update(purchase, userID);
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('제품 구입 신청이 업데이트 되었습니다.')");
			script.println("location.href='purchase.jsp'"); // 사용자를 이전페이지로 돌려 보내는 것
			script.println("</script>");
		}
		else{
			result = purchaseDAO.apply(purchase, userID);
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('제품 구입 신청이 되었습니다.')");
			script.println("location.href='purchase.jsp'"); // 사용자를 이전페이지로 돌려 보내는 것
			script.println("</script>");
		}
		
	%>
	
</body>
</html>