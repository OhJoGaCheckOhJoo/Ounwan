<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="./css/main.css" rel="stylesheet" >
    <link href="./css/community.css" rel="stylesheet" >
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>오운완</title>
</head>
<body>
	<%@ include file = "../common/header.jsp" %>
    ​
    <div class="container">
        <%@ include file = "../common/nav.jsp" %>
		<div>
	        <div>
	            <div id="myProfileImage"><img src="./images/v861_260.png"></div>
	            <div id="myProfileUserId">test</div>
	            <div id="myProfileOption">
	                <button id="myProfileButton">인바디</button>
	                <a id="myProfileWrite">+</a>
	            </div>
	            <div id="myProfileInfo">
	                <div><span class="info-bold">1234</span>&nbsp;posts</div>
	                <div><a class="info-bold" href="#">123</a>&nbsp;followers</div>
	                <div><a class="info-bold" href="#">234</a>&nbsp;following</div>
	            </div>
	        </div>
	        <hr>
	        <div id="myProfileBoards">
	            <img class="myProfileBoardImage" src="./images/v606_26.png">
	            <img class="myProfileBoardImage" src="./images/v606_27.png">
	            <img class="myProfileBoardImage" src="./images/v606_28.png">
	            <img class="myProfileBoardImage" src="./images/v616_37.png">
	            <img class="myProfileBoardImage" src="./images/v616_38.png">
	            <img class="myProfileBoardImage" src="./images/v616_39.png">
	        </div>
		</div>
	</div>
	
	<script src="./js/community.js"></script>
    <script src="./js/main.js"></script>
</body>
</html>