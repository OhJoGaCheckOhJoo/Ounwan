<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<meta charset="EUC-KR">
<title>오운완</title>
<link rel="stylesheet" href="${appPath}/css/bixSiri/chat.css" />
<link rel="shortcut icon" href="https://ounwan.s3.ap-northeast-2.amazonaws.com/1704307233380.png" />
</head>
<body>
	<div class="chat-wrap">
		<div class="chat-header">
			<div class="chat-header-wrap">
				<div>
					<img class="logo" src="https://ounwan.s3.ap-northeast-2.amazonaws.com/1704307286927.png"/>
				</div>
			</div>
		</div>
		<div class="chat-notice">
			<h3>오운완에 문의하기</h3>
			<span>고객센터 : 평일 오전 10:00 ~ 오후 5:00 (점심시간 12:00 ~ 13:00)
				토/일/공휴일 휴무</span>
		</div>
		<div id="chat" class="chat"></div>
		<script id="temp" type="text/x-handlebars-template">
		{{#each .}}
       <div class="{{printLeftRight sender}}">
          <div class="sender">{{sender}}</div>
          <div class="message">{{message}}
			<a href="{{messageId}}" style="display:{{printNone sender}}">&times;</a>
		</div>
          <div class="date">{{regdate}}</div>
       </div>
		{{/each}}
       </script>
		<script id="temp1" type="text/x-handlebars-template">
       <div class="{{printLeftRight sender}}">
            <div class="sender">{{sender}}</div>
            <div class="message">
                {{message}}
                <a href="{{messageId}}" style="display:{{printNone sender}}">&times;</a>
            </div>
            <div class="date">{{date}}</div>
       </div>
       </script>
		<script>
			var clientId = "${userInfo.clientId}";
			Handlebars.registerHelper("printLeftRight", function(sender) {
				if (sender == "quit") {
					return "center";
				} else if (clientId != sender) {
					return "left";
				} else {
					return "right";
				}
			});
			Handlebars.registerHelper("printNone", function(sender) {
				if (clientId != sender)
					return "none";
			});
		</script>
		<div class="message-input">
			<button id="chatComplete" class="chat-complete">채팅 종료</button>
			<textarea id="txtMessage" class="txtMessage" cols="30" rows="10"
				placeholder="메세지를 입력한 후에 엔터키를 누르세요."></textarea>
		</div>
	</div>

</body>
<script>
	getList();
	var clientId = "${userInfo.clientId}";
	var sock = new SockJS("http://localhost:9090/myapp/echo");
	sock.onmessage = onMessage;

	function getList() {
		$.ajax({
			type : 'get',
			url : '${appPath}/somsomi/chat/list',
			dataType : 'json',
			success : function(responseData) {
				var temp = Handlebars.compile($("#temp").html());
				$("#chat").html(temp(responseData));
				$("#chat").scrollTop($("#chat")[0].prop("scrollHeight"));
				$("#chat").animate({scrollTop:$("#chat").prop("scrollHeight")});
			},
			error: function(request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
		})
	}

	$("#chat").on("click", ".message a", function(e) {
		e.preventDefault();
		var messageId = $(this).attr("href");
		if (!confirm("메세지를 삭제하시겠습니까?"))
			return;
		$.ajax({
			type : "post",
			url : "${appPath}/somsomi/chat/delete",
			data : {
				"sender" : clientId,
				"messageId" : messageId
			},
			success : function() {
				sock.send("delete");
			},
			error: function(request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
		})
	})

	var roomId = clientId + clientId;
	$("#txtMessage").on("keypress", function(e) {
		if (e.keyCode == 13 && !e.shiftKey) {
			e.preventDefault();
			var message = $("#txtMessage").val();
			if (message == "") {
				alert("메시지를 입력하세요.");
				$("#txtMessage").focus();
				return;
			}

			$("#txtMessage").val("");

			$.ajax({
				type : 'post',
				url : '${appPath}/somsomi/chat/insertMessage',
				data : {
					"roomId" : roomId,
					"sender" : clientId,
					"message" : message
				},
				success : function(messageId) {
					sock.send(clientId + "|" + message + "|" + messageId);
				},
				error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
			});
		}

	});

	$("#chatComplete").on("click", function() {
		if (confirm("대화를 종료하시겠습니까?")) {
			$.ajax({
				type : 'get',
				url : '${appPath}/somsomi/chat/quit',
				data : {
					"roomId" : roomId
				},
				success : function(messageId) {
					var quitMessage = "<div id='quitMessage' class='quit-message'>관리자와의 채팅이 종료되었습니다.</div>";
					$("#chat").append($(quitMessage));
					window.scrollTo(0, $("#chat").prop("scrollHeight"))
				},
				error: function(request, status, error) {
	                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
	            }
			});
		}
	});

	function onMessage(msg) {
		var items = msg.data.split("|");
		var sender = items[0];
		if (sender == "delete") {
			getList();
			return;
		}
		var message = items[1];
		var messageId = items[2];
		var date = items[3];
		var data = {
			"message" : message,
			"messageId" : messageId,
			"sender" : sender,
			"date" : date
		}
		var temp = Handlebars.compile($("#temp1").html());
		$("#chat").append(temp(data));
		$("#chat").scrollTop($("#chat")[0].prop("scrollHeight"));
		$("#chat").animate({scrollTop:$("#chat").prop("scrollHeight")});		
	}
</script>
</html>