<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="${appPath}/css/main.css" rel="stylesheet">
<header>
	<a class="logo" href="#"></a>
	<div class="float-right">
		<a href="${appPath}/clients/signUp">회원가입</a>
		<a class="pointer" id="loginSelect" href="${appPath}/clients/login">로그인</a>
		<!--# : DB(회원)/세션(비회원)에서 가져올 것-->
		<button class="pointer">Basket (#)</button>
	</div>
</header>
