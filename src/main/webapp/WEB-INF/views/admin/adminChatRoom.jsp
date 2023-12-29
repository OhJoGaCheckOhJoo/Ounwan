<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="chat-container" id="chatContainer">
	<div id="chat" class="chat"></div>
		<!-- 채팅저장출력 -->
		<script id="temp" type="text/x-handlebars-template">
		{{#each .}}
       <div class="{{printLeftRight sender}}">
          <div class="sender">{{sender}}</div>
          <div class="message">{{message}}
			<a href="{{messageId}}" style="display:{{printNone sender}}">X</a>
		</div>
          <div class="date">{{regdate}}</div>
       </div>
		{{/each}}
       </script>
		<!-- 새로운채팅출력 -->
		<script id="temp1" type="text/x-handlebars-template">
       <div class="{{printLeftRight sender}}">
          <div class="sender">{{sender}}</div>
          <div class="message">{{message}}
			<a href="{{messageId}}" style="display:{{printNone sender}}">X</a>
		</div>
          <div class="date">{{date}}</div>
       </div>
       </script>
		<script>
			var clientId = "${userInfo.clientId}";
			Handlebars.registerHelper("printLeftRight", function(sender) {
				if ("admin" != sender) {
					return "left";
				} else {
					return "right";
				}
			});
			Handlebars.registerHelper("printNone", function(sender) {
				if ("admin" != sender)
					return "none";
			});
		</script>
		</div>
		<div class="message-input">
			<textarea id="txtMessage" class="txtMessage" cols="30" rows="10"
				placeholder="메세지를 입력한 후에 엔터키를 누르세요."></textarea>
		</div>
	


<script>
	getList();
	var clientId = "${userInfo.clientId}";
	var sock = new SockJS("http://localhost:9090/myapp/echo");
	sock.onmessage = onMessage;
	function getList() {
		var roomId = "${roomId}";
		$.ajax({
			type : 'get',
			url : '${appPath}/admin/chat/list',
			data : {
				roomId : roomId
			},
			success : function(responseData) {
				var temp = Handlebars.compile($("#temp").html());
				$("#chat").html(temp(responseData));
			}
		});
	}

	$("#chat").on("click", ".message a", function(e) {
		e.preventDefault();
		var messageId = $(this).attr("href");
		if (!confirm(messageId + "을(를) 삭제하실래요?"))
			return;
		$.ajax({
			type : "post",
			url : "${appPath}/admin/chat/delete",
			data : {
				"sender" : "admin",
				"messageId" : messageId
			},
			success : function() {
				sock.send("delete");
			}
		})
	})

	$("#txtMessage").off("keydown").on("keydown", function(e) {
		
		if (e.keyCode == 13 && !e.shiftKey) {
			e.preventDefault();
			var sender = "admin";
			var message = $("#txtMessage").val();
			if (message == "") {
				alert("메시지를 입력하세요.");
				$("#txtMessage").focus();
				return;
			}

			$("#txtMessage").val("");
			var roomId = "${roomId}";

			$.ajax({
				type : 'post',
				url : '${appPath}/admin/chat/insertMessage',
				data : {
					"roomId" : roomId,
					"sender" : sender,
					"message" : message
				},
				success : function(messageId) {
					e.preventDefault();
					sock.send(sender + "|" + message + "|" + messageId);
				}
			});
		}

	});

	// 서버로부터 메세지 받기
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
		window.scrollTo(0, $("#chat").prop("scrollHeight"))
	} 
</script>
