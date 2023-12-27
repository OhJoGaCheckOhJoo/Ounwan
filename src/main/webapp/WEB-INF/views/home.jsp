<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<c:set
  var="appPath"
  scope="application"
  value="${pageContext.request.contextPath}"
/>
<!DOCTYPE html>

<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>

<head>
	<c:set var="appPath" scope="application"  value="${pageContext.request.contextPath}" />
    <link href="${appPath}/css/main.css" rel="stylesheet" />
    <link href="${appPath}/css/main2.css" rel="stylesheet" />
    <link href="${appPath}/css/header.css" rel="stylesheet" />
    <link href="${appPath}/css/nav.css" rel="stylesheet" />
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
    <script>
    	$("#adminChat").on("click",function(e){
    		e.preventDefault();
    		if("${userInfo.clientId}"){
    			window.open("${appPath}/somsomi/chat","/chat/somsomiChat","width=500, height=800, top=200, left=200");
    		}else{
    			alert("로그인을 해주세요!");
    			window.location.href = "${appPath}/clients/login";
    		}
    	});
    </script>
    <script src="${appPath}/js/main.js"></script>
  </body>
</html>
