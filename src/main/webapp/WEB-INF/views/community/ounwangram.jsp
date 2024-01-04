<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <title>오운완</title>
	<link rel="shortcut icon" href="https://ounwan.s3.ap-northeast-2.amazonaws.com/1704307233380.png" />
</head>
<body>
	<%@ include file = "../common/header.jsp" %>
    ​
    <div class="container">
        <%@ include file = "../common/nav.jsp" %>
        
        <div class="ounwangram" id="ounwangram">
        	<div class="gramSearch">
                <input id="gramSearch" type="text">
                <button id="searchButton">
                	<img src="${appPath}/images/search_btn.png">
                </button>
                <div id="gramSearchResult"></div>
            </div>
        	<div id="ounwangramProfile">
        		<img src="${userInfo.profileUrl}">
        		<div>
        			<div id="clientId">${userInfo.clientId}</div>
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
    
    <div id="modalWrap">
	  <div id="modalContent">
	    <div id="modalBody">
	      <span id="closeBtn">&times;</span>
	      <div>
	      	<div>
	      		<div id="reportTitle">
	      			OUNWAN
	      		</div>
	      		<div>
		      		<span class="reportId">신고자</span>
		      		<span>|&nbsp;${userInfo.clientId}</span>
	      		</div>
	      		<div>
	      			<span class="reportId">피신고자</span>
	      			<span id="reportId"></span>
	      		</div>
	      	</div>
	      	<hr>
	      	<div id="reportReason">
	      		<div>신고 사유를 선택해주세요.</div>
	      		<div><input class="reason" value="0" type="checkbox">스팸홍보/도배글입니다.</div>
	      		<div><input class="reason" value="1" type="checkbox">음란물입니다.</div>
	      		<div><input class="reason" value="2" type="checkbox">불법정보를 포함하고 있습니다.</div>
	      		<div><input class="reason" value="3" type="checkbox">청소년에게 유해한 내용입니다.</div>
	      		<div><input class="reason" value="4" type="checkbox">욕설/생명경시/혐오/차별적 게시물입니다.</div>
	      		<div><input class="reason" value="5" type="checkbox">개인정보 노출 게시물입니다.</div>
	      		<div><input class="reason" value="6" type="checkbox">불쾌한 표현이 있습니다.</div>
	      		<div><input class="reason" value="7" type="checkbox">불법촬영물 등이 포함되어 있습니다.</div>
	      		<button id="reportSubmit">신고하기</button>
	      	</div>
	      </div>
	    </div>
	  </div>
	</div>

    <script src="${appPath}/js/main.js"></script>
    <script src="${appPath}/js/community.js"></script>
</body>
</html>