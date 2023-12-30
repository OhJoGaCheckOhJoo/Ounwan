<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application" value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/aetaList.css" rel="stylesheet">
<div class="section-header">
	<div class="section-title">게시글 내역</div>
</div>
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
					<td class="aeta-list title"><a href="${appPath}/community/aetaPost?aetaNumber=${list.aetaNumber}">${list.title}</a></td>
					<td class="aeta-list upload-date">
						<fmt:formatDate value="${list.createdDate}" pattern="yyyy-MM-dd" />
					</td>
					<td class="aeta-list client-id">${list.clientId}</td>
					<td class="aeta-list views">${list.views}</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>