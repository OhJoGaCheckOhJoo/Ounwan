<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<div>
	<div id="post-contents">
		<div>
			<div id="aetaTitle">${aetaPost[0].TITLE}</div>
			<span> <img src="${aetaPost[0].PROFILE_URL}" /></span> 
			<span id="aetaWriter">${aetaPost[0].CLIENT_ID}</span>
			<div>
				<span>${aetaPost[0].AETA_CREATED_DATE}</span>
				<span>조회수:${aetaPost[0].VIEWS}</span>
			</div>
		</div>
		<hr>

		<div id="aetaContent">
			<c:forEach items="${aetaPost}" var="aeta">
				<div>
					<img class="aeta-photo" src="${aeta.URL}" />
				</div>
			</c:forEach>
			<input type="hidden" id="aetaCountImages"
				value="<c:out value='${loopStatus.count}'/>" />
			<div>${aetaPost[0].AETA_CONTENTS}</div>
		</div>
		<input type="hidden" value="${aetaPost[0].AETA_NUMBER}"
			id="aetaNumber" name="aetaNumber" />
		<button type="button" id="AetaUpdateBtn">수정</button>
		<button type="button" id="AetaDeleteBtn">삭제</button>
	</div>
	<hr>
	<span> 좋아요 갯수: ${aetaCountLikes}</span> 
	<span>댓글 갯수: ${aetaCountComments}</span>
	<h4>댓글</h4>
	<div class="commentList">
		<c:forEach items="${aetaComments}" var="aeta">
			<c:if test="${aeta.CLIENT_ID ne null}">
				<div class='aeta-comment'>
					<input type="hidden" class="commentId" value="${aeta.COMMENT_NUMBER}"> 
					<span> <img class="aeta-profile" src="${aeta.PROFILE_URL}" /> </span> 
					<span>${aeta.CLIENT_ID}</span> 
					<span class='comment-date'>${aeta.CREATED_DATE }</span>
					<span class='comment-delete'><button type="button" id="deleteCommentBtn">삭제</button></span>
					<div class="commentContent">${aeta.CONTENTS}</div>
				</div>
			</c:if>
		</c:forEach>
	</div>
</div>

<script>
	var appPath = "${appPath}";
</script>
