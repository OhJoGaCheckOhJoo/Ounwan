<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

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
	<tbody>
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

