<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/aetaList.css" rel="stylesheet">

<div class="section-header">
	<div class="section-title">게시글 내역</div>
</div>
<div id="myPage-aetaList">
	<table>
		<thead>
			<tr class="head-tr">
				<th>번호</th>
				<th>제목</th>
				<th>작성일</th>
				<th>작성자</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty aetaList}">
				<tr class="none-content">
					<td colspan="5">게시글 내역이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${not empty aetaList}">
				<c:forEach var="list" items="${aetaList}" varStatus="loop">
					<tr class="content-tr">
						<td class="aeta-list num">${aetaList.size() - loop.index }</td>
						<td class="aeta-list title"><a
							href="${appPath}/community/aetaPost?aetaNumber=${list.aetaNumber}">${list.title}</a></td>
						<td class="aeta-list upload-date"><fmt:formatDate
								value="${list.createdDate}" pattern="yyyy-MM-dd" /></td>
						<td class="aeta-list client-id">${list.clientId}</td>
						<td class="aeta-list views">${list.views}</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>

<div id="aeta-pagination" class="aeta-pagination">
	<c:choose>
		<c:when test="${pages.maxPageNumber==0}"></c:when>
		<c:when test="${pages.pageNumber<=1}">
			<span class="prev">[<<]</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:search(1)">[<<]</a>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${pages.maxPageNumber==0}"></c:when>
		<c:when test="${pages.pageNumber<=1}">
			<span class="prev">[<]</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:search(${paginating.pageNumber-1})">[<]</a>
		</c:otherwise>
	</c:choose>
	<c:forEach begin="${pages.startPageNumber}"
		end="${pages.endPageNumber}" var="i" step="1">
		<c:if test="${pages.pageNumber eq i}">
			<a href="javascript:search(${i})" class="selected">${i}</a>
		</c:if>
		<c:if test="${pages.pageNumber ne i}">
			<a href="javascript:search(${i})">${i}</a>
		</c:if>
	</c:forEach>
	<c:choose>
		<c:when test="${pages.maxPageNumber==0}"></c:when>
		<c:when test="${pages.pageNumber==paginating.maxPageNumber}">
			<span class="next">[>]</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:search(${paginating.pageNumber+1})">[>]</a>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${pages.maxPageNumber==0}"></c:when>
		<c:when test="${pages.pageNumber==paginating.maxPageNumber}">
			<span class="next">[>>]</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:search(${pages.maxPageNumber})">[>>]</a>
		</c:otherwise>
	</c:choose>
</div>

<script>
	function search(page) {
		$.ajax({
			url : appPath + "/myPage/aetaList",
			data : {"page" : page},
			type : "get",
			success : function(response) {
				$('#content').html(response);
			},
			error: function(request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }	
		});
	}
</script>