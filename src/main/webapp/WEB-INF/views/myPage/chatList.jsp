<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/chatList.css" rel="stylesheet">

<div class="chat-history-container">
	<div class="user-info-container">
	
		<div class="user-info-title">
            <button class="dropbtn">전체 채팅</button>
            <div class="dropdown-content">
                <a href="javascript:filterChats('all')">전체 채팅</a>
                <a href="javascript:filterChats('buy')">구매 채팅</a>
                <a href="javascript:filterChats('sell')">판매 채팅</a>
            </div>
        </div>
		<c:if test="${empty chatList}">
			<div>채팅 내역이 없습니다.</div>
		</c:if>
		<c:if test="${not empty chatList}">
			<c:forEach var="roomInfo" items="${chatList}" varStatus="loop">
				<a href="javascript:getChatRoom('${roomInfo.chatRoom.roomId}')">
					<div class="danggun-user-info">
						<div class="danggun-user-info img">
							<img src="${roomInfo.partnerInfo.profileUrl}">
						</div>
						 <div class="danggun-user-info name">
							<span>${roomInfo.partnerInfo.clientId}</span>
						 </div>
					 </div>
				</a>
			</c:forEach>
		</c:if>
	</div>
	<div class="chat-room-view" >
		<div id="chatRoomView" >
			<img class="image" src="${appPath}/images/image-20.png" />
			<div class="text-wrapper-5">채팅방을 선택해 주세요</div>
		</div>
	</div>
</div>

<script>
function getChatRoom(roomId) {
	$.ajax({
		type : "GET",
		url : "${appPath}/myPage/getChatInfo",
		data: { roomId: roomId },
		success : function(res) {
			$("#chatRoomView").html(res);
		}
	});
}
</script>