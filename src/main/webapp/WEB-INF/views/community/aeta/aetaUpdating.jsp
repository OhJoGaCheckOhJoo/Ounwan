<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>애타 게시글 수정</title>
</head>
<body>
<!-- <script>
	console.log("${aetaUpdate}");
</script> -->
	<br>
	<br>
	<h1>애타편집</h1>
	<hr>
		<div>
			<input type="hidden" id='boardNO' value="${aetaPost[0].BOARD_NUMBER}">
			<div>
				<label for="inputTitle"></label><input id="inputTitle" value="${aetaPost[0].TITLE}">
			</div>

			<form id="selectedImg" enctype="multipart/form-data">
				<label for="inputImg">이미지</label> 
				<input type="file" id="inputImg"/><br>
				<img class="imgURL" id="imgURL" src="">
			</form>

			<div>
				<br> <label for="inputContent">내용</label><br>
				<textarea id="inputContent" >${aetaPost[0].CONTENTS}</textarea>
				<br>
			</div>
			<div class="">
				<button type="button" id="updateConfirmBtn">수정</button>
			</div>
		</div>
	<br>
	<br>
	<script src="../js/community.js"></script>
	<script>
		var appPath = "${appPath}";
	</script>
		
		
		  

</body>
</html>