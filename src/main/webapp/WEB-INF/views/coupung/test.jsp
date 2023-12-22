<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<button id="cartButton" type="button">상품 담기</button>
	<script>
		$("#cartButton").on("click", function() {
			obj = {
				"name" : "삭제될예정입니다.",
				"price" : "30000",		
				"option" : "얏호",
				"coupungNumber" : "6",
				"quantity" : "3",
				"url" : "../images/cartImage5.jpg"
			};
			$.ajax({
				url : "${appPath}/coupung/cart",
				type : "post",
				data : JSON.stringify(obj),
				contentType : "application/json" ,
				success : function(responseData) {
					if (responseData == "success") {
						alert("장바구니 추가에 성고하였습니다.");
						if (confirm("갈래?")) {
							location.href = "${appPath}/coupung/cart";
						}

					}
				}
			})
		})
	</script>
	
</body>
</html>