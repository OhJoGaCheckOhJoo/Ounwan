<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />

<div id="shareModal" class="shareModal">

	
	<div class="danggun-share-container">
		<span id="closeShareBtn" class="close-button" onclick="closeShareModal()">&times;</span>
		<div class="title-contianer">
		<div class="ounwan">OUNWAN</div>
		</div>		
		<div class="link-share-button">
			<a id="clip-btn" href="javascript:clipboardShare()">해당 링크 복사하기</a>
		</div>
	</div>
</div>
<div id="shareModalOverlay" class="share-modal-overlay"
	onclick="closeShareModal()"></div>