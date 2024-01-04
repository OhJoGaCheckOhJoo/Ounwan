<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>오운완</title>
<link href="${appPath }/css/main.css" rel="stylesheet">
<link href="${appPath }/css/main2.css" rel="stylesheet">
<link href="${appPath }/css/header.css" rel="stylesheet">
<link href="${appPath }/css/nav.css" rel="stylesheet">
<link href="${appPath}/css/footer.css" rel="stylesheet" />
<link href="${appPath }/css/coupung/complete.css" rel="stylesheet">
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<%@ include file="../common/nav.jsp"%>
		<div class="order-complete-container">
            <div class="content-container">
                <div class="ment">주문이 완료되었습니다.</div>
                <div class="order-number-content">
                    <span class="order-number-title">주문번호는</span>
                    <span class="order-number">${orderNumber}</span>
                    <span> 입니다.</span>
                </div>
            </div>
        </div>		
	</div>
	<%@include file="../common/footer.jsp"%>
</body>
</html>