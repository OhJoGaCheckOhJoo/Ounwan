<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<table id="">
	<thead>
		<tr class="top">
			<th class="title">제목</th>
			<th class="writer">작성자</th>
			<th class="date">작성일</th>
			<th class="count">조회수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="aeta" items="${aetaList}">
			<tr class="content">
				<td class="title">
					<a href="${appPath}/community/aetaPost?aetaNumber=${aeta.aetaNumber}">${aeta.title}</a>
				</td>
				<td class="writer">${aeta.clientId}</td>
				<td class="date">${aeta.createdDate}</td>
				<td class="count">${aeta.views}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<hr>
<br>

<div id="aeta-pagination" class="aeta-pagination">
	<c:choose>
		<c:when test="${paginating.pageNumber<=1}">
			<span>[<<]</span>
			<span>[<]</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:search(1)">[<<]</a>
			<a href="javascript:search(${paginating.pageNumber-1})">[<]</a>
		</c:otherwise>
	</c:choose>

	<c:forEach begin="${paginating.startPageNumber}"
		end="${paginating.endPageNumber}" var="i" step="1">
		<a href="javascript:search(${i})">${i}</a>
	</c:forEach>

	<c:choose>
		<c:when test="${paginating.pageNumber==paginating.maxPageNumber}">
			<span>[>]</span>
			<span>[>>]</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:search(${paginating.pageNumber+1})">[>]</a>
			<a href="javascript:search(${paginating.maxPageNumber})">[>>]</a>
		</c:otherwise>
	</c:choose>

</div>
<script src="../js/aeta.js"></script>
