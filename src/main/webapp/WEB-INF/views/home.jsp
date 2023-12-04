<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>ounwan</title>
</head>
<body>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<h1>
	home
</h1>
	<form action="${path}/client/login.do">
		<input type="submit" value="로그인이동">
	</form>
	<button onclick="">login page</button>
	
<P>  The time on the server is ${serverTime}. </P>
</body>
</html>