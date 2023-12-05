<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>

<html>
<head>
<title>ounwan</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
		function checkLogin(){
	        
	        var obj = {"clientId": $("#clientId").val(), "password": $("#password").val()};
			$.ajax({
				url:"${path}/login",
				method:"POST",
				data:obj,
				success: function(responseData){
					alert(responseData);				
				}
			});
		}
	</script>
</head>
<body>

	<h1>Login</h1>
	<form id="loginForm" method="post">
		<input type="text" name="clientId" id="clientId" value="jj1234">
		<input type="text" name="password" id="password" value="123456789">
		<input type="button" onclick="checkLogin()" value="로그인"> 
	</form>

	<P>The time on the server is ${serverTime}.</P>

</body>
</html>