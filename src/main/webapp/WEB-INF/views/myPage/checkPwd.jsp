<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/checkPassword.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<div class="pwd-check-container">
	<div class="pwd-check-wrap-1 float-right">
		<p>비밀번호 재확인</p>
	
		<div class="pwd-check">
			<input id="pwd-checkId" type="text" readonly="readonly"
				value="${userInfo.clientId}">
	
		</div>
		<div class="pwd-check">
			<input id="pwd-checkPassword" type="password" autocomplete="none" required > <label>비밀번호</label> <span></span>
		</div>
	
		<div class="button-container">
			<div class="pwd-check pwd-check-radius">
				<button id="confirmButton">확인</button>
			</div>
		</div>
	</div>
</div>
<script>
	$("#confirmButton").on("click", function() {
		var enteredPassword = $('#pwd-checkPassword').val();
		$.ajax({
			url : "${appPath}/myPage/checkPwd",
			type : "POST",
			data : {
				"enteredPassword" : enteredPassword
			},
			success : function(res) {
				if (res === "success") {
					$.ajax({
						type : "GET",
						url : "${appPath}/myPage/modifyUserInfo",
						success : function(res) {
							$("#content").html(res);
						},
						error: function(request, status, error) {
			                alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			            }
					});
				} else {
					alert("비밀번호가 일치하지 않습니다.");
				}
			}
		});
	});
</script>