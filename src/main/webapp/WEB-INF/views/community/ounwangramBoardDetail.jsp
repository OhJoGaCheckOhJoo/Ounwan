<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="ounwangram-main">
    <div>
        <a class="pointer ounwangram-profile"  href="/ounwan/ounwanProfile?clientId=${board.clientId}">
            <img src="${board.profileUrl}">
            <div>${board.clientId}</div>
        </a>
        <div class="ounwangram-threedot-div">
            <button id='threeDotBtn' class="ounwangram-threedot"><img class="ounwangram-threedot" src="../images/three_dot.png"></button>
        </div>
        <div class="gramBoardOption">
        	<c:if test="${userInfo.clientId eq board.clientId}">
	    		<button id='updateGramBoard' value="${board.communityNumber}">수정하기</button>
	            <button id='deleteGramBoard' value="${board.communityNumber}">삭제하기</button>
	    	</c:if>
	    	<c:if test="${userInfo.clientId ne board.clientId}">
	    		<button id='reportGramBoard' value="${board.communityNumber}@${board.clientId}">신고하기</button>
	    	</c:if>
        </div>
        <div class="ounwangram-board">
        	<img src="${board.imageUrl}">
        </div>
        <div class="ounwan-like">
        	<button id="ounwanLikeBtn" value="${board.communityNumber}">
        		<img src="../images/ounwan_like_${board.likesCheck}.png">
        	</button>
        	<span>${board.likes}</span><span>Likes</span>
        </div>
        <div class="ounwangram-content">${board.contents}</div>
        <div class="hashDiv">
        	<c:forEach var="hashtag" items="${board.hashTags}">
        		<span id='searchTag'>#${hashtag}</span>
        	</c:forEach>
		</div>
        <div class="ounwan-date">
            <span id="created"></span>
        	<span id="updated"></span>
        </div>
    </div>
</div>

<script>
	var createdDate = "${board.createdDate}".split(".")[0];
	var updatedDate = "${board.updatedDate}".length > 0 ? "(수정됨)" : "";
	$("#created").html(createdDate);
	$("#updated").html(updatedDate);
</script>