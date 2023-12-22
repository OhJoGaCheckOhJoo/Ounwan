<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application" value="${pageContext.request.contextPath}" />
<header>
	<div class="header">
	    <a class="logo" href="${appPath}/"></a>
	    <c:if test="${userInfo.clientId eq null}">
	    	<div class="float-right">
                <a id="signUp" href="${appPath}/clients/signUp"></a>
                <a id="loginSelect" href="${appPath}/clients/login"></a>
                <button id="cart"></button>
                <c:if test="${cartList ne null}">
                	<div id="cartNotice"></div>
                </c:if>
            </div>
	    </c:if>
	    <c:if test="${userInfo.clientId ne null}">
	    	<div class="float-right">
                <a id="profileImage" href="#">
                    <img src="${appPath}/${userInfo.profileUrl }">
                </a>
                <span>${userInfo.name}님 환영합니다</span>
                <button id="cart"></button>
                <div id="cartNotice"></div>
            </div>
	    </c:if>
    </div>
</header>
