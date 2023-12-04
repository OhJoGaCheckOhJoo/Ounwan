<%@ page language="java" contentType="text/html; charset="utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>ounwan</title>
</head>
<body>
	
<h1>
	Login
</h1>
	<form method = "post">
		<input type="text" name="clientId">
		<input type="text" name="password">
		<button type="submit">login</button>
	</form>
	
<P>  The time on the server is ${serverTime}. </P>
</body>
</html>