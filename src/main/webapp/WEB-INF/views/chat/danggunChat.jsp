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
<link rel="stylesheet" href="${appPath}/css/bixSiri/danggunChat.css" />
<link rel="shortcut icon" href="https://ounwan.s3.ap-northeast-2.amazonaws.com/1704307233380.png" />

</head>
<body>
	<div class="chat-wrap">
		<div class="chat-header">
			<div class="product-bar">
				<div class="product-info">
					<div>
						<c:forEach var="images" items="${post.productImagesList}">
							<c:if test="${images.type eq 0}">
								<img class="main-img" src="${images.url}" />
							</c:if>
						</c:forEach>
					</div>
					
					<div class="product-info-1">
						<div class="product-info-price">${post.price}원</div>
						<div>${post.productName}</div>
					</div>
				</div>
				<div class="product-info-2">
					<div>${post.tradeStep}</div>
				</div>
			</div>
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
          <div class="message">{{message}}
			<a href="{{messageId}}" style="display:{{printNone sender}}">&times;</a>
		</div>
          <div class="date">{{date}}</div>
       </div>
       </script>
		<script>
			var clientId = "${userInfo.clientId}";
			Handlebars.registerHelper("printLeftRight", function(sender) {
				if (clientId != sender) {
					return "left";
				} else {
					return "right";
				}
			});
			Handlebars.registerHelper("printNone", function(sender) {
	             if (clientId != sender) return "none";             
	        });
		</script>
		<div class="message-input">
			<textarea id="txtMessage" class="txtMessage" cols="30" rows="10"
				placeholder="메세지를 입력한 후에 엔터키를 누르세요."></textarea>
		</div>
	</div>
</body>
<script>
	$('.product-info-price').html($('.product-info-price').html().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
	getList();
	var clientId = "${userInfo.clientId}";
	var sock = new SockJS("3.36.64.49:8080/danggunEcho");
	sock.onmessage = onMessage;
	
	function getList() {
		var obj = {
			danggunNumber : "${post.danggunNumber}",
			seller : "${post.clientId}",
			buyer : "${userInfo.clientId}"
		};
		$.ajax({
			type : 'get',
			url : '${appPath}/danggun/bixSiri/chat/list',
			data : obj,
			dataType : 'json',
			success : function(responseData) {
				var temp = Handlebars.compile($("#temp").html());
				$("#chat").html(temp(responseData));
				$("#chat").scrollTop($("#chat")[0].scrollHeight);
			},
			error: function(request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
		})
	}
	
	$("#chat").on("click", ".message a", function(e){
		e.preventDefault();
		var messageId = $(this).attr("href");
		if(!confirm("메세지를 삭제하시겠습니까?")) return;
		$.ajax({
			type: "post",
			url : "${appPath}/danggun/bixSiri/chat/delete",
			data : {"sender" : clientId ,"messageId" : messageId},
			success : function(){
				sock.send("delete");
			},
			error: function(request, status, error) {
                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
		})
	})

	var danggunNumber = "${post.danggunNumber}";
	var roomId = "${post.clientId}" + clientId + danggunNumber;
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
				url : '${appPath}/danggun/bixSiri/chat/insertMessage',
				data : {
					"roomId" : roomId,
					"sender" : clientId,
					"message" : message
				},
				success : function(messageId) {
					sock.send(clientId + "|" + message + "|" + messageId); 
					getList();
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
		if(sender == "delete"){
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
		$("#chat").scrollTop($("#chat")[0].scrollHeight);
	}
</script>
</html>