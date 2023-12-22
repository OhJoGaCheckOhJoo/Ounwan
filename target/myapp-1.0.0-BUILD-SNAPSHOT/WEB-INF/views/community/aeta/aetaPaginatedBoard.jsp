<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/community.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>애타 게시판</title>

</head>
<body>
	<%@ include file="../../common/header.jsp"%>
	<script>
		console.log("${aetaList}");
	</script>


	<div class="container">
		<%@ include file="../../common/nav.jsp"%>
	</div>
	<hr>
	<!-- 여기 아래에 추가 -->
	<div class="aeta">
		<div class="aeta-title">
			<strong>오늘의 애타</strong>
			<p>애타드립</p>
		</div>
		<button type="button" id="postBtn">글쓰기</button>

	
		<!--
		페이지 번호 히든으로 저장  
		<input type="hidden" value="${paginating.pageNumber}" id="pageNumber">
		-->
		
		
		<hr>
		<div class="aeta-list" id="aeta-list">
			Error
		</div>
		<hr>
		<div class="search">
			<select name="option">
				<option selected disabled>선택</option>
				<option value="aetaSearchAll" ${selectedOption eq 'aetaSearchAll' ? 'selected' : ''} >전체(제목+작성자)</option>
				<option value="aetaSearchTitle" ${selectedOption eq 'aetaSearchTitle' ? 'selected' : ''}>제목</option>
				<option value="aetaSearchId" ${selectedOption eq 'aetaSearchId' ? 'selected' : ''}>작성자</option>
			</select>
			<form>
				<input id="inputValue" placeholder="검색어 입력" >
				<input type=button id="searchBtn" value="검색">
			</form>
		</div>
		<hr>
	</div>

	<%@ include file="../../common/footer.jsp"%>

	<script src="../js/community.js"></script>
	<script>
		var appPath = "${appPath}";
		
		$(function(){
			search();
		});
	</script>

</body>
</html>