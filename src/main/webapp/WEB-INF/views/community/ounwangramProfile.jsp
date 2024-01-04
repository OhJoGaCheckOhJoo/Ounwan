<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="appPath" scope="application" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${appPath}/css/main.css" rel="stylesheet" >
    <link href="${appPath}/css/main2.css" rel="stylesheet" />
    <link href="${appPath}/css/header.css" rel="stylesheet" />
    <link href="${appPath}/css/nav.css" rel="stylesheet" />
    <link href="${appPath}/css/community.css" rel="stylesheet" >
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
    <script>
    	const check = "${userProfileInfo.CLIENT_ID eq clientInfo.clientId}";
    </script>
    <title>오운완</title>
	<link rel="shortcut icon" href="https://ounwan.s3.ap-northeast-2.amazonaws.com/1704307233380.png" />
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
	            	<c:if test="${userProfileInfo.CLIENT_ID eq userInfo.clientId}">
	            		<button id="myInbodyButton">인바디</button>
	                	<a id="myProfileWrite" href="writeGramBoard">+</a>
	            	</c:if>
	            	<c:if test="${userProfileInfo.CLIENT_ID ne userInfo.clientId}">
	            		<button id="followButton">
		            		<c:if test="${userProfileInfo.check}">
		            			following ✔
		            		</c:if>
		            		<c:if test="${!userProfileInfo.check}">
		            			follow
		            		</c:if>
	            		</button>
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
	        		<div>
	        			<img class="myProfileBoardImage" src="${board.IMAGE_URL}">
	        			<input value="${board.COMMUNITY_NUMBER}" hidden>
        			</div>
	        	</c:forEach>
	        </div>
		</div>
	</div>
	
    <div id="modalWrap">
	  <div id="inbodyModal">
	    <div id="inbodyModalBody">
	      <a href="${appPath}/community/inbodyInsert">+</a>
	      <h1>${userInfo.name}님의 인바디입니다.</h1>
	      <span id="closeBtn">&times;</span>
	      <div id="inbodyGraph"></div>
	    </div>
	  </div>
	</div>
	
	<div id="followModalWrap">
		<div id="followModal">
			<div id=followModalBody>
				<span id="followCloseBtn">&times;</span>
				<div class="followProfile">
					<img src="${userProfileInfo.PROFILE_URL}">
					<h1>${userProfileInfo.CLIENT_ID}</h1>
				</div>
				<div id="followList"></div>
			</div>
		</div>
	</div>
	
	<div id="boardModalWrap">
		<div id="boardModal">
			<div id=boardModalBody>
				<span id="boardCloseBtn">&times;</span>
				<div id="boardDetail"></div>
			</div>
		</div>
	</div>
	
    <script src="${appPath}/js/main.js"></script>
    <script src="${appPath}/js/community.js"></script>
</body>
</html>