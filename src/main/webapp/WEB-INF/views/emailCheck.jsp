<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" value="${pageContext.request.contextPath}"></c:set>

<html>
<head>
<title>오운완</title>
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/main2.css" rel="stylesheet" />
<link href="${appPath}/css/emailCheck.css" rel="stylesheet" />
    <link href="${appPath}/css/header.css" rel="stylesheet" />
    <link href="${appPath}/css/nav.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>
      <div class="container">
	<%@ include file="./common/nav.jsp" %>
	     <div class="email-check-container">
        <div class="email-check">
            <div class="email-title">
                <div class="email-check-title">이메일 확인</div>
            </div>
            <div class="email-input-container">
                <form>
                    <div class="email-input">
                    <div class="clientIdPart">
                    <p class="emailCheckPart_T">아이디</p>
                        <input type="text" placeholder="아이디를 입력하세요" id="clientId" autocomplete="off" required/>
                       </div>
                       <div class="emailPart">
                       <p class="emailCheckPart_T">인증키</p>
                        <input type="text" placeholder="인증키를 입력하세요" id="emailAuth" autocomplete="off" required/>
                        </div>
                        <div class="checkBtnPart">
                        <button id="emailAuthBtn" type="button" onclick="checkAuth()">인증하기</button>
    					</div>
                    </div>
                </form>
            </div>
        </div>
        
    </div>
    </div>
​
<hr>
​
<%@ include file="./common/footer.jsp" %>
​<script>
$("#clientId, #emailAuth").keydown(function (e) {
    if (e.keyCode === 13) {
    	checkAuth();
    }
});

function checkAuth() {
	var obj = {
			"emailAuth" : $('#emailAuth').val(),
			"clientId" : $('#clientId').val()
	}
	
	$.ajax({
		url: "${appPath}/clients/emailAuth",
		type: "post",
		data: JSON.stringify(obj),
		contentType: 'application/json',
		success: function(res) {
			if (res === 'fail') {
				alert('잘못된 아이디 / 인증키 값입니다.');
				$('#emailAuth').val('');
				$('#clientId').val('');
				$('#clientId').focus();
			} else {
				alert('인증을 완료하였습니다! 로그인 해 주세요~');
				location.href='${appPath}/clients/login';
			}
		},
		error: function(request, status, error) {
               alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
           }
	});
}
</script>
</body>
</html>