<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<link href="${appPath}/css/footer.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>오운완</title>
<link rel="shortcut icon" href="https://ounwan.s3.ap-northeast-2.amazonaws.com/1704307233380.png" />
</head>
<body>
	<div class="overlay"></div>
	<%@ include file="../../common/header.jsp"%>

	<div class="container">
		<%@ include file="../../common/nav.jsp"%>

		<div id="aetaPostDetail" class="aeta-post-detail">
			<div id="post-contents">
				<div class="host-head">
					<c:choose>
						<c:when
							test="${aetaPost[0].CLIENT_ID != userInfo.clientId and admin eq null}">
							<button class="modal-button" onclick="openReportModal()">신고</button>
						</c:when>
						<c:otherwise>
							<div class="non-report-button"></div>
						</c:otherwise>
					</c:choose>
					<div id="aetaTitle" class="host-title">${aetaPost[0].TITLE}</div>
					<div class="host-head-info">
						<div class="host-info">
							<img class="host-image" src="${aetaPost[0].PROFILE_URL}" />
							<div id="aetaWriter" class="host-id">${aetaPost[0].CLIENT_ID}</div>
						</div>
						<div class="post-info">
							<span class="host-create-date">작성일&nbsp;|&nbsp;${aetaPost[0].AETA_CREATED_DATE}</span>
							&nbsp;&nbsp;&nbsp; <span class="host-view-count">조회수&nbsp;|&nbsp;${aetaPost[0].VIEWS}</span>
						</div>
					</div>
				</div>

				<hr>

				<div id="aetaContent" class="aeta-content">
					<div class="post-photos-container">
						<div class="post-photos">
							<c:forEach items="${aetaPost}" var="aeta">
								<img class="post-photo" src="${aeta.URL}" />
							</c:forEach>
						</div>
					</div>
					<input type="hidden" id="aetaCountImages"
						value="<c:out value='${loopStatus.count}' />" />
					<div class="post-content">${aetaPost[0].AETA_CONTENTS}</div>
				</div>
				<input type="hidden" value="${aetaPost[0].AETA_NUMBER}"
					id="aetaNumber" name="aetaNumber" />

				<c:if test="${aetaPost[0].CLIENT_ID==userInfo.clientId}">
					<div class="post-buttons">
						<button type="button" id="AetaUpdateBtn"
							class="post-button update">수정</button>
						<button type="button" id="AetaDeleteBtn"
							class="post-button delete">삭제</button>
					</div>

				</c:if>
			</div>
			<hr>
			<div class="post-footer">
				<div id="aeta-post-likes">
					<c:if test="${admin eq null}">
						<a id="like-button" class="aeta-like">
							<div class="like-container">
								<c:choose>
									<c:when test="${aetaLikesCheck==1}">
										<img id="aeta-like-png" class="aeta-like-png"
											src="${appPath}/images/likeImages/like.png">
									</c:when>
									<c:otherwise>
										<img id="aeta-like-png" class="aeta-like-png"
											src="${appPath}/images/likeImages/dislike.png">
									</c:otherwise>
								</c:choose>
								<div id="count-likes" class="count-likes">${aetaCountLikes}</div>
							</div>

						</a>
					</c:if>
					<c:if test="${admin ne null}">
					</c:if>
					<span>댓글 ${aetaCountComments}</span>
				</div>
				​
				<div>
					<span class="comment-title">댓글</span> <span class="comment-ment">댓글은
						수정이 불가능하므로 신중히 입력하세요!</span>
				</div>

				<div id="commentList" class="comment-list">
					<c:forEach items="${aetaComments}" var="aeta">
						<c:if test="${aeta.CLIENT_ID ne null}">
							<div class='post-comment'>
								<input type="hidden" class="commentId"
									value="${aeta.COMMENT_NUMBER}">
								<div class="comment-info">
									<div class="commemter-info">
										<img class="comment-profile" src="${aeta.PROFILE_URL}" />
										<div>${aeta.CLIENT_ID}</div>
									</div>
									<span class='comment-date'>
					                    ${fn:substring(aeta.CREATED_DATE, 0, 10)}
					                </span>
								</div>

								<c:if test="${aeta.CLIENT_ID == userInfo.clientId}">
									<span class='comment-delete'>
										<button type="button" id="deleteCommentBtn"
											class="delete-comment-button">삭제</button>
									</span>
								</c:if>
								<div class="comment-content">${aeta.CONTENTS}</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
				<div class="input-comment-wrap">
					<textarea id="inputComment" rows="" cols="" placeholder="댓글 입력"
						class="post-textarea"></textarea>
					<button type="button" id="insertCommentBtn"
						class="post-register-button">등록</button>
				</div>
			</div>
		</div>
	</div>
	<%@include file="../../common/footer.jsp"%>
	<%@ include file="./aetaReportModal.jsp"%>
	<script src="../js/aeta.js"></script>
	<script src="../js/aetaReportModal.js"></script>
	<script src="${appPath}/js/main.js"></script>
	<script>
		var appPath = "${appPath}";
		$(function() {
			if ('${aetaPost[0].VISIBILITY}' == 0 && '${admin}' == "") {
				$(".overlay").show();
				setTimeout(function() {
					alert("판매가 중지된 상품입니다.");
					window.location.href = "${appPath}/community/aetaBoard";
				}, 100);
			}

		});
	</script>
</body>
</html>