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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
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
	            		<button id="myInbodyButton">인바디</button>
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
	                <div><a class="info-bold" id="follower">${userProfileInfo.FOLLOWER}</a>&nbsp;followers</div>
	                <div><a class="info-bold" id="following" href="#">${userProfileInfo.FOLLOWING}</a>&nbsp;following</div>
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
	
	<%-- 인바디 모달 --%>
    <div id="modalWrap">
	  <div id="inbodyModal">
	    <div id="inbodyModalBody">
	      <a href="/ounwan/inbodyInsert">+</a>
	      <h1>${clientInfo.name}님의 인바디입니다.</h1>
	      <span id="closeBtn">&times;</span>
	      <div id="inbodyGraph"></div>
	    </div>
	  </div>
	</div>
	
	<div id="followModalWrap">
		<div id="followModal">
			<div id=followModalBody>
				<span id="closeBtn">&times;</span>
			</div>
		</div>
	</div>
	
	<script src="./js/community.js"></script>
    <script src="./js/main.js"></script>
</body>
</html>