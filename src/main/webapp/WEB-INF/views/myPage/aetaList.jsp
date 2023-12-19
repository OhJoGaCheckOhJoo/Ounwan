<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/aetaList.css" rel="stylesheet">

<h1>내가 쓴 애타 게시글 내용</h1>
<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성일</th>
			<th>작성자</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="list" items="${aetaList}" varStatus="loop">
			<tr>
				<td class="aeta-list num">${aetaList.size() - loop.index }</tdh>
				<td class="aeta-list title">${list.title}</td>
				<td class="aeta-list upload-date">${list.createdDate}</td>
				<td class="aeta-list clied-id">${list.clientId}</td>
				<td class="aeta-list views">${list.views}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>