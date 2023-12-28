<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<div class="chatting-wrap">
	<div class="admin-chat-sub">
		<input type="text" placeholder="회원 아이디 검색">
		<c:if test="${empty chatRoom}">
			<div>문의한 회원이 없습니다.</div>
		</c:if>
		<c:forEach var="roomInfo" items="${chatRoom}" varStatus="loop">
		<a href="javascript:getChatRoom('${roomInfo.chatRoom.roomId}')">
			<div class="user-profile">
				<img src="${roomInfo.client.profileUrl}"> <span>${roomInfo.client.clientId}</span>
			</div>
		</a>
		</c:forEach>
	</div>
	<div id="adminChatting" class="admin-chatting"></div>
</div>



<script>
	$(".admin-chat-sub input").on("input", function() {
		for (var i = 0; i < $(".user-profile span").length; i++) {
			if ($(".user-profile span").eq(i).html().includes($(this).val())) {
				$(".user-profile").eq(i).show();
			} else {
				$(".user-profile").eq(i).hide();
			}
		}
	});

	var sock;

	function getChatRoom(roomId) {
		if (sock) {
			sock.close();
		}

		var sock = new SockJS("http://localhost:9090/myapp/echo");

		$.ajax({
			type : "GET",
			url : "${appPath}/admin/getChatRoom",
			data : {
				roomId : roomId
			},
			success : function(res) {
				$("#adminChatting").html(res);
			}
		});
	}
</script>