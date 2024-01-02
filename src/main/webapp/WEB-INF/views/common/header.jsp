<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application" value="${pageContext.request.contextPath}" />
<header>
	<div class="header">
	    <a class="logo" href="${appPath}/"></a>
	    <c:if test="${userInfo.clientId eq null and admin eq null}">
	    	<div class="float-right">
                <a id="signUp" href="${appPath}/clients/signUp"></a>
                <a id="loginSelect" href="${appPath}/clients/login"></a>
                <button id="cart" onClick="location.href='${appPath}/coupung/cart'"></button>
                <c:if test="${cartList ne null}">
                	<div id="cartNotice"></div>
                </c:if>
            </div>
	    </c:if>
	    <c:if test="${userInfo.clientId ne null and admin eq null}">
	    	<div class="float-right">
                <a id="profileImage" href="#">
                    <img src="${userInfo.profileUrl }">
                </a>
                <span>${userInfo.name}님 환영합니다</span>
                <button id="cart" onClick="location.href='${appPath}/coupung/cart'"></button>
                <div id="cartNotice"></div>
                <div id="userAction">
                	<a href="${appPath }/myPage">마이페이지</a>
                	<a href="#" id="logoutBtn">로그아웃</a>
                </div>
            </div>
	    </c:if>
	    <c:if test="${userInfo.clientId eq null and admin ne null}">
	    	<div class="float-right">
                <a id="profileImage" href="#">
                    <img src="${userInfo.profileUrl }">
                </a>
                <span>관리자님 안녕하세요.</span>
                <div id="userAction">
                	<a href="${appPath}/admin/main.do">admin go</a>
                </div>
            </div>
	    </c:if>
    </div>
</header>