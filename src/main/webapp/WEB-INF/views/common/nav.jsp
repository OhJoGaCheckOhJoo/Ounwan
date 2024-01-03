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
            <a href="${appPath}/coupung/products">오늘의 쿠펑</a>
            <div id="navSubmenu" class="nav-submenu">
            	<a href="${appPath}/coupung/products?categoryNum=1">의류</a>
            	<a href="${appPath}/coupung/products?categoryNum=2">건강 보조 식품</a>
            	<a href="${appPath}/coupung/products?categoryNum=4">헬스 이용권</a>
                <a href="${appPath}/coupung/products?categoryNum=3">운동 기구</a>
            </div>
        </div>
        <div>
            <a href="${appPath}/danggun/main">오늘의 당군</a>
            <div id="navSubmenu" class="nav-submenu">
                <a href="${appPath}/danggun/main">전체 보기</a>
                <a href="${appPath}/danggun/insert">상품 등록</a>
            </div>
        </div>
        <div>
            <a href="#">커뮤니티</a>
            <div id="navSubmenu" class="nav-submenu">
                <a class="ounwangram" href="${appPath}/community/ounwangram">운동했다그램</a>
                <a href="${appPath}/community/aetaBoard">애타</a>
            </div>
        </div>
        <div>
            <a href="${appPath}/faq">고객센터</a>
            <div id="navSubmenu" class="nav-submenu">
                <a href="${appPath}/faq">FAQ</a>
                <c:if test="${admin eq null }">
                	<a href="#" id="adminChat">솜솜이</a>
                </c:if>
            </div>
        </div>
    </div>
    <div id="navMenu" class="nav-menu">
        <div>
            <div>
                <a href="${appPath}/coupung/products?categoryNum=1">의류</a>
            	<a href="${appPath}/coupung/products?categoryNum=2">건강 보조 식품</a>
            	<a href="${appPath}/coupung/products?categoryNum=4">헬스 이용권</a>
                <a href="${appPath}/coupung/products?categoryNum=3">운동 기구</a>
            </div>
            <div>
                <a href="${appPath}/danggun/main">전체 보기</a>
                <a href="${appPath}/danggun/insert">상품 등록</a>
            </div>
            <div>
                <a class="ounwangram" href="${appPath}/community/ounwangram">오운완 커뮤니티</a>
                <a href="${appPath}/community/aetaBoard">고민 게시판</a>
            </div>
            <div>
                <a href="${appPath}/faq">FAQ</a>
                <c:if test="${admin eq null }">
                	<a href="#" id="adminChat">솜솜이</a>
                </c:if>
            </div>
        </div>
    </div>
</nav>
<script>
$("#adminChat").on("click",function(e){
	e.preventDefault();
	if(!"${userInfo.clientId}"){
		alert("로그인을 해주세요!");
		location.href = "${appPath}/clients/login";
	}else{
		window.open("${appPath}/somsomi/chat","/chat/somsomiChat","width=500, height=800, top=200, left=200");
	}
});
</script>
