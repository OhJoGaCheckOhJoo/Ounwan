<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!-- 모달 창 -->
<div id="shareModal" class="shareModal">
	<!-- 여기 아래에 추가 -->
	<div class="danggun-share-container">
		<span id="closeShareBtn" onclick="closeShareModal()">&times;</span>
		<div>
			<a id="clip-btn" href="javascript:clipboardShare()">해당 링크 복사하기</a>
		</div>
		<div>카카오톡으로 공유하기</div>
	</div>
</div>
<!-- 배경 회색 불투명도 -->
<div id="shareModalOverlay" class="share-modal-overlay"
	onclick="closeShareModal()"></div>