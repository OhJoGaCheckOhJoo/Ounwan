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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>애타 게시판</title>

</head>
<body>
	<%@ include file="../../common/header.jsp" %>
	<script>
		console.log("${aetaList}");
	</script>

	
	<div class="container">
		<%@ include file="../../common/nav.jsp" %>
	</div>
	<hr>
	<!-- 여기 아래에 추가 -->
	<div class="aeta">
		<div class="aeta-title">
			<strong>오늘의 애타</strong>
			<p>애타드립</p>
		</div>
		<hr>
		<div class="aeta-list">
			<table id="aetaList">
				<thead>
					<tr class="top">
						<th class="num">번호</th>
						<th class="title">제목</th>
						<th class="writer">작성자</th>
						<th class="date">작성일</th>
						<th class="count">조회수</th>
					</tr>
				</thead>
				<tbody >
					<c:forEach var="aeta" items="${aetaList}">
						<tr class="content">
							<td class="num">${aeta.boardNumber}</td>
							<td class="title"><a href="${appPath}/community/aetaPost?boardNumber=${aeta.boardNumber}">${aeta.title}</a></td>
							<td class="writer">${aeta.clientId}</td>
							<td class="date">${aeta.createdDate}</td>
							<td class="count">${aeta.views}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<button type="button" id="postBtn">글쓰기</button>
<!-- <a href="community/aetaPosting">${aeta.title}</a> -->
							
		<hr>
		<div class="aeta-page">
			<a href="#" class="bt first"><<</a> <a href="#" class="bt prev"><</a>
			<a href="#" class="num on">1</a> <a href="#" class="num">2</a> <a
				href="#" class="num">3</a> <a href="#" class="num">4</a> <a href="#"
				class="numf">5</a> <a href="#" class="bt next">></a> <a href="#"
				class="bt last">>></a>
		</div>
		<hr>
		<div class="search">
			<select name="option">
				<option>선택</option>
				<option value="aetaSearchAll">전체(제목+작성자)</option>
				<option value="aetaSearchTitle">제목</option>
				<option value="aetaSearchId">작성자</option>
			</select>
			<form>
				<input id="inputValue" placeholder="검색어 입력" >
				<button type=button id="searchBtn">검색</button>
			</form>
		</div>
		<hr>
	</div>
	
	<%@ include file="../../common/footer.jsp" %>

	<script src="../js/community.js"></script>
	<script>
		var appPath = "${appPath}";
	</script>
	
</body>
</html>