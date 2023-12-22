<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>애타 게시글 작성</title>
</head>
<body>
	<br>
	<br>

	<h1>글쓰기</h1>
	<hr>
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
				<br> <label for="inputContent">내용</label><br>
				<textarea id="inputContent" placeholder=""></textarea>
				<br>
			</div>
			<div class="">
				<button type="button" id="PostingBtn">등록</button>
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