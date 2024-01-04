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
    <title>오운완</title>
	<link rel="shortcut icon" href="https://ounwan.s3.ap-northeast-2.amazonaws.com/1704307233380.png" />
</head>
<body>
	<%@ include file="../common/header.jsp" %>

    <div class="container">
        <%@ include file="../common/nav.jsp" %>
        <div id="writeOunwangram">
            <form id="uploadImage" class="uploadImage" enctype="multipart/form-data">
                <div id="darkBorder"></div>
                <label for="uploadImageInput">+</label>
                <input type="file" name="uploadImageInput" id="uploadImageInput" accept="image/*">
                <img id="ounwanUploadImage" hidden>
            </form>

            <div class="writeGramContents">
                <label>Content</label>
                <input id="ounwanGramContent" type="text" placeholder="최대 30자까지 작성 가능합니다.">
                <span></span>
                <div><div id="gramContentLength">0</div>/30</div>
            </div>

            <div class="writeGramContents">
                <label>Hash Tag</label>
                <input id="ounwanGramHashTag" type="text" placeholder="최대 15자까지, 5개 작성 가능합니다.">
                <span></span>
                <div><div id="gramHashTagLength">0</div>/15</div>
                <div id="addedHashTag">
                	&nbsp;
                </div>
                <div id="hashTagAlert">* 최대 5개까지 작성가능합니다.</div>
            </div>


            <div id="contentSubmit">
                <button id="submitButton">등록</button>
            </div>
        </div>
    </div>
    
    <hr>
    
    <%@ include file="../common/footer.jsp" %>
    
    <script src="${appPath}/js/community.js"></script>
    <script src="${appPath}/js/main.js"></script>
</body>
</html>