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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>오운완</title>
<link href="${appPath}/css/main2.css" rel="stylesheet">
<link href="${appPath}/css/main.css" rel="stylesheet">
<link href="${appPath}/css/header.css" rel="stylesheet">
<link href="${appPath}/css/nav.css" rel="stylesheet">
<link href="${appPath}/css/footer.css" rel="stylesheet" />
<link href="${appPath}/css/guest/guestCheck.css" rel="stylesheet">
<link href="${appPath}/css/guest/guestOrderListModal.css"
	rel="stylesheet">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<%@ include file="../common/nav.jsp"%>
		<div id="guestModal">
			<div class="guest-check-container">
				<div class="guest-check-title">비회원 주문 조회</div>
				<div class="guest-check-content">
					<div class="input-container">
						<div class="input-info order-number">
							<div class="input-title order-number">주문번호</div>
							<input class="input order-number" id="orderNumberInput" autocomplete="off" placeholder="주문번호를 입력하세요.">
						</div>
						<div class="input-info email">
							<div class="input-title email">이메일</div>
							<input class="input email" id="emailInput" autocomplete="off" placeholder="이메일을 입력하세요.">
						</div>
					</div>
					<button type="button" class="guest-check-button" onclick="checkGuestInfo()">확인</button>
				</div>
			</div>
		</div>
	</div>
	
	<%@include file="../common/footer.jsp"%>
	<script src="${appPath}/js/guest.js"></script> 
</body>
</html>