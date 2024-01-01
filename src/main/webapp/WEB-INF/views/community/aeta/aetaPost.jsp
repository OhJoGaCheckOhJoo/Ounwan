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
<link href="${appPath}/css/main2.css" rel="stylesheet" />
<link href="${appPath}/css/header.css" rel="stylesheet" />
<link href="${appPath}/css/nav.css" rel="stylesheet" />
<link href="${appPath}/css/aeta.css" rel="stylesheet" />
<link href="${appPath}/css/aetaReportModal.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>애타 게시글</title>
</head>
<body>
	<%@ include file="../../common/header.jsp"%>
	
	<div class="container">
		<%@ include file="../../common/nav.jsp" %>
			
		<div id="aetaPostDetail">
		<div id="post-contents">
			<div>
				<div id="aetaTitle">${aetaPost[0].TITLE}</div>
				<span>
					<img src="${aetaPost[0].PROFILE_URL}"/>
				</span>
				<span id="aetaWriter">${aetaPost[0].CLIENT_ID}</span>
				<div>
					<span>${aetaPost[0].AETA_CREATED_DATE}</span>
					<span>조회수:${aetaPost[0].VIEWS}</span>
				</div>
				<c:if test="${aetaPost[0].CLIENT_ID != userInfo.clientId}">
					<button class="modal-button" onclick="openReportModal()">신고</button>
				</c:if>
			</div>
				<hr>

			<div id="aetaContent">
				<c:forEach items="${aetaPost}" var="aeta">
					<div>
						<img class="aeta-photo" src="${aeta.URL}"/>
					</div>
				</c:forEach>
				<input type="hidden" id="aetaCountImages" value="<c:out value='${loopStatus.count}' />"/>
				<div>${aetaPost[0].AETA_CONTENTS}</div>
			</div>
			<input type="hidden" value="${aetaPost[0].AETA_NUMBER}" id="aetaNumber"
				name="aetaNumber"/>

			<c:if test="${aetaPost[0].CLIENT_ID==clientId}">
				<button type="button" id="AetaUpdateBtn">수정</button>
				<button type="button" id="AetaDeleteBtn">삭제</button>
			</c:if>
		</div>
		<hr>
		<div id="aeta-post-likes">
			<a id="like-button" class="aeta-like"> 
				<c:choose>
					<c:when test="${aetaLikesCheck==1}">
						<img id="aeta-like-png" class="aeta-like-png"
							src="${appPath}/images/likeImages/like.png">
					</c:when>
					<c:otherwise>
						<img id="aeta-like-png" class="aeta-like-png"
							src="${appPath}/images/likeImages/dislike.png">
					</c:otherwise>
				</c:choose><span id="count-likes">${aetaCountLikes}</span>
			</a>
			<span>댓글 ${aetaCountComments}</span>
		</div>​
		<h4>댓글</h4>
		<h5>댓글은 수정이 불가능하르모 신중히 입력하세요!</h5>

		<div class="commentList">
			<c:forEach items="${aetaComments}" var="aeta">
				<c:if test="${aeta.CLIENT_ID ne null}">
					<div class='aeta-comment'>
						<input type="hidden" class="commentId"
							value="${aeta.COMMENT_NUMBER}">
						<span>
							<img class="aeta-profile" src="${aeta.PROFILE_URL}"/>
						</span>
						<span>${aeta.CLIENT_ID}</span>
						<span class='comment-date'>${aeta.CREATED_DATE }</span> 
						<c:if test="${aeta.CLIENT_ID == clientId}">
							<span class='comment-delete'> 
								<button type="button" id="deleteCommentBtn">삭제</button>
							</span>
						</c:if>
						<div class="commentContent">${aeta.CONTENTS}</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
		<div class="input-comment-wrap">
			<textarea id="inputComment" rows="" cols="" placeholder="댓글 입력"></textarea>
			<button type="button" id="insertCommentBtn">등록</button>
		</div>
	</div>
	
<%--
		</div>
		<hr>
 
		<a id="like-button" class="aeta-like"> 
			<c:choose>
				<c:when test="${aetaLikesCheck==1}">
					<img id="aeta-like-png" class="aeta-like-png"
						src="${appPath}/images/likeImages/like.png">
				</c:when>
				<c:otherwise>
					<img id="aeta-like-png" class="aeta-like-png"
						src="${appPath}/images/likeImages/dislike.png">
				</c:otherwise>
			</c:choose> <span>좋아요:<span id="count-likes">${aetaCountLikes}</span></span>
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
						<input type="hidden" class="commentId"
							value="${aeta.COMMENT_NUMBER}">
						<span>
							<img class="aeta-photo" src="${appPath}/${aeta.COMMENTER_PHOTO}"/></span>
						<span>댓글작성자: ${aeta.COMMENTER_ID}</span>
						<span>${aeta.AETA_CREATED_DATE }</span> 
						<span id=""> 
						<c:if test="${aeta.COMMENTER_ID == clientId}">
								<button type="button" id="deleteCommentBtn">삭제</button>
						</c:if>
						</span>
						<div class="commentContent">댓글:${aeta.AETA_COMMENT}</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
		<hr>
	
			<a id="like-button" class="aeta-like"> 
				<c:choose>
					<c:when test="${aetaLikesCheck==1}">
						<img id="aeta-like-png" class="aeta-like-png"
							src="${appPath}/images/likeImages/like.png">
					</c:when>
					<c:otherwise>
						<img id="aeta-like-png" class="aeta-like-png"
							src="${appPath}/images/likeImages/dislike.png">
					</c:otherwise>
				</c:choose> <span>좋아요:<span id="count-likes">${aetaCountLikes}</span></span>
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
							<input type="hidden" class="commentId"
								value="${aeta.COMMENT_NUMBER}">
							<span>댓글작성자: ${aeta.COMMENTER_ID}</span>
							<span>${aeta.AETA_CREATED_DATE }</span> 
							<span id=""> 
							<c:if test="${aeta.COMMENTER_ID == clientId}">
									<button type="button" id="deleteCommentBtn">삭제</button>
							</c:if>
							</span>
							<div class="commentContent">댓글:${aeta.AETA_COMMENT}</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div>
				<textarea id="inputComment" rows="" cols="" placeholder="댓글 입력"></textarea>
				<button type="button" id="insertCommentBtn">등록</button>
			</div>
		</div>
		--%>
	</div>
	<%@include file="../../common/footer.jsp"%>
	<%@ include file="./aetaReportModal.jsp"%> 
	<script src="../js/aeta.js"></script>
	<script src="../js/aetaReportModal.js"></script>
	
	<script>
		var appPath = "${appPath}";
	</script>
</body>
</html>