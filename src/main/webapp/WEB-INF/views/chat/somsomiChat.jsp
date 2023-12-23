<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>Insert title here</title>
<link rel="stylesheet" href="${appPath}/css/bixSiri/chat.css" />

</head>
<body>
	<div class="chat-wrap">
		<div class="chat-header">
			<h3>채팅방</h3>
		</div>
		<div id="chat" class="chat"></div>
		<!-- 채팅저장출력 -->
		<script id="temp" type="text/x-handlebars-template">
		{{#each .}}
       <div class="{{printLeftRight sender}}">
          <div class="sender">{{sender}}</div>
          <div class="message">{{message}}</div>
          <div class="date">{{regdate}}</div>
       </div>
		{{/each}}
       </script>
		<!-- 새로운채팅출력 -->
		<script id="temp1" type="text/x-handlebars-template">
       <div class="{{printLeftRight sender}}">
          <div class="sender">{{sender}}</div>
          <div class="message">{{message}}</div>
          <div class="date">{{date}}</div>
       </div>
       </script>
		<script>
			var clientId = "${userInfo.clientId}";
			console.log(clientId);
			Handlebars.registerHelper("printLeftRight", function(sender) {
				if (clientId != sender) {
					return "left";
				} else {
					return "right";
				}
			});
			
		</script>
		<div class="message-input">
			<textarea id="txtMessage" class="txtMessage" cols="30" rows="10"
				placeholder="메세지를 입력한 후에 엔터키를 누르세요."></textarea>
		</div>
	</div>

</body>
<script>
	var clientId = "${userInfo.clientId}";
	getList();
	//웹소캣 생성
	var sock = new SockJS("http://localhost:9090/myapp/echo");
	sock.onmessage = onMessage;

	var clientId = "${userInfo.clientId}";
	$("#txtMessage").on("keypress", function(e) {
		if (e.keyCode == 13 && !e.shiftKey) {
			e.preventDefault();
			var message = $("#txtMessage").val();
			if (message == "") {
				alert("메시지를 입력하세요.");
				$("#txtMessage").focus();
				return;
			}

			// 서버로 메시지 보내기
			sock.send(clientId + "|" + message);
			$("#txtMessage").val("");

			// db로 보내기
			$.ajax({
				type:'post',
				url:'${appPath}/bixSiri/chat/insertMessage',
				data : {
					sender : clientId,
					message : message
				},success : function(){
					
				}
				
			})
		}

	})

	function getList() {
		console.log("getList 왔다.")
		$.ajax({
			type : 'get',
			url : '${appPath}/bixSiri/chat/list',
			dataType : 'json',
			success : function(responseData) {
				var temp = Handlebars.compile($("#temp").html());
				$("#chat").append(temp(responseData));
			}
		})
	}

	// 서버로부터 메세지 받기
	function onMessage(msg) {
		var items = msg.data.split("|");
		var sender = items[0];
		var message = items[1];
		var date = items[2];
		var data = {
			"message" : message,
			"sender" : sender,
			"date" : date
		}
		var temp = Handlebars.compile($("#temp1").html());
		$("#chat").append(temp(data));
		window.scrollTo(0, $("#chat").prop("scrollHeight"))
	}
</script>
</html>