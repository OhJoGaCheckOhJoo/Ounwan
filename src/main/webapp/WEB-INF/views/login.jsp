<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>

<html>
<head>
<title>ounwan</title>
<style>

:root {
  --main-color: #2E3C8A;
}

* {
  margin: 0px;
  padding: 0px;
  font-size: 16px;
}

a {
  text-decoration-line: none;
  color: #000;
}

header {
  margin: 20px auto 20px auto;
  width: 1250px;
  height: 80px;
}

header div {
  height: 80px;
}

header div a {
  display: inline-block;
  margin: 26.8px 15px 0px 0px;
  font-size: 1.25em;
  font-weight: bold;
}

header div button {
  height: 50px;
  width: 120px;
  font-size: 1.25em;
  font-weight: bold;
  color: #fff;
  border-radius: 10px;
  background-color: var( --main-color);
}

nav {
  width: 1250px;
  height: 40px;
  font-size: 1.5em;
  font-weight: bold;
  border-top: 1px solid var(--main-color);
  border-bottom: 1px solid var(--main-color);
}

nav > div {
  display: inline-block;
}

nav div > a {
  display: inline-block;
  width: 130px;
  text-align: center;
}

.nav-main {
  width: 1250px;
  height: 40px;
  vertical-align: middle;
}

.nav-main > div {
  display: inline-block;
  vertical-align: middle;
  height: 40px;
  margin-left: 100px;
}

.nav-main > div > a {
  display: inline-block;
  margin-top: 9.5px;
  height:31.5px;
  vertical-align: middle;
}

.nav-submenu {
  position: absolute;
  width: 130px;
  background-color: white;
  border-radius: 10px;
  box-shadow: 1px 1px 1px rgba(0, 0, 0, 0.2);
  transform: scaleY(0);
  transform-origin: top;
  transition: transform 0.25s ease;
}

.nav-submenu a {
  display: block;
  padding-bottom: 5px; 
}

nav a:hover {
  color: var(--main-color);
}

.nav-main a:hover ~ .nav-submenu {
  transform: scaleY(1);
}

.nav-submenu:hover {
  transform: scaleY(1);
}

.nav-menu {
	width: 1125px;
	position: relative;
	padding-left: 125px;
	z-index: 10;
	background-color: #fff;
	transform: scaleY(0);
	transform-origin: top;
  	transition: transform 0.25s ease;
  	box-shadow: 3px 3px 3px rgba(0,0,0,0.3);
  	border-bottom-left-radius: 10px;
  	border-bottom-right-radius: 10px;
  	bottom: 20%;
}

.nav-menu div > div {
	width: 130px;
	margin-left: 102px;
	display: inline-block;
	vertical-align: top;
}

.nav-menu div div a {
	display: block;
	width: 130px;
	text-align: center;
}

.menu-trigger,
.menu-trigger span {
  display: inline-block;
  transition: all .4s;
  box-sizing: border-box;
}

.menu-trigger {
  position: relative;
  width: 25px;
  height: 22px;
}

.menu-trigger span {
  position: absolute;
  left: 0;
  width: 100%;
  height: 4px;
  background-color: #000;
  border-radius: 4px;
}

.menu-trigger span:nth-of-type(1) {
  top: 0;
}

.menu-trigger span:nth-of-type(2) {
  top: 9px;
}

.menu-trigger span:nth-of-type(3) {
  bottom: 9.5px;
}

.menu-trigger.active-1 span:nth-of-type(1) {
  -webkit-transform: translateY (9px) rotate (-45deg);
  transform: translateY(9px) rotate(-45deg);
}

.menu-trigger.active-1 span:nth-of-type(2) {
  opacity: 0;
}

.menu-trigger.active-1 span:nth-of-type(3) {
  -webkit-transform: translateY(-9px) rotate(45deg);
  transform: translateY(-9px) rotate(45deg);
}

footer {
  margin: auto;
  width: 1250px;
}

footer div {
  display: inline-block;
  width: 610px;
  margin-top: 4px;
}

.float-right {
  float: right;
}

.float-right > div {
  text-align: right;
}

.text-1 {
  font-size: 24px;
}

.img-1 {
  width: 30px;
  height: 30px;
}

.img-2 {
  width: 220px;
  height: 220px;
}

.margin-1 {
	margin: 0px 30px 0px 30px;
}

.margin-2 {
	margin: 0px 30px 0px 30px;
}

.pointer {
  cursor: pointer;
}

.logo {
  display: inline-block;
  width: 180px;
  height: 80px;
  background-image: url("../images/logo.png");
  background-size: cover;
}

.container {
  margin: auto;
  width: 1250px;
}

.main-banner {
  width: 1200px;
  height: 450px;
}

.main-banner > img {
  width: 1100px;
  height: 350px;
  margin: 50px;
}

.main-product > div {
  display: inline-block;
  width: 220px;
  margin: 10px 15px 10px 15px;
  text-align: center;
  vertical-align: top;
}

.main-product > div img:hover {
  animation-name: scale-1;
  animation-duration: 0.3s;
  animation-timing-function: linear;
  animation-fill-mode: forwards;
}

@keyframes scale-1 {
  100% {
    transform: scale(1.05);
  }
}

.login {
  width: 300px;
  height: 80px;
  margin-top: 10px;
  position: relative;
}

.login-container {
  width: 1100px;
  height: 300px;
  padding: 100px 75px 100px 75px;
  border: 1px solid #ccc;
  border-radius: 20px;
}

.login-container > div h3 {
  width: 300px;
  font-size: 1.1em;
  padding-bottom: 20px;
}

.login-wrap-1 {
  width: 300px;
  height: 300px;
  display: inline-block;
  border-left: #ccc solid 1px;
  padding: 0px 100px 0px 149.5px;
}

.login-wrap-2 {
  width: 300px;
  height: 300px;
  display: inline-block;
  padding: 0px 149.5px 0px 100px;

}

.social-wrap {
  width: 300px;
  height: 300px;
  display: inline-block;
  padding: 0px 149.5px 0px 100px;
}

.login-wrap-1 > *, .login-wrap-2 > * {
  float: inherit;
}

.login-wrap-1 > form div button, .login-wrap-2 > form div button {
  width: 300px;
  height: 65px;
  border-radius: 10px;
  border: 0px;
  background-color: var(--main-color);
  color: #fff;
  cursor: pointer;
}

.login-wrap-1 > div, .login-wrap-2 > div {
  margin-top: 5px;
}

.login-wrap-1 > div a, .login-wrap-2 > div a {
  width: 400px;
}

.login-wrap-1 > div button, .login-wrap-2 > div button {
  background-color: var(--main-color);
  color: #fff;
}

.login-wrap-1 > .btn, .login-wrap-2 > .btn {
  padding:0px;
  background-color: var(--main-color);
}

.login-radius {
  border-radius: 10px;
}

.line {
  width: 0px;
  height: 300px;
  border: 1px solid #ddd;
  display: inline-block;
  margin: auto;
}

.login-sub {
  width: 300px;
  text-align: center !important;
}

.login-sub-1 {
  color: var(--main-color);
}

.login-sub-2 {
  color: #aaa;
  text-decoration-line: underline;
}

.login-menu {
  border-bottom: 4px solid #eee;
  margin: 10px 0px 20px 0px;
  padding-bottom: 10px;
  width: 1250px;
}

.login-menu > div {
  display: inline-block;
  width: 615px;
  text-align: center !important;
}

.login-menu div a {
  font-size: 1.5em;
}

.login-menu-selected {
  padding-bottom: 10px;
  border-bottom: 4px solid var(--main-color);
}

.img-border {
  border-radius: 5px;
  box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.2);
}

.login span {
  display: block;
  position: absolute;
  bottom: 0;
  left: 0%;
  background-color: #666;
  width: 0;
  height: 2px;
  border-radius: 2px;
  transition: 0.5s;
}

.login label {
  position: absolute;
  color: #555;
  left: 10px;
  font-size: 20px;
  bottom: 8px;
  transition: all .2s;
}

.login input {
  font-size: 1.3em;
  color: #222222;
  width: 270px;
  height: 51.8px;
  border: none;
  border-bottom: solid #aaaaaa 1px;
  padding: 22px 10px 0px 20px;
  position: relative;
  background: none;
  z-index: 5;
}

.login span {
  display: block;
  position: absolute;
  bottom: 0;
  left: 0%;
  background-color: #666;
  width: 0;
  height: 2px;
  border-radius: 2px;
  transition: 0.5s;
  margin-bottom: 3.7px;
}

.login label {
  position: absolute;
  color: #aaa;
  left: 10px;
  font-size: 20px;
  bottom: 10px;
  transition: all .2s;
}

.login input:focus ~ label, .login input:valid ~ label {
  font-size: 16px;
  bottom: 50px;
  color: #666;
  font-weight: bold;
}

.login input:focus ~ span, .login input:valid ~ span {
  width: 300px;
}

.login input::placeholder { color: #aaaaaa; }
.login input:focus {outline: none; }

.social-wrap a img {
  box-shadow: 3px 3px 3px #ccc;
  border: 1px solid #ddd;
}

.find-guide {
  text-align: center;
  margin-top: 5px;
  color: #888;
}

.email-autocomplete {
  position: absolute;
  background-color: rgb(255, 255, 255);
  z-index: 10;
  padding: 0px 20px 0px 20px;
}

.mail-menu {
  font-size: 24px;
  margin-top: 10px;
}

.mail-menu:hover {
  background-color: var(--main-color);
  color: #fff;
}

#link {color: #E45635;display:block;font: 12px "Helvetica Neue", Helvetica, Arial, sans-serif;text-align:center; text-decoration: none;}
#link:hover {color: #CCCCCC}

#link, #link:hover {-webkit-transition: color 0.5s ease-out;-moz-transition: color 0.5s ease-out;-ms-transition: color 0.5s ease-out;-o-transition: color 0.5s ease-out;transition: color 0.5s ease-out;}

.btn-div {
	display: inline-block;
}

/** Loading **/
        @keyframes rotate-loading {
            0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
            100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
        }

        @-moz-keyframes rotate-loading {
            0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
            100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
        }

        @-webkit-keyframes rotate-loading {
            0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
            100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
        }

        @-o-keyframes rotate-loading {
            0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
            100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
        }

        @keyframes rotate-loading {
            0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
            100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
        }

        @-moz-keyframes rotate-loading {
            0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
            100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
        }

        @-webkit-keyframes rotate-loading {
            0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
            100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
        }

        @-o-keyframes rotate-loading {
            0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
            100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
        }

        @keyframes loading-text-opacity {
            0%  {opacity: 0}
            20% {opacity: 0}
            50% {opacity: 1}
            100%{opacity: 0}
        }

        @-moz-keyframes loading-text-opacity {
            0%  {opacity: 0}
            20% {opacity: 0}
            50% {opacity: 1}
            100%{opacity: 0}
        }

        @-webkit-keyframes loading-text-opacity {
            0%  {opacity: 0}
            20% {opacity: 0}
            50% {opacity: 1}
            100%{opacity: 0}
        }

        @-o-keyframes loading-text-opacity {
            0%  {opacity: 0}
            20% {opacity: 0}
            50% {opacity: 1}
            100%{opacity: 0}
        }
        .loading-container,
        .loading {
            height: 30px;
            position: relative;
            width: 30px;
            border-radius: 100%;
        }


        .loading-container {
        margin: auto;
        display: none;
        }

        .loading {
            border: 2px solid transparent;
            border-color: transparent #fff transparent #FFF;
            -moz-animation: rotate-loading 1.5s linear 0s infinite normal;
            -moz-transform-origin: 50% 50%;
            -o-animation: rotate-loading 1.5s linear 0s infinite normal;
            -o-transform-origin: 50% 50%;
            -webkit-animation: rotate-loading 1.5s linear 0s infinite normal;
            -webkit-transform-origin: 50% 50%;
            animation: rotate-loading 1.5s linear 0s infinite normal;
            transform-origin: 50% 50%;
        }

        .loading-container:hover .loading {
            border-color: transparent #E45635 transparent #E45635;
        }
        .loading-container:hover .loading,
        .loading-container .loading {
            -webkit-transition: all 0.5s ease-in-out;
            -moz-transition: all 0.5s ease-in-out;
            -ms-transition: all 0.5s ease-in-out;
            -o-transition: all 0.5s ease-in-out;
            transition: all 0.5s ease-in-out;
        }
        
	
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
	function checkLogin() {

		var obj = {
			"clientId" : $("#clientId").val(),
			"password" : $("#password").val()
		};
		$.ajax({
			url : "${path}/login",
			method : "POST",
			data : obj,
			success : function(responseData) {
				alert(responseData);
			}
		});
	}
</script>
</head>
<body>

	    <div class="container">
	        <div class="login-menu">
	            <div><a href="#" class="login-menu-selected" id="loginAccount">&nbsp;로그인&nbsp;</a></div>
	            <div class="float-right"><a href="#" id="findAccount">&nbsp;아이디/비밀번호 찾기&nbsp;</a></div>
	        </div>

	        <!-- 로그인 -->
	        <div class="login-container" id="loginAccountSelected">
	            <!-- 소셜 로그인 -->
	            <div class="social-wrap">
	                <a href="#"><img class="login login-radius" src="./images/google.png"></a><br>
	                <a href="/myapp/login/naver"><img class="login login-radius" src="./images/naver_btn.png"></a><br>
	                <a href="/myapp/login/kakao"><img class="login login-radius" src="./images/kakao_btn.png"></a><br>
	            </div>

	            <!-- 일반 로그인 -->
	            <div class="login-wrap-1 float-right">
	                <form>
	                    <div class="login">
	                        <input id="loginId" type="text" required>
	                        <label>아이디</label>
	                        <span></span>
	                    </div>
	                    <div class="login">
	                        <input id="loginPassword" type="password" required>
	                        <label>비밀번호</label>
	                        <span></span>
	                    </div>
	                    <div class="login login-radius"><button id="loginButton">로그인</button></div>
	                </form>
	                <div class="login-sub"><a class="login-sub-1" href="#">회원이 아니신가요? 지금 가입하세요!</a></div>
	                <div class="login-sub"><a class="login-sub-2" href="#">비회원 주문조회</a></div>
	            </div>
	        </div>

	        <!-- 아이디/비밀번호 찾기 -->
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

	<button onclick="javascript:location.href='/myapp/login/kakao'">kakao</button>
	<button onclick="javascript:location.href='/myapp/login/naver'">naver</button>
	
	<P>The time on the server is ${serverTime}.</P>
	<script>

	var array_banner = ["./images/v616_37.png", "./images/v616_38.png", "./images/v616_39.png", "./images/v616_40.png"];

	var popular1 = {
	    "name" : "닭가슴살 100g",
	    "price" : 1900,
	    "img" : "./images/v606_26.png"
	}

	var popular2 = {
	    "name" : "나이키 츄리닝 팬츠",
	    "price" : 63000,
	    "img" : "./images/v606_27.png"
	}

	var popular3 = {
	    "name" : "단백질 쉐이크 초코맛 2kg",
	    "price" : 68000,
	    "img" : "./images/v606_28.png"
	}

	var popular4 = {
	    "name" : "리스펙짐 헬스 이용권 (1개월)",
	    "price" : 55000,
	    "img" : "./images/v606_29.png"
	}

	var popular5 = {
	    "name" : "접이식 런닝머신",
	    "price" : 319900,
	    "img" : "./images/v606_30.png"
	}

	var array_popular = [popular1, popular2, popular3, popular4, popular5];

	var secondhand1 = {
	    "name" : "이고진 마에스트로 런닝머신",
	    "img" : "./images/v861_260.png"
	}

	var secondhand2 = {
	    "name" : "단백질 숯불갈비맛 새상품 9개 냉동",
	    "img" : "./images/v861_261.png"
	}

	var secondhand3 = {
	    "name" : "헬스장 스포짐 오목교점 9개월 양도합니다~!",
	    "img" : "./images/v861_262.png"
	}

	var secondhand4 = {
	    "name" : "자라 검은색 트레이닝복 팝니다 30",
	    "img" : "./images/v861_263.png"
	}

	var secondhand5 = {
	    "name" : "접이식 실내 자전거",
	    "img" : "./images/v861_264.png"
	}

	var array_secondhand = [secondhand1, secondhand2, secondhand3, secondhand4, secondhand5];

	// -----------

	var host = window.location.host + '/';
	var appPath = '/ounwan';
	var router = new Map([
		['/ounwan/html/login.html', '/' + appPath + '/clients/login']
	]);

	$(function() {
	    loadBanner(array_banner);
	    $("#populars").html(populars(array_popular));
	    $("#secondhands").html(secondhands(array_secondhand));

	    $("#findAccount").click(function() {
	        $("#findAccount").addClass("login-menu-selected");
	        $("#loginAccount").removeClass("login-menu-selected");
	        $("#loginAccountSelected").hide();
	        $("#findAccountSelected").show();
	    });

	    $("#loginAccount").click(function() {
	        $("#findAccount").removeClass("login-menu-selected");
	        $("#loginAccount").addClass("login-menu-selected");
	        $("#findAccountSelected").hide();
	        $("#loginAccountSelected").show();
	    });

	    $("#findIdEmail").on("input", function() {
	        var emails = [
	            '@naver.com',
	            '@gmail.com',
	            '@daum.net',
	            '@hanmail.net',
	            '@yahoo.com',
	            '@outlook.com',
	            '@nate.com',
	            '@kakao.com'
	        ];
	        if($(this).val().indexOf('@') > 1) {
	            const id = $(this).val().slice(0, $(this).val().indexOf('@'));
	            const mailAddress = $(this).val().slice($(this).val().indexOf('@'));
	            const htmltag = emails.reduce((a,b) => {
	                if(b.indexOf(mailAddress) > -1 && b != mailAddress) {
	                    return a + "<a class='mail-menu' href='javascript:mailSelected(" + '"' + id + b + '"' + ");'>" + id + b + "</a><br>";
	                } else {
	                    return a;
	                }
	            }, "");
	            $("#emailAutocomplete").html(htmltag);
	        } else {
	            $("#emailAutocomplete").html("");
	        }
	    });

	    $("#loginSelect").click(function() {
	        $.ajax({
	        	url : appPath + "/clients/login",
	        	type : 'GET',
	        	success : function() {
	        		$("body").html(loginPage);
	        	}
	        });
	    });

	    $("#findId").on("click", function() {
	        var obj = {
	            "name" : $("#findIdName").val(),
	            "email" :  $("#findIdEmail").val()
	        };
	        $.ajax({
	            url : appPath + '/clients/findId',
	            type : 'GET',
	            data : obj,
	            contentType : "text/plain;charset=utf-8",
	            dataType : "text",
	            success : function(res) {
	            	if(res != "") {
	            		var openWindow = window.open(appPath + "/findId?" + res,'','width=700px,height=500px,location=no,status=no');
	            	} else {
	            		alert("일치하는 회원 정보가 없습니다.");
	            	}	
	            },
	            error : function(request,status,error) {
	            	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	            }
	        })
	    })

	    $("#findPassword").on("click", function() {
	    	$("#findPassword").attr("disabled");
	    	$("#findPWBtnDiv").hide();
	    	$("#loading").show();
	        var obj = {
	            "clientId" : $("#findPwId").val(),
	            "email" : $("#findPwEmail").val()
	        }
	        $.ajax({
	            url : appPath + '/clients/findPassword',
	            type : 'GET',
	            data : obj,
	            contentType : "text/plain;charset=utf-8",
	            dataType : "text",
	            success : function(res) {
	            	if(res == '변경성공') {
	            		var openWindow = window.open(appPath + "/findPassword",'','width=700px,height=450px,location=no,status=no');
	                	$("body").html(loginPage);
	            	} else {
	            		$("#findPassword").removeAttr("disabled");
	            		$("#loading").hide();
	            		$("#findPWBtnDiv").show();
	            		alert("일치하는 회원 정보가 없습니다.");
	            	}
	            }
	        })
	        console.log(obj);
	    })

	    $("#loginButton").on("click", function() {
	        var userInfo = {
	            "clientId" : "jj1234",
	            "password" : "123456789",
	            "name" : "정진",
	            "email" : "jj@daum.net",
	            "birthday" : "2022-08-29",
	            "phone" : "010-1234-1234",
	            "address" : "서울 마포구 월드컵북로4길 77",
	            "address_detail" : "2호실",
	            "zip_code" : "03993",
	            "profile_url" : ""
	        };
	        if($("#loginId").val() == userInfo.clientId && $("#loginPassword").val() == userInfo.password) {
	            sessionStorage.setItem("userInfo", userInfo);
	            //location.href = "./";
	            alert(1);
	            console.log(sessionStorage.getItem("userInfo"));
	        }

	    })
	})

	function loadBanner(arr) {
	    var i = 0;
	    setInterval(function() {
	        i = (i + 1) % arr.length;
	        $("#main-banner").html("<img src = '" + arr[i] + "'>");
	    }, 3000);
	}

	function populars(arr) {
	    let tag = "";
	    for(let i = 0; i < arr.length; i++) {
	        let price = numberComma(arr[i].price) + "원";
	        tag += "<div class='pointer'>";
	        tag += "<img class='img-2 img-border' src= '" + arr[i].img + "'>";
	        tag += "<div>" + arr[i].name + "</div>";
	        tag += "<div>" + price + "</div>";
	        tag += "</div>";
	    }
	    return tag;
	}

	function secondhands(arr) {
	    let tag = "";
	    for(let i = 0; i < arr.length; i++) {
	        tag += "<div class='pointer'>";
	        tag += "<img class='img-2 img-border' src= '" + arr[i].img + "'>";
	        tag += "<div>" + arr[i].name + "</div>";
	        tag += "</div>";
	    }
	    return tag;
	}

	function numberComma(n) {
	    return n.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	}

	function mailSelected(mail) {
	    $("#email").val(mail);
	    $("#emailAutocomplete").html("");
	}

	var burger = $('.menu-trigger');

	burger.each(function(index){
	  var $this = $(this);
	  
	  $this.on('click', function(e){
	    e.preventDefault();
	    $(this).toggleClass('active-' + (index+1));
	    if($(this).attr("class") == 'menu-trigger') {
	        $(".nav-submenu").show();
	        $(".nav-menu").css("transform", "scaleY(0)");
	    } else {
	        $(".nav-submenu").hide();
	        $(".nav-menu").css("transform", "scaleY(1)");
	    }
	  })
	});

	var loginPage = `
	<header><a class="logo" href= "./"></a></header>

	    <div class="container">
	        <div class="login-menu">
	            <div><a href="#" class="login-menu-selected" id="loginAccount">&nbsp;로그인&nbsp;</a></div>
	            <div class="float-right"><a href="#" id="findAccount">&nbsp;아이디/비밀번호 찾기&nbsp;</a></div>
	        </div>

	        <!-- 로그인 -->
	        <div class="login-container" id="loginAccountSelected">
	            <!-- 소셜 로그인 -->
	            <div class="social-wrap">
	                <a href="#"><img class="login login-radius" src="./images/google.png"></a><br>
	                <a href="/myapp/login/naver"><img class="login login-radius" src="./images/naver_btn.png"></a><br>
	                <a href="/myapp/login/kakao"><img class="login login-radius" src="./images/kakao.png"></a><br>
	            </div>

	            <!-- 일반 로그인 -->
	            <div class="login-wrap-1 float-right">
	                <form>
	                    <div class="login">
	                        <input id="loginId" type="text" required>
	                        <label>아이디</label>
	                        <span></span>
	                    </div>
	                    <div class="login">
	                        <input id="loginPassword" type="password" required>
	                        <label>비밀번호</label>
	                        <span></span>
	                    </div>
	                    <div class="login login-radius"><button id="loginButton">로그인</button></div>
	                </form>
	                <div class="login-sub"><a class="login-sub-1" href="#">회원이 아니신가요? 지금 가입하세요!</a></div>
	                <div class="login-sub"><a class="login-sub-2" href="#">비회원 주문조회</a></div>
	            </div>
	        </div>

	        <!-- 아이디/비밀번호 찾기 -->
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
	    </div>`;
	</script>
</body>
</html>