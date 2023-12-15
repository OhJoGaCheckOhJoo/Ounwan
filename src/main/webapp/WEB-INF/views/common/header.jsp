<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<header>
    <a class="logo" href="/myapp"></a>
    <c:if test="${clientInfo.clientId eq null}">
    	<div class="float-right">
	        <a href="./html/signup.html">회원가입</a>
	        <a class="pointer" id="loginSelect" href="${appPath}/clients/login">로그인</a>
	        <button class="pointer">Basket (#)</button>
	    </div>
    </c:if>
    <c:if test="${clientInfo.clientId ne null}">
    	<div class="float-right">
    		<div id="myProfile">
		        <img src="${clientInfo.profileURL}">
		        <span>${clientInfo.name}님 환영합니다!</span>
	        </div>
	        <button class="pointer">Basket (#)</button>
	    </div>
    </c:if>
</header>