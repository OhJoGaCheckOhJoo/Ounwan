<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
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
<title>애타 게시글 수정</title>
</head>
<body>
	<div class="overlay"></div>
	<%@ include file="../../common/header.jsp"%>
	
	<div class="container">
		<%@ include file="../../common/nav.jsp" %>
	<!-- <script>
	console.log("${aetaUpdate}");
</script> -->
	
	<h1 id='aetaUpdate'>애타 수정하기</h1>
	
	<div class='aeta-post-wrap'>
		<div>
			<input type="hidden" id='aetaNumber' value="${aetaPost[0].AETA_NUMBER}">
			<input type="hidden" id="aetaCountImages" value="${aetaCountImages}"/>
				
			<div>
				<label for="inputTitle">제목</label>
				<input id="inputTitle" value="${aetaPost[0].TITLE}">
			</div>
	
			<form id="aetaPostImage" enctype="multipart/form-data">
				<label for="inputImg"><img src="${appPath}/images/add_image.png"></label>
				<input type="file" multiple="multiple" id="inputImg" name="inputImg" onchange="readUrl(this)"/>
				<div id="imagePreviewExp">이미지 미리보기 (이미지를 삭제하려면 해당 이미지를 클릭하면 됩니다.)</div>
				<div id="imagePreview">
					<c:forEach items="${aetaPost}" var="aeta">
						<div>
							<img class="aeta-photo" id="imgURL" src="${appPath}/images/aetaUploads/${aeta.URL}" />
						</div>
					</c:forEach>
				</div>
			</form>
	
			<div id="aetaInputContentWrap">
				<label for="inputContent">내용</label><br>
				<textarea id="inputContent">${aetaPost[0].CONTENTS}</textarea>
			</div>
			<div class="aeta-update-wrap">
				<button type="button" id="backToPostBtn">돌아가기</button>
				<button type="button" id="updatePost">수정</button>
			</div>
		</div>
		<br>
		<br>
	</div>

	</div>
	<%@include file="../../common/footer.jsp"%>
	<script src="../js/aeta.js"></script>
	<script src="${appPath}/js/main.js"></script>
	<script>
		var appPath = "${appPath}";
	</script>
</body>
</html>