<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div id="followListOption">
	<a id="follower"
	<c:if test="${kind eq 'follower'}">
		class="selectedFollow"
	</c:if>
	>Follower</a>
	<a id="following"
	<c:if test="${kind eq 'following'}">
		class="selectedFollow"
	</c:if>
	>Following</a>
</div>
<hr>
<c:forEach var="follower" items="${followers}">
	<div class="follow">
		<a href="${appPath}/community/ounwanProfile?clientId=${follower.FOLLOWER_ID}">
			<img src="${follower.PROFILE_URL}">
		</a>
		<div>${follower.FOLLOWER_ID}</div>
		<c:if test="${follower.FOLLOW_CHECK eq 0}">
			<button id="followBtn" value="${follower.FOLLOWER_ID}">follow</button>
		</c:if>
		<c:if test="${follower.FOLLOW_CHECK eq 1}">
			<button id="followBtn" value="${follower.FOLLOWER_ID}">following ✔</button>
		</c:if>
	</div>
</c:forEach>