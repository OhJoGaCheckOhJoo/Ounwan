<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<c:set var="appPath" scope="application"  value="${pageContext.request.contextPath}" />
    <link href="${appPath}/css/main.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>오운완</title>
</head>
<body>
    <%@ include file="./common/header.jsp" %>

    <div class="container">
        <%@ include file="./common/nav.jsp" %>

        <div id="main-banner" class="main-banner">
            <img src = './images/v616_37.png'>
        </div>

        <div>
            <div class="text-1">인기상품</div>
            <div id="populars" class="main-product"></div>
        </div>

        <br>

        <div>
            <div class="text-1">중고거래</div>
            <div id="secondhands" class="main-product"></div>
        </div>

        <br>
    </div>

    <hr>
    
    <%@ include file="./common/footer.jsp" %>
    <script src="./js/main.js"></script>
</body>
</html>