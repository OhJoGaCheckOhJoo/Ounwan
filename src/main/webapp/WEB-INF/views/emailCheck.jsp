<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" value="${pageContext.request.contextPath}"></c:set>

<html>
<head>
<title>ounwan</title>
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/emailCheck.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

	
	<header><a class="logo" href= "./"></a></header>

	     <div class="email-check-container">
        <div class="email-check">
            <div class="email-title">
                <div class="email-check-title">이메일 확인</div>
            </div>
            <hr>
            <div class="email-input-container">
                <form>
                    <div class="email-input">
                        <input type="text" placeholder="아이디 입력" id="clientId" required/>
                        <br>
                        <input type="text" placeholder="인증키 입력" id="emailAuth" required/>
                        <button id="emailAuthBtn" type="button">이메일 인증</button>
    
                    </div>
                </form>
            </div>
        </div>
        
    </div>
    
​
<hr>
​
<!-- footer -->
<footer>
	<div>
		<div>오운완 쇼핑몰 & 커뮤니티</div>
		<div>대표자 :  </div>
		<div>대표전화 : 010-9424-2784 / 주소 : 03993 서울특별시 마포구 월드컵북로4길 77, 1층</div>
		<div>상품&제휴 문의 메일 : ounwan50@gmail.com</div>
		<div class="text-1">고객센터 : 평일 오전 10:00 ~ 오후 5:00</div>
		<div class="text-1">(점심시간 12:00 ~ 13:00) 토/일/공휴일 휴무</div>
	</div>
	<div class="float-right">
		<br><br>
		<div><a href="#">이벤트</a></div>
		<div><a href="#">개인정보처리방침</a></div>
		<div><a href="#">이용약관</a></div>
		<div><img class="float-right img-1 pointer" src="images/insta.png"></div>
	</div>
</footer>
​<script>
	$('#emailAuthBtn').on('click', function() {
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
	});
</script>
</body>
</html>