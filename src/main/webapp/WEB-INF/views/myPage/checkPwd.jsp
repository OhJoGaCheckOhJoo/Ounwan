<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<link href="${appPath}/css/checkPassword.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


<div class="pwd-check-wrap-1 float-right">
	<p>비밀번호 재확인</p>

	<div class="pwd-check">
		<input id="pwd-checkId" type="text" readonly="readonly"
			value="${testUser}">

	</div>
	<div class="pwd-check">
		<input id="pwd-checkPassword" type="password" required
			value="Fz202302!"> <label>비밀번호</label> <span></span>
	</div>

	<div class="button-container">
		<div class="pwd-check pwd-check-radius">
			<button id="confirmButton">확인</button>
		</div>
	</div>

</div>

<script>
	$("#confirmButton").on("click", function() {
		var enteredPassword = $('#pwd-checkPassword').val();
		console.log(enteredPassword);
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
						}
					});

				} else {
					// 비밀번호 확인 실패 처리
					alert("비밀번호가 일치하지 않습니다.");
				}
			}
		});
	});
</script>
