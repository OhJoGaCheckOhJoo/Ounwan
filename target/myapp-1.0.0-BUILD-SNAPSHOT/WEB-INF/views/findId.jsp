<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>오운완 회원 안내</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style>
		:root {
			--main-color: #2E3C8A;
		}
		* {
			margin: 0px;
			padding: 0px;
			overflow: hidden;
		}
		body {
			width: 600px;
			height: 400px;
			padding: 0px 25px 50px 25px;
			margin: 30px;
		}
		hr {
			border: 3px solid black;
			margin: 20px 0px 20px 0px;
			border-radius: 5px;
		}
		div {
			text-align: center;
			margin: 40px 0px 40px 0px;
		}
		h1 {
			margin-left: 10px;
			font-size: 32px;
			font-weight: 1000;
		}
		button {
			width: 180px;
			height: 60px;
			padding: 10px 20px 10px 20px;
			border-radius: 20px;
			font-size: 16px;
			cursor: pointer;
			margin: 0px 20px 0px 20px;
			border: 2px solid var(--main-color);
		}
		.font-1 {
			font-size: 28px;
			margin: 20px 0px 20px 0px;
		}
		.font-2 {
			font-size: 16px;
			margin: 0px;
			color: #aaa;
		}
		.bold {
			font-weight: 1000;
		}
		.margin-1 {
			margin-bottom: 10px;
		}
		.margin-2 {
			margin: 20px 0px 20px 0px;
		}
		.button-1 {
			background-color: #fff;
		}
		.button-2 {
			background-color: var(--main-color);
			color: #fff;
		}
	</style>
</head>
<body>
	<h1>오운완 회원 안내</h1>
	<hr>
	<div class="margin-2">
		<div class="font-1"><span></span>님 가입하신 아이디입니다.</div>
		<div class="font-1 bold" id="idResult"></div>
		<div class="margin-1">
			<div class="font-2">*비밀번호가 생각나지 않으실 경우</div>
			<div class="font-2">임시비밀번호를 통해 재설정하실 수 있습니다.</div>
		</div>
	</div>
	<hr>
	<div class="margin-2">
		<button class="button-1">임시비밀번호 발급</button>
		<button class="button-2" onclick="window.close()">확인</button>
	</div>
	<script>
		var url = decodeURIComponent(window.location.href);
		var name = url.slice(url.indexOf('?') + 1, url.indexOf('@'));
		var id = url.slice(url.indexOf('@') + 1);
		$("#idResult").html(id);
		$("span").html(name);
	</script>
</body>
</html>