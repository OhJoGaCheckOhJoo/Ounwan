<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div id="aetaboardList">
	<table>
		<thead>
			<tr class="top">
				<th class="num">번호</th>
				<th class="title">제목</th>
				<th class="writer">작성자</th>
				<th class="date">작성일</th>
				<th class="count">조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="aeta" items="${aetaList}">
				<tr class="content" onclick="location.href='${appPath}/community/aetaPost?aetaNumber=${aeta.aetaNumber}'">
					<td class="num">${aeta.aetaNumber}</td>
					<td class="title">${aeta.title}</td>
					<td class="writer">${aeta.clientId}</td>
					<td class="date">${aeta.createdDate}</td>
					<td class="count">${aeta.views}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>	

<div id="aeta-pagination" class="aeta-pagination">
	<c:choose>
		<c:when test="${paginating.pageNumber<=1}">
			<span class="prev">[<<]</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:search(1)">[<<]</a>
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${paginating.pageNumber<=1}">
			<span class="prev">[<]</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:search(${paginating.pageNumber-1})">[<]</a>
		</c:otherwise>
	</c:choose>

	<c:forEach begin="${paginating.startPageNumber}"
		end="${paginating.endPageNumber}" var="i" step="1">
		<c:if test="${paginating.pageNumber eq i}">
			<a href="javascript:search(${i})" class="selected">${i}</a>
		</c:if>
		<c:if test="${paginating.pageNumber ne i}">
			<a href="javascript:search(${i})">${i}</a>
		</c:if>
		
	</c:forEach>

	<c:choose>
		<c:when test="${paginating.pageNumber==paginating.maxPageNumber}">
			<span class="next">[>]</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:search(${paginating.pageNumber+1})">[>]</a>
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${paginating.pageNumber==paginating.maxPageNumber}">
			<span class="next">[>>]</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:search(${paginating.maxPageNumber})">[>>]</a>
		</c:otherwise>
	</c:choose>

</div>

<script src="../js/community.js"></script>
<script src="../js/aeta.js"></script>
