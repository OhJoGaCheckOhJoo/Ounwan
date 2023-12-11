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
        <!-- nav -->
        <%@ include file = "../common/nav.jsp" %>
        
        <div class="ounwangram" id="ounwangram">
        	<div id="ounwangramProfile">
        		<img src="${clientInfo.profileURL}">
        		<div>
        			<div id="clientId">${clientInfo.clientId}</div>
        			<div>
	        			<button id="goMyProfile">My Profile</button>
	        			<a id="writeGramBoard" href="writeGramBoard">+</a>
        			</div>
        		</div>
        	</div>
            <div class="ounwangram-option">
                <a id="gramWholeBoard" class="pointer ounwangram_selected">전체 보기</a>
                <a id="gramFollowBoard" class="pointer">친구 보기</a>
            </div>
            <div id="ounwangramBoard"></div>
        </div>
        
        <button id="toTopScroll">⌅</button>
    </div>
    <hr>

	<script src="./js/community.js"></script>
    <script src="./js/main.js"></script>
</body>
</html>