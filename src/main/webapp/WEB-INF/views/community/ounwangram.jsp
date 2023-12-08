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
            <div class="ounwangram-option">
                <a id="gramWholeBoard" class="pointer">전체 보기</a>
                <a id="gramFollowBoard" class="pointer">친구 보기</a>
            </div>
        </div>
        
    </div>
    <hr>

	<script src="./js/community.js"></script>
    <script src="./js/main.js"></script>
</body>
</html>