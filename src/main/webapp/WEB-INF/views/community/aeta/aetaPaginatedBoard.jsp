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
<link href="${appPath}/css/main2.css" rel="stylesheet">
<link href="${appPath}/css/header.css" rel="stylesheet">
<link href="${appPath}/css/nav.css" rel="stylesheet">
<link href="${appPath}/css/aeta.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	console.log("${aetaList}");
</script>
<title>애타 게시판</title>
</head>
<body>
	<%@ include file="../../common/header.jsp"%>
	
	<div class="container">
		<%@ include file="../../common/nav.jsp"%>
		
		<div class="aeta">
			<div class="aeta-title">
				<strong>오늘의 애타</strong>
				<p>애타드립</p>	
				<button type="button" id="postBtn">글쓰기</button>
			</div>	
			
			<div class="aeta-list" id="aeta-list"></div>

			<div class="search">
				<select name="option">
					
					<option value="aetaSearchAll" ${selectedOption eq 'aetaSearchAll' ? 'selected' : ''} >전체(제목+작성자)</option>
					<option value="aetaSearchTitle" ${selectedOption eq 'aetaSearchTitle' ? 'selected' : ''}>제목</option>
					<option value="aetaSearchId" ${selectedOption eq 'aetaSearchId' ? 'selected' : ''}>작성자</option>
				</select>
				<form>
					<input id="inputValue" placeholder="검색어 입력" >
					<c:choose>
						<c:when test="${selectedOption eq 'choose'}">
							<input type=button id="searchBtn" value="검색" disabled="disabled">
						</c:when>
						<c:otherwise>
							<input type=button id="searchBtn" value="검색">
						</c:otherwise>
					</c:choose>
				</form>
			</div>
			<hr>
		</div>
	</div>
	

	<%@ include file="../../common/footer.jsp"%>

<script src="../js/aeta.js"></script>
	<script>
		var appPath = "${appPath}";
		
		$(function(){
			search();
		});
		
	</script>

</body>
</html>