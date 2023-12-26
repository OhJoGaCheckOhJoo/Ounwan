<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="appPath" scope="application"
	value="${pageContext.request.contextPath}" />
<nav>
    <div class="nav-main">
        <div class="pointer">
            <a id="hamberger-btn" class="menu-trigger">
                <span></span>
                <span></span>
                <span></span>
            </a>
        </div>
        <div>
            <a href="${appPath}/coupung/products">쇼핑몰</a>
            <div id="navSubmenu" class="nav-submenu">
                <a href="#">운동 기구</a>
                <a href="#">건강 보조 식품</a>
                <a href="#">헬스 이용권</a>
                <a href="#">의류</a>
            </div>
        </div>
        <div>
            <a href="${appPath}/danggun/main">중고거래</a>
            <div id="navSubmenu" class="nav-submenu">
                <a href="${appPath}/danggun/main">전체 보기</a>
                <a href="#">관심 상품</a>
            </div>
        </div>
        <div>
            <a href="#">커뮤니티</a>
            <div id="navSubmenu" class="nav-submenu">
                <a class="ounwangram" href="${appPath}/community/ounwangram">오운완 커뮤니티</a>
                <a href="${appPath}/community/aetaBoards">고민 게시판</a>
            </div>
        </div>
        <div>
            <a href="#" id="adminChat">고객센터</a>
            <div id="navSubmenu" class="nav-submenu">
                <a href="#">상품문의</a>
                <a href="#">배송문의</a>
                <a href="#">중고거래</a>
                <a href="#">커뮤니티</a>
            </div>
        </div>
    </div>
    <div id="navMenu" class="nav-menu">
        <div>
            <div>
                <a href="#">운동 기구</a>
                <a href="#">건강 보조 식품</a>
                <a href="#">헬스 이용권</a>
                <a href="#">의류</a>
            </div>
            <div>
                <a href="${appPath}/danggun/main">전체 보기</a>
                <a href="#">관심 상품</a>
            </div>
            <div>
                <a class="ounwangram" href="${appPath}/community/ounwangram">오운완 커뮤니티</a>
                <a href="${appPath}/community/aetaBoards">고민 게시판</a>
            </div>
            <div>
                <a href="#" id="chat">상품문의</a>
                <a href="#">배송문의</a>
                <a href="#">중고거래</a>
                <a href="#">커뮤니티</a>
            </div>
        </div>
    </div>
</nav>

