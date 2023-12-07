<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<title>ounwan</title>
	<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<h1>
	home
</h1>
<h2>
${userInfo }
</h2>
	<div id="here"></div>
	 <script>
	 console.log("${userInfo.socialId}");
	 if("${userInfo.socialId}" != "") {
		 $("#here").html('<button id="btn">로그아웃</button>');
	 } else {
		 $("#here").html(`
				 <form action="login" method="get">
					<input type="submit" value="로그인이동">
				</form>
				 `);
	 }
	 $("#btn").on("click", function() {
		 location.href='${path}/logout';
	 })
	 </script>
	
	
	
<P>  The time on the server is ${serverTime}. </P>
</body>
</html>