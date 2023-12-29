<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/chatList.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<div class="chat-history-container">
	<div class="user-info-container">
		<div class="chat-list-header">
			<div class="user-info-title">
				<div>전체 대화</div>
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
document.addEventListener("DOMContentLoaded", function() {
    const links = document.querySelectorAll('.danggun-user-info');
    
    links.forEach(function(link) {
        link.addEventListener('click', function(event) {
            event.preventDefault();

            if (!link.classList.contains('clicked')) {
                link.classList.add('clicked');
            } else {
                link.classList.remove('clicked');
            }
            
            getChatRoom(link.dataset.roomId);
        });
    });
});


var sock; 

function getChatRoom(roomId) {
    if (sock) {
        sock.close();
    }

    sock = new SockJS("http://localhost:9090/myapp/danggunEcho");
    
    $.ajax({
        type : "GET",
        url : "${appPath}/myPage/getChatRoom",
        data: { roomId: roomId },
        success : function(res) {
            $("#chatRoomView").html(res);
        }
    });
}
</script>
