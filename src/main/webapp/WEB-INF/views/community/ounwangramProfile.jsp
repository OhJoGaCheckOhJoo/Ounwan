<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="./css/main.css" rel="stylesheet" >
    <link href="./css/community.css" rel="stylesheet" >
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
    	const check = "${userProfileInfo.CLIENT_ID eq clientInfo.clientId}";
    </script>
    <title>오운완</title>
</head>
<body>
	<%@ include file = "../common/header.jsp" %>​
    <div class="container">
        <%@ include file = "../common/nav.jsp" %>
		<div>
	        <div>
	            <div id="myProfileImage"><img src="${userProfileInfo.PROFILE_URL}"></div>
	            <div id="myProfileUserId">${userProfileInfo.CLIENT_ID}</div>
	            <div id="myProfileOption">
	            	<c:if test="${userProfileInfo.CLIENT_ID eq clientInfo.clientId}">
	            		<button id="myProfileButton">인바디</button>
	                	<a id="myProfileWrite" href="writeGramBoard">+</a>
	            	</c:if>
	            	<c:if test="${userProfileInfo.CLIENT_ID ne clientInfo.clientId}">
	            		<button id="myProfileButton">
		            		<c:if test="${userProfileInfo.check}">
		            			following ✔
		            		</c:if>
		            		<c:if test="${!userProfileInfo.check}">
		            			follow
		            		</c:if>
	            		</button>
	            		<a id="myProfileWrite">···</a>
	            	</c:if>
	            </div>
	            <div id="myProfileInfo">
	                <div><span class="info-bold">${userProfileInfo.POSTS}</span>&nbsp;posts</div>
	                <div><a class="info-bold" href="#">${userProfileInfo.FOLLOWER}</a>&nbsp;followers</div>
	                <div><a class="info-bold" href="#">${userProfileInfo.FOLLOWING}</a>&nbsp;following</div>
	            </div>
	        </div>
	        <hr>
	        <div id="myProfileBoards">
	        	<c:forEach var="board" items="${userBoard}">
	        		<img class="myProfileBoardImage" src="${board.IMAGE_URL}">
	        	</c:forEach>
	        </div>
		</div>
	</div>
	
	<script src="./js/community.js"></script>
    <script src="./js/main.js"></script>
</body>
</html>