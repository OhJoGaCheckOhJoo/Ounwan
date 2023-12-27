<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
<title>ounwan1</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="${appPath}/css/main.css" rel="stylesheet" />
<link href="${appPath}/css/main2.css" rel="stylesheet" />
<link href="${appPath}/css/header.css" rel="stylesheet" />
</head>
<body>
    <header>
    	<div class="header">
	    	<a class="logo" href= "${appPath}"></a>
	    </div>
    </header>
    <div class="container">
        <div class="login-menu">
            <div><a href="#" class="login-menu-selected" id="loginAccount">&nbsp;로그인&nbsp;</a></div>
            <div class="float-right"><a href="#" id="findAccount">&nbsp;아이디/비밀번호 찾기&nbsp;</a></div>
        </div>

        <div class="login-container" id="loginAccountSelected">
            <div class="social-wrap">
                <a href="/myapp/clients/login/google"><img class="login login-radius" src="../images/google.png"></a><br>
                <a href="/myapp/clients/login/naver"><img class="login login-radius" src="../images/naver_btn.png"></a><br>
                <a href="/myapp/clients/login/kakao"><img class="login login-radius" src="../images/kakao_btn.png"></a><br>
            </div>
            <div class="login-wrap-1 float-right">
                <form>
                    <div class="login">
                        <input type="text" id="loginId" required >
                        <label>아이디</label>
                        <span></span>
                    </div>
                    <div class="login">
                        <input type="password" id="loginPassword" required>
                        <label>비밀번호</label>
                        <span></span>
                    </div>
                    <div class="login login-radius"><button type="button" id="loginButton">로그인</button></div>
                </form>
                <div class="login-sub"><a class="login-sub-1" href="#">회원이 아니신가요? 지금 가입하세요!</a></div>
                <div class="login-sub"><a class="login-sub-2" href="#">비회원 주문조회</a></div>
            </div>
        </div>

        <div class="login-container" id="findAccountSelected" hidden>
            <div class="login-wrap-2">
                <h3>아이디 찾기</h3>
                <form>
                    <div class="login">
                        <input id="findIdName" type="text" required>
                        <label>이름</label>
                        <span></span>
                    </div>
                    <div class="login">
                        <input id="findIdEmail" type="text" required>
                        <label>이메일</label>
                        <span></span>
                    </div>
                    <div class="email-autocomplete" id="emailAutocomplete"></div>
                    <div class="login login-radius"><button type="button" id="findId">아이디 찾기</button></div>
                </form>
            </div>
            <div class="login-wrap-1 float-right">
                <h3 class="login-padding-left">비밀번호 찾기</h3>
                <form>
                    <div class="login">
                        <input id="findPwId" type="text" required>
                        <label>아이디</label>
                        <span></span>
                    </div>
                    <div class="login">
                        <input id="findPwEmail" type="text" required>
                        <label>이메일</label>
                        <span></span>
                    </div>
                    <div class="login login-radius">
                        <button type="button" id="findPassword">
                            <div class="btn-div" id="findPWBtnDiv">임시비밀번호 발급</div>
                            <div class="loading-container" id="loading">
                                <div class="loading"></div>
                            </div>
                        </button>
                    </div>
                </form>
            </div>
            <div class="find-guide">* 회원가입 시 사용하신 이메일 주소를 통해 아이디/비밀번호를 찾으실 수 있습니다.</div>
        </div>
    </div>
    <script src="${appPath}/js/main.js"></script>
    <script>
    $(function(){
        $("#loginButton").on("click",function(){
            console.log("안녕");
            var obj = {
                "clientId" : $("#loginId").val(),
                "password" : $("#loginPassword").val()
            };
            $.ajax({
                url : '${appPath}/clients/login',
                type : 'POST',
                data : JSON.stringify(obj),
                contentType : 'application/json; charset=utf-8',
                dataType : 'text',
                success : function(responseData){
                    if(responseData === "success"){
                        alert("어서오소 ");
                        window.location.href = "${appPath}/"
                    } else if (responseData === "unAuthorized") {
                    	alert('이메일 인증을 완료해 주세요!');
                    	location.href = "${appPath}";
                    }else if (responseData === "withdraw") {
                    	alert("탈퇴한 회원입니다!");
                    	location.href = "${appPath}";
                    } else {
                        alert("로그인 실패");
                        console.log(responseData);
                    }
                },
                error : function(){
                }
            })
            console.log(obj.clientId);
        })
    })
    </script>
</body>
</html>
