<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/main2.css" rel="stylesheet" />
<link href="${appPath}/css/header.css" rel="stylesheet" />
<link href="${appPath}/css/nav.css" rel="stylesheet" />
<link href="${appPath}/css/aeta.css" rel="stylesheet" />
<link href="${appPath}/css/footer.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>애타 게시글 작성</title>
</head>
<body>
	<%@ include file="../../common/header.jsp"%>
	
	<div class="container">
		<%@ include file="../../common/nav.jsp" %>
		
		<h1 id='aetaPost'>애타 글쓰기</h1>
		
		<div class='aeta-post-wrap'>
			<div>
				<label for="inputTitle">제목</label><input id="inputTitle">
			</div>

			<form id="aetaPostImage" enctype="multipart/form-data" action="${appPath}/community/aetaPosting" method="post">
				<label for="inputImg"><img src="${appPath}/images/add_image.png"></label> 
				<input type="file" multiple="multiple" id="inputImg" name="inputImg"/>
				<div id="imagePreviewExp">이미지 미리보기 (이미지를 삭제하려면 해당 이미지를 클릭하면 됩니다.)</div>
				<div id="imagePreview"></div>
			</form>

			<div id="aetaInputContentWrap">
				<label for="inputContent">내용</label>
				<br>
				<textarea id="inputContent"></textarea>
			</div>
			<div class="aeta-post">
				<button type="button" id="PostingBtn" onclick="validateForm()">등록</button>
			</div>
		</div>
	</div>
	<%@include file="../../common/footer.jsp"%>
	<script src="../js/main.js"></script>
	<script src="../js/community.js"></script>
	<script src="../js/aeta.js"></script>
	<script>
		var appPath = "${appPath}";
		document.addEventListener("DOMContentLoaded", function () {
	        document.getElementById("PostingBtn").addEventListener("click", function () {
	            validateForm();
	        });
	    });
	</script>
</body>
</html>