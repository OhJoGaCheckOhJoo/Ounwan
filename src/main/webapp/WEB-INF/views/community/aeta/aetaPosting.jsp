<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/main2.css" rel="stylesheet">
<link href="${appPath}/css/header.css" rel="stylesheet">
<link href="${appPath}/css/community.css" rel="stylesheet" />
<link href="${appPath}/css/aeta.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>애타 게시글 작성</title>
</head>
<body>
	<%@ include file="../../common/header.jsp"%>
	
	<div class="container">
		<h1 id='aetaPost'>애타 글쓰기</h1>
			<div>
				<div>
					<label for="inputTitle">제목</label><input id="inputTitle">
				</div>
	
				<form enctype="multipart/form-data" action="${appPath}/community/aetaPosting" method="post">
					<label for="inputImg">이미지</label> 
					<input type="file" multiple="multiple" id="inputImg" name="inputImg" onchange="readURL(this);"/> <br>
					<img id="imgPreview" src="#" width=200 height=150 alt="선택된 이미지가 없습니다">
				</form>
	
				<div>
					<label for="inputContent">내용</label>
					<textarea id="inputContent" placeholder=""></textarea>
				</div>
				<div class="">
					<button type="button" id="PostingBtn" onclick="validateForm()">등록</button>
				</div>
			</div>
	</div>
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