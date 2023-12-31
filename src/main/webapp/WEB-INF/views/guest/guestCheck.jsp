<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오운완</title>
<link href="${appPath}/css/main2.css" rel="stylesheet">
<link href="${appPath}/css/main.css" rel="stylesheet">
<link href="${appPath}/css/header.css" rel="stylesheet">
<link href="${appPath}/css/nav.css" rel="stylesheet">
<link href="${appPath}/css/guest/guestCheck.css" rel="stylesheet">
<link href="${appPath}/css/guest/guestOrderListModal.css"
	rel="stylesheet">
</head>
<body>
	<div class="guest-check-container">
		<div class="guest-check-title">비회원 주문 조회</div>
		<div class="guest-check-content">
			<div class="input-container">
				<div class="input-info order-number">
					<div class="input-title order-number">주문번호</div>
					<input class="input order-number">
				</div>
				<div class="input-info email">
					<div class="input-title email">이메일</div>
					<input class="input email">
				</div>
			</div>
			<button class="guest-check-button">확인</button>
		</div>
	</div>
<%@ include file="../guest/guestOrderListModal.jsp"%>	
</body>
</html>