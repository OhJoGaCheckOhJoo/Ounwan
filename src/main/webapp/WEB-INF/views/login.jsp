<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>

<html>
<head>
	<title>ounwan</title>
	<script>
		function checkLogin(){
			var clientId = document.getElementById("clientId").value;
	        var password = document.getElementById("password").value;
			console.log("come");
			$.ajax({
				url:"${path}/login.do",
				method:"POST",
				data: { clientId: clientId, password: password },
				success: function(responseData){
					alert(responseData);
					
				}
			});
		}
	</script>
</head>
<body>
	
<h1>
	Login
</h1>
	<form id="loginForm" onsubmit="return checkLogin()" method="post">
		<input type="text" name="clientId" value="jj1234">
		<input type="text" name="password" value="123456789">
		<!-- <button type="submit" onclick="">login</button>
		<input type="button" onclick="checkLogin()" value="로그인">-->
		<button type="submit">로그인</button>
	</form>
	
<P>  The time on the server is ${serverTime}. </P>



</body>
</html>