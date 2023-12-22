<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/community.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>애타 게시글</title>
</head>
<body>
	<%@include file="../../common/header.jsp"%>
	<%@include file="../../common/nav.jsp"%>
	<br>
	<br>
	

	<div id="aetaPostDetail">
		<div>
			<div>
				<div id="aetaTitle">${aetaPost[0].TITLE}</div>
				<div>프로필사진경로: ${aetaPost[0].WRITER_PHOTO}</div>
				<div id="aetaWriter">${aetaPost[0].CLIENT_ID}</div>
				<div>작성일:${aetaPost[0].AETA_CREATED_DATE}</div>
				<div>조회수:${aetaPost[0].VIEWS}</div>
				<hr>
			</div>
			
			<div id="aetaContent">
				<div>
				<!--  
				<img src="${appPath}/images/${inputImage}"
				-->
				</div>
				<div>${aetaPost[0].AETA_CONTENTS}</div>
			</div>
			<input type="hidden" value="${aetaPost[0].BOARD_NUMBER}" id="boardNO"
				name="boardNO" />

			<c:if test="${aetaPost[0].CLIENT_ID==clientId}">
				<button type="button" id="AetaUpdateBtn">수정</button>
				<button type="button" id="AetaDeleteBtn">삭제</button>
			</c:if>
		</div>
		<hr>

		<a id= "like-button"class="aeta-like">
			<c:choose>
				<c:when test="${aetaLikesCheck==1}">
					<img id="aeta-like-png" class="aeta-like-png" src="${appPath}/images/like.png">
				</c:when>
				<c:otherwise>
					<img id="aeta-like-png" class="aeta-like-png" src="${appPath}/images/dislike.png">
				</c:otherwise>
			</c:choose>
			<span>좋아요:<span id="count-likes">${aetaCountLikes}</span></span>
		</a>
		<div>댓글:${aetaPost[0].AETA_TOTAL_COMMENTS}</div>
		​
		<hr>
		<h4>댓글</h4>
		<h5>댓글은 수정이 불가능하르모 신중히 입력하세요!</h5>

		<div class="commentList">
			<c:forEach items="${aetaPost}" var="aeta">
				<c:if test="${aeta.COMMENTER_ID ne null}">
					<div>
						<input type="hidden" class="commentId" value="${aeta.COMMENT_NUMBER}">
						<div>댓글작성자:${aeta.COMMENTER_ID}</div>
						<div class="commentContent">댓글:${aeta.AETA_COMMENT}</div>
						<span>${aeta.AETA_CREATED_DATE }</span>
						<span id=""> 
							<c:if test="${aeta.COMMENTER_ID == clientId}">
								<button type="button" id="deleteCommentBtn">삭제</button>
							</c:if>
						</span>
					</div>
				</c:if>
			</c:forEach>
		</div>
		<div>
			<textarea id="inputComment" rows="" cols="">
				
			</textarea>
			<button type="button" id="insertCommentBtn">등록</button>
		</div>
	</div>
	<br>
	<br>
	<%@include file="../../common/footer.jsp"%>
	<script src="../js/community.js"></script>
	<script>
		var appPath = "${appPath}";
	</script>
</body>
</html>