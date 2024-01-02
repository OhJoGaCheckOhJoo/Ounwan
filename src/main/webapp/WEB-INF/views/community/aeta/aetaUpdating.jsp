<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${appPath}/css/aeta.css" rel="stylesheet" />
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
		<input type="hidden" id='aetaNumber' value="${aetaPost[0].AETA_NUMBER}">
		<input type="hidden" id="aetaCountImages" value="${aetaCountImages}"/>
			
		<div>
			<label for="inputTitle"></label><input id="inputTitle"
				value="${aetaPost[0].TITLE}">
		</div>

		<form id="selectedImg" enctype="multipart/form-data">
			<label for="inputImg">이미지</label>
			<input type="file" multiple="multiple" id="inputImg" name="inputImg" onchange="readUrl(this)"/>
			<br>
			<c:forEach items="${aetaPost}" var="aeta">
				<div>
					<img class="aeta-photo" id="imgURL" src="${appPath}/images/aetaUploads/${aeta.URL}" />
				</div>
			</c:forEach>
		</form>

		<div>
			<br> <label for="inputContent">내용</label><br>
			<textarea id="inputContent">${aetaPost[0].CONTENTS}</textarea>
			<br>
		</div>
		<div class="">
			<button type="button" id="updatePost">수정</button>
			<button type="button" id="backToPostBtn">돌아가기</button>
		</div>
	</div>
	<br>
	<br>

	<script src="../js/aeta.js"></script>
	<script src="${appPath}/js/main.js"></script>
	<script>
		var appPath = "${appPath}";
	</script>


	  

</body>
</html>