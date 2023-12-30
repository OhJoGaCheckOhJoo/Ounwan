<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>당근 신고 관리</h1>
	<div>
		<c:forEach var="product" items="${danggun}" varStatus="loopStatus">
			<a href="${appPath}/danggun/detail?danggunNumber=${product.danggunNumber}"> 
				<span>신고 번호: ${loopStatus.count}</span> 
				<span>당근 게시글 번호 : ${product.danggunNumber }</span> 
				<span>당근 상품명 : ${product.productName }</span> 
				<span>당근 가격 : ${product.price }</span> 
				<span>작성자 : ${product.clientId }</span> 
				<span>작성 일자 : ${product.uploadDate }</span> 
				<button id="restoreDanggun">복구</button>
			</a>
		</c:forEach>
	</div>
</body>
</html>